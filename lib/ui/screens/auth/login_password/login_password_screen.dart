import 'package:ajhman/data/model/auth/auth_login_user_request.dart';
import 'package:ajhman/data/bloc/auth/auth_screen_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../utils/app_locale.dart';
import '../../../theme/color/colors.dart';
import '../../../theme/text/text_styles.dart';
import '../../../theme/widget/app_buttons_style.dart';
import '../../../widgets/button/primary_button.dart';
import '../../../widgets/text_field/mobile_number_text_field.dart';
import '../../../widgets/text_field/primary_text_field.dart';

class LoginPasswordScreen extends StatefulWidget {

  const LoginPasswordScreen({
    super.key,

  });

  @override
  State<LoginPasswordScreen> createState() => _LoginPasswordScreenState();
}

class _LoginPasswordScreenState extends State<LoginPasswordScreen> {
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _errorPhoneNumber = false;
  bool _errorPassword = false;
  bool _validPhoneNumber = false;
  bool _validPassword = false;

  @override
  void initState() {
    // _errorPhoneNumber = widget.error;
    // _errorPassword = widget.error;
    // _phoneNumber.text = widget.phoneNumber;
    //
    // if (_phoneNumber.length == 11) {
    //   _validPhoneNumber = true;
    // } else {
    //   _validPhoneNumber = false;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                ChangeLocale(context).appLocal!.pleaseEnterMobileNumber,
                style: AppTextStyles.body1,
              ),
            ),
            MobileNumberTextField(
              hint: "09*********",
              error: _errorPhoneNumber,
              textEditingController: _phoneNumber,
              onChange: (s) {
                setState(() {
                  _errorPhoneNumber = false;

                  if (s.isNotEmpty) {
                    if (s.startsWith("09")) {
                      _errorPhoneNumber = false;
                      if (s.length == 11) {
                        _validPhoneNumber = true;
                      } else {
                        _validPhoneNumber = false;
                      }
                    } else {
                      _errorPhoneNumber = true;
                    }
                  } else {
                    _errorPhoneNumber = true;
                  }
                });
              },
            ),
            Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                PrimaryTextField(
                  hint: "Password",
                  textEditingController: _password,
                  onChange: (s) {
                    setState(() {
                      _errorPassword = false;

                      if (s.isNotEmpty) {
                        if (s.length >= 8) {
                          _validPassword = true;
                        } else {
                          _validPassword = false;
                        }
                      } else {
                        _errorPassword = true;
                      }
                    });
                  },
                ),
              ],
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Assets.icon.outline.login
                        .svg(color: primaryColor, width: 16),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(ChangeLocale(context).appLocal!.loginWithOtp),
                  ],
                ))
          ],
        ),
        SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              title: ChangeLocale(context).appLocal!.continues,
              onClick: _validPassword && _validPhoneNumber
                  ? () {
                      // context.read<AuthScreensBloc>().add(AuthPostLoginEvent(
                      //     AuthLoginUserRequest(
                      //         mobileNumber: _phoneNumber.text,
                      //         password: _password.text)));
                    }
                  : _validPhoneNumber
                      ? () {
                          // context
                          //     .read<AuthScreensBloc>()
                          //     .add(AuthGetOtpEvent(_phoneNumber.text));
                        }
                      : null,
            ))
      ],
    );
  }
}
