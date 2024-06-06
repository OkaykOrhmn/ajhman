import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/button/outlined_primary_button.dart';
import 'package:ajhman/ui/widgets/button/primary_button.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gif/gif.dart';
import 'dart:io';
import '../../../gen/assets.gen.dart';

class DialogHandler {
  static ThemeData themeData = Theme.of(mContext);

  static Future<void> showErrorDialog(
      String title, String btnTitle, Function()? onTap) async {
    await showDialog(
      barrierDismissible: false,
      context: mContext,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.all(16),
        shape: const RoundedRectangleBorder(
            borderRadius: DesignConfig.highBorderRadius),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    padding: EdgeInsets.all(6),
                    child: Assets.icon.bold.closeCircle.svg()),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: PrimaryText(
                    text: title,
                    style: themeData.textTheme.dialogTitle,
                    color: Colors.black),
              ),
              Container(
                  width: MediaQuery.sizeOf(context).width / 2,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: PrimaryButton(
                    title: btnTitle,
                    onClick: onTap,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> showExitBottomSheet() async {
    await showModalBottomSheet(
        context: mContext,
        useSafeArea: true,
        builder: (context) {
          return Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 5,
                    width: MediaQuery.sizeOf(context).width / 4,
                    margin: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: DesignConfig.highBorderRadius,
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  PrimaryText(
                      text: "قصد خارج شدن از برنامه را دارید؟",
                      style: themeData.textTheme.titleBold,
                      color: Colors.black),
                  Gif(
                    image: Assets.gif.exit.provider(),
                    autostart: Autostart.loop,
                    width: MediaQuery.sizeOf(context).width / 1.3,
                    height: MediaQuery.sizeOf(context).width / 1.3,
                  ),
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.sizeOf(context).width / 2,
                          padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
                          child: PrimaryButton(
                            title: "بله",
                            onClick: () {
                              if (Platform.isAndroid) {
                                SystemNavigator.pop();
                              } else if (Platform.isIOS) {
                                exit(0);
                              }
                            },
                          )),
                      Container(
                          width: MediaQuery.sizeOf(context).width / 2,
                          padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                          child: OutlinedPrimaryButton(
                            title: "خیر",
                            onClick: () {
                              pop();
                            },
                          ))
                    ],
                  ),
                ],
              ),
            ],
          );
        });
  }

  static void pop() {
    Navigator.of(mContext).pop();
  }
}
