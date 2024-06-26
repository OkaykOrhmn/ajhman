import 'dart:io';

import 'package:ajhman/core/services/permission_handler.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/app_bar/reversible_app_bar.dart';
import 'package:ajhman/ui/widgets/button/primary_button.dart';
import 'package:ajhman/ui/widgets/loading/three_bounce_loading.dart';
import 'package:ajhman/ui/widgets/states/empty_screen.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:file_manager/file_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> openFileManager() async {
    final directory = Directory("/storage/emulated/0/Download");
    if (await canLaunchUrl(directory!.uri)) {
      await launchUrl(directory!.uri);
    } else {
      // Handle the case where the URL cannot be launched
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("getCurrentDirectory: ${controller.getCurrentPath}");
        print("isRootDirectory: ${await controller.isRootDirectory()}");
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
                            await OpenFile.open(entities[index].path);
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
                            children: [
                              FileManager.basename(entities[index])
                                      .endsWith('.mp3')
                                  ? const Icon(Icons.music_video_outlined)
                                  : FileManager.basename(entities[index])
                                          .endsWith('.mp4')
                                      ? const Icon(
                                          Icons.ondemand_video_outlined)
                                      : FileManager.isFile(entities[index])
                                          ? const Icon(Icons.feed_outlined)
                                          : const Icon(
                                              Icons.folder_open_outlined),
                              SizedBox(
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
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: PrimaryButton(
            //     title: "بازکردن در فایل ها",
            //     onClick: () async {
            //       await openFileManager();
            //       // await OpenFile.open(
            //       //     '/storage/emulated/0/Android/data/com.example.ajhman/files/downloads');
            //     },
            //     fill: true,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
