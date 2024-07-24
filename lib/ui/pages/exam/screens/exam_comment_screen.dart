import 'package:ajhman/ui/theme/colors.dart';
import 'package:ajhman/ui/theme/text_styles.dart';
import 'package:ajhman/ui/theme/design_config.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/material.dart';

class ExamCommentScreen extends StatelessWidget {
  final TextEditingController comment;
  const ExamCommentScreen({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: PrimaryText(
              text:
                  "فراگیر محترم، لطفا آموخته‌های خود را پیرامون محتواهای ارائه شده در این دوره در کادر زیر وارد کنید. به منظور دسترسی به دوره‌های آتی تکمیل این بخش الزامی است.",
              style: Theme.of(context).textTheme.title,
              color: Theme.of(context).progressText()),
        ),
        TextField(
          controller: comment,
          style: Theme.of(context).textTheme.searchHint,
          maxLength: 2000,
          minLines: 10,
          maxLines: 20,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: 'متن خود را وارد کنید',
            counterStyle: Theme.of(context).textTheme.searchHint,
            hintStyle: Theme.of(context).textTheme.searchHint,
            fillColor: Theme.of(context).primaryColor,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
              borderRadius: DesignConfig.highBorderRadius,
            ),
            border: const OutlineInputBorder(
              borderRadius: DesignConfig.highBorderRadius,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: PrimaryText(
              text: "حداقل 5 حرف بنویسید!!",
              style: Theme.of(context).textTheme.title,
              color: Theme.of(context).progressText(),
              textAlign: TextAlign.start),
        )
      ],
    );
  }
}
