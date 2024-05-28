import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_btn/loading_btn.dart';

import '../../../../../core/bloc/auth/auth_screen_bloc.dart';
import '../../../../../core/bloc/otp/otp_bloc.dart';
import '../../../../../core/utils/app_locale.dart';
import '../../../../../data/model/auth/auth_login_user_request.dart';
import '../../../../theme/text/text_styles.dart';
import '../../../../theme/widget/app_buttons_style.dart';
import '../../../../widgets/button/loading_btn.dart';
import '../../../../widgets/text_field/password_text_field.dart';
import '../../../../widgets/text_field/primary_text_field.dart';
import '../../../home/home_page.dart';

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
    return BlocConsumer<OtpBloc, OtpState>(
      listener: (context, state) {
        if (state.otpStatus == OtpStatus.success) {
          Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(builder: (context) {
            return const HomePage();
          }), ModalRoute.withName("/LoginPasswordScreen"));
        } else if (state.otpStatus == OtpStatus.error) {
          setState(() {
            if (state.message == "Not Found") {
              _errorPhoneNumber = true;
              _validPhoneNumber = false;
            } else {
              _errorPassword = true;
              _validPassword = false;
            }
            state.otpStatus = OtpStatus.start;

          });
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            fields(context),
            PrimaryLoadingButton(
                disable: (!_validPassword || !_validPhoneNumber) ||
                    (_errorPhoneNumber || _errorPassword),
                title: ChangeLocale(context).appLocal!.continues,
                onTap: (Function startLoading, Function stopLoading,
                    ButtonState btnState) async {
                  if (btnState == ButtonState.idle) {
                    startLoading();
                    AuthLoginUserRequest request = AuthLoginUserRequest(
                        mobileNumber: _phoneNumber.text,
                        password: _password.text);
                    context.read<OtpBloc>().add(PostUserEvent(request));
                    await Future.delayed(const Duration(seconds: 1));
                    stopLoading();
                  }
                })
          ],
        );
      },
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
          error: !_validPhoneNumber || _errorPhoneNumber,
          errorHint:
              "${ChangeLocale(context).appLocal!.username} ${ChangeLocale(context).appLocal!.wrong}",
          onChange: (s) {
            setState(() {
              _errorPhoneNumber = false;
              if (s.length >= 3) {
                _validPhoneNumber = true;
              } else {
                _validPhoneNumber = false;
              }
            });
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
          error: !_validPassword || _errorPassword,
          onChange: (s) {
            setState(() {
              _errorPassword = false;

              if (s.length >= 6) {
                _validPassword = true;
              } else {
                _validPassword = false;
              }
            });
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
