import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/utils/app_locale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../gen/assets.gen.dart';
import '../../theme/text/text_styles.dart';

class MobileNumberTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hint;
  final bool error;
  final Function(String) onChange;

  const MobileNumberTextField(
      {super.key,
      required this.textEditingController,
      required this.hint,
      required this.onChange,  this.error = false});

  @override
  State<MobileNumberTextField> createState() => _MobileNumberTextFieldState();
}

class _MobileNumberTextFieldState extends State<MobileNumberTextField> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        controller: widget.textEditingController,
        style: AppTextStyles.primaryTextFieldText,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        maxLength: 11,
        onChanged: (val) {
          setState(() {
            widget.onChange(val);
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
          suffixIconColor:  widget.error  ? errorMain : primaryColor,
          errorText:  widget.error
              ? ChangeLocale(context).appLocal!.textFieldEnterNumberError
              : null,
          filled: true,
          hintText: widget.hint,
          fillColor: backgroundColor200,
          hintStyle: AppTextStyles.primaryTextFieldHint,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: errorMain),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: errorMain),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
