import 'package:ajhman/ui/theme/colors.dart';
import '../../../../core/utils/app_locale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/text_styles.dart';
import '../../theme/design_config.dart';

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
          suffixIconColor:
              widget.error ? errorMain : Theme.of(context).primaryColor,
          errorText: widget.error
              ? ChangeLocale(context).appLocal!.textFieldEnterNumberError
              : null,
          filled: true,
          hintText: ChangeLocale(context).appLocal!.enterNumberHint.toString(),
          fillColor: Theme.of(context).editTextFilledAuth(),
          hintStyle: AppTextStyles.primaryTextFieldHint,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: DesignConfig.mediumBorderRadius,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: DesignConfig.mediumBorderRadius,
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: errorMain),
            borderRadius: DesignConfig.mediumBorderRadius,
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: errorMain),
            borderRadius: DesignConfig.mediumBorderRadius,
          ),
        ),
        style: Theme.of(context)
            .textTheme
            .searchHint
            .copyWith(color: Theme.of(context).editTextFont()),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        maxLength: 11,
      ),
    );
  }
}
