import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/button/primary_button.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../gen/assets.gen.dart';

class DialogHandler {
  static BuildContext context = navigatorKey.currentContext!;
  static ThemeData themeData = Theme.of(context);

  static Future<void> showErrorDialog(
      String title, String btnTitle, Function()? onTap) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Container(
                    decoration: BoxDecoration(
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

  static void pop() {
    Navigator.of(context).pop();
  }
}
