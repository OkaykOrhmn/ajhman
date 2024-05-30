import 'package:ajhman/ui/theme/color/colors.dart';
import '../../../../core/utils/app_locale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../gen/assets.gen.dart';
import '../../theme/text/text_styles.dart';
import '../../theme/widget/design_config.dart';

class PrimaryTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hint;
  final Function(String) onChange;
  final bool error;
  final String errorHint;

  const PrimaryTextField(
      {super.key,
      required this.textEditingController,
      required this.hint,
      required this.onChange,  this.error = false, this.errorHint = ""});

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        controller: widget.textEditingController,
        style: AppTextStyles.primaryTextFieldText,
        onChanged: (val) {
          setState(() {
            try {
              widget.onChange(val);
            } catch (ex) {}
          });
        },
        decoration: InputDecoration(
          suffixIcon: widget.textEditingController.text.isNotEmpty
              ? InkWell(
                  onTap: () {
                    setState(() {
                      widget.textEditingController.clear();
                    });
                  },
                  child: const Icon(
                    CupertinoIcons.xmark,
                    size: 12,
                  ),
                )
              : null,
          suffixIconColor: widget.error ? errorMain : primaryColor,
          errorText: widget.error
              ? widget.errorHint
              : null,
          filled: true,
          hintText: widget.hint,
          fillColor: backgroundColor200,
          hintStyle: AppTextStyles.primaryTextFieldHint,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryColor),
            borderRadius: DesignConfig.mediumBorderRadius,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: DesignConfig.mediumBorderRadius,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: errorMain),
            borderRadius: DesignConfig.mediumBorderRadius,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: errorMain),
            borderRadius: DesignConfig.mediumBorderRadius,
          ),
        ),
      ),
    );
  }
}
