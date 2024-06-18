import 'package:ajhman/ui/theme/color/colors.dart';
import '../../../../core/utils/app_locale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../gen/assets.gen.dart';
import '../../theme/text/text_styles.dart';
import '../../theme/widget/design_config.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hint;
  final Function(String) onChange;
  final bool error;

  const PasswordTextField(
      {super.key,
      required this.textEditingController,
      required this.hint,
      required this.onChange,
      this.error = false});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _passwordVisible = false;

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
        keyboardType: TextInputType.visiblePassword,
        obscureText: _passwordVisible,
        obscuringCharacter: "*",
        decoration: InputDecoration(
          suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
                child: _passwordVisible
                    ? Assets.icon.outline.eye.svg(width: 24, height: 24 ,color:  widget.error ? errorMain : grayColor200)
                    : Assets.icon.outline.eyeSlash.svg(width: 24, height: 24, color:  widget.error ? errorMain : grayColor200),
              )),
          errorText: widget.error
              ? "${ChangeLocale(context).appLocal!.password} ${ChangeLocale(context).appLocal!.wrong}"
              : null,
          filled: true,
          hintText: widget.hint,
          fillColor: backgroundColor200,
          hintStyle: AppTextStyles.primaryTextFieldHint,
          focusedBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
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
