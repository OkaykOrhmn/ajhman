// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package

import 'dart:io';

import 'package:ajhman/ui/theme/colors.dart';
import 'package:ajhman/ui/theme/text_styles.dart';
import 'package:ajhman/ui/theme/design_config.dart';
import 'package:ajhman/ui/widgets/app_bar/reversible_app_bar.dart';
import 'package:ajhman/ui/widgets/loading/three_bounce_loading.dart';
import 'package:ajhman/ui/widgets/states/empty_screen.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:open_app_file/open_app_file.dart';

import '../../../gen/assets.gen.dart';

class FileManagerPage extends StatefulWidget {
  const FileManagerPage({super.key});

  @override
  State<FileManagerPage> createState() => _FileManagerPageState();
}

class _FileManagerPageState extends State<FileManagerPage> {
  final FileManagerController controller = FileManagerController();

  @override
  void initState() {
    FileManager.requestFilesAccessPermission();
    controller.setCurrentPath =
        '/storage/emulated/0/Android/data/com.example.ajhman/files/downloads';

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.getCurrentPath ==
            '/storage/emulated/0/Android/data/com.example.ajhman/files/downloads') {
          return true;
        } else {
          await controller.goToParentDirectory();
          return false;
        }
      },
      child: Scaffold(
        appBar: const ReversibleAppBar(title: 'لیست ذخیره‌ شده‌ها'),
        backgroundColor: Theme.of(context).background(),
        body: Column(
          children: [
            Expanded(
              child: FileManager(
                controller: controller,
                emptyFolder: const Center(child: EmptyScreen()),
                errorBuilder: (context, error) {
                  return const Center(child: EmptyScreen());
                },
                loadingScreen: const ThreeBounceLoading(),
                builder: (context, snapshot) {
                  final List<FileSystemEntity> entities = snapshot;
                  return ListView.builder(
                    itemCount: entities.length,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          if (FileManager.isDirectory(entities[index])) {
                            controller.openDirectory(
                                entities[index]); // open directory
                          } else {
                            // Perform file-related tasks.
                            await OpenAppFile.open(entities[index].path);
                            // await openFile(entities[index].path);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).white(),
                              borderRadius: DesignConfig.highBorderRadius,
                              boxShadow: DesignConfig.lowShadow),
                          margin: const EdgeInsetsDirectional.symmetric(
                              horizontal: 16, vertical: 8),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FileManager.basename(entities[index])
                                      .endsWith('.mp3')
                                  ? Assets.icon.bold.microphone.svg(
                                      color: Theme.of(context).primaryColor,
                                    )
                                  : FileManager.basename(entities[index])
                                          .endsWith('.mp4')
                                      ? Assets.icon.bold.video.svg(
                                          color: Theme.of(context).primaryColor,
                                        )
                                      : FileManager.basename(entities[index])
                                                  .toLowerCase()
                                                  .endsWith('.png') ||
                                              FileManager.basename(
                                                      entities[index])
                                                  .toLowerCase()
                                                  .endsWith('.jpg')
                                          ? Assets.icon.bold.gallery.svg(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )
                                          : FileManager.isFile(entities[index])
                                              ? Assets.icon.bold.documentText
                                                  .svg(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                )
                                              : Assets.icon.bold.exam.svg(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: PrimaryText(
                                    text: FileManager.basename(entities[index]),
                                    style: Theme.of(context).textTheme.title,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    color: Theme.of(context).cardText()),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
