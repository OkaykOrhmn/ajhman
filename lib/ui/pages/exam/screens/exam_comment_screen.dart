import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExamCommentScreen extends StatelessWidget {
  final TextEditingController comment ;
  const ExamCommentScreen({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: PrimaryText(
              text:
                  "فراگیر محترم، لطفا آموخته‌های خود را پیرامون محتواهای ارائه شده در این دوره در کادر زیر وارد کنید. به منظور دسترسی به دوره‌های آتی تکمیل این بخش الزامی است.",
              style: mThemeData.textTheme.title,
              color: grayColor900),
        ),
        TextField(
          controller: comment,
          style: mThemeData.textTheme.searchHint,
          maxLength: 2000,
          minLines: 10,
          maxLines: 20,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: 'متن خود را وارد کنید',
            counterStyle: mThemeData.textTheme.searchHint,
            hintStyle: mThemeData.textTheme.searchHint,
            fillColor: primaryColor,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryColor,),
              borderRadius: DesignConfig.highBorderRadius,
            ),
            border: OutlineInputBorder(
              borderRadius: DesignConfig.highBorderRadius,
            ),
          ),
        ),
      ],
    );
  }
}
