import 'package:ajhman/data/bloc/auth/auth_screen_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_btn/loading_btn.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../utils/app_locale.dart';
import '../../../theme/color/colors.dart';
import '../../../theme/text/text_styles.dart';
import '../../../theme/widget/app_buttons_style.dart';
import '../../../widgets/button/loading_btn.dart';
import '../../../widgets/button/primary_button.dart';
import '../../../widgets/text_field/mobile_number_text_field.dart';
import '../../../widgets/text_field/password_text_field.dart';
import '../../../widgets/text_field/primary_text_field.dart';

class LoginPasswordScreen extends StatefulWidget {
  const LoginPasswordScreen({
    super.key,
  });

  @override
  State<LoginPasswordScreen> createState() => _LoginPasswordScreenState();
}

class _LoginPasswordScreenState extends State<LoginPasswordScreen> {
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _errorPhoneNumber = false;
  bool _errorPassword = false;
  bool _validPhoneNumber = false;
  bool _validPassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        fields(context),
        PrimaryLoadingButton(
            disable: false,
            title: ChangeLocale(context).appLocal!.continues,
            onTap: (Function startLoading, Function stopLoading,
                ButtonState btnState) async {
              if (btnState == ButtonState.idle) {
                startLoading();

                await Future.delayed(const Duration(seconds: 1));
                stopLoading();
              }
            })
      ],
    );
  }

  Column fields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            ChangeLocale(context).appLocal!.username,
            style: AppTextStyles.body1,
          ),
        ),
        PrimaryTextField(
          hint: ChangeLocale(context).appLocal!.pleaseEnterUsername.toString(),
          textEditingController: _phoneNumber,
          onChange: (s) {
            setState(() {});
          },
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            ChangeLocale(context).appLocal!.password,
            style: AppTextStyles.body1,
          ),
        ),
        PasswordTextField(
          hint: ChangeLocale(context).appLocal!.pleaseEnterPassword.toString(),
          textEditingController: _password,
          onChange: (s) {
            setState(() {});
          },
        ),
        const SizedBox(
          height: 16,
        ),
        TextButton(
            style: AppButtonsStyle.linkPrimaryTextButton,
            onPressed: () {
              setState(() {
                context.read<AuthScreensBloc>().add(AuthNavigateOtpEvent());
              });
            },
            child: Text(ChangeLocale(context).appLocal!.forgetPassword))
      ],
    );
  }
}
