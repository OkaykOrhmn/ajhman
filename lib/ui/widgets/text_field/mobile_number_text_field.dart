import 'package:ajhman/ui/theme/color/colors.dart';
import '../../../../core/utils/app_locale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/text/text_styles.dart';
import '../../theme/widget/design_config.dart';

class MobileNumberTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final bool error;
  final bool readOnly;
  final Function(String) onChange;

  const MobileNumberTextField(
      {super.key,
      required this.textEditingController,
      required this.onChange,
      this.error = false,
      this.readOnly = false});

  @override
  State<MobileNumberTextField> createState() => _MobileNumberTextFieldState();
}

class _MobileNumberTextFieldState extends State<MobileNumberTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        readOnly: widget.readOnly,
        controller: widget.textEditingController,
        onChanged: (val) {
          setState(() {
            widget.onChange(val);
          });
        },

        decoration: InputDecoration(
          counterText: "",
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
              ? ChangeLocale(context).appLocal!.textFieldEnterNumberError
              : null,
          filled: true,
          hintText: ChangeLocale(context).appLocal!.enterNumberHint.toString(),
          fillColor: backgroundColor200,
          hintStyle: AppTextStyles.primaryTextFieldHint,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryColor),
            borderRadius:DesignConfig.mediumBorderRadius,
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
        style: AppTextStyles.primaryTextFieldText,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        maxLength: 11,

      ),
    );
  }
}
