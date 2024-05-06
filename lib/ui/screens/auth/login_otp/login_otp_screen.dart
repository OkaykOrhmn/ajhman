import 'package:ajhman/data/bloc/otp/otp_bloc.dart';
import 'package:ajhman/data/bloc/auth/auth_screen_bloc.dart';
import 'package:ajhman/ui/widgets/button/loading_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:pinput/pinput.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../utils/app_locale.dart';
import '../../../theme/color/colors.dart';
import '../../../theme/text/text_styles.dart';
import '../../../theme/widget/app_buttons_style.dart';
import '../../../widgets/text_field/mobile_number_text_field.dart';

class LoginOtpScreen extends StatefulWidget {
  const LoginOtpScreen({
    super.key,
  });

  @override
  State<LoginOtpScreen> createState() => _LoginOtpScreenState();
}

class _LoginOtpScreenState extends State<LoginOtpScreen> {
  final TextEditingController _phoneNumber = TextEditingController();
  bool _errorPhoneNumber = false;
  bool _validPhoneNumber = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    if (_phoneNumber.length == 11) {
      _validPhoneNumber = true;
    } else {
      _validPhoneNumber = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpBloc, OtpState>(
      listener: (context, state) {
        if (state.otpStatus == OtpStatus.success) {
          context
              .read<AuthScreensBloc>()
              .add(AuthNavigatePinEvent(phoneNumber: _phoneNumber.text));
          context.read<OtpBloc>().add(NavigatePinEvent());
        } else if (state.otpStatus == OtpStatus.error) {
          setState(() {
            _errorPhoneNumber = true;
            _validPhoneNumber = false;
          });
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            fields(context),
            PrimaryLoadingButton(
                disable: !(_validPhoneNumber && !_errorPhoneNumber),
                title: ChangeLocale(context).appLocal!.continues,
                onTap: (Function startLoading, Function stopLoading,
                    ButtonState btnState) async {
                  if (_validPhoneNumber && !_errorPhoneNumber) {
                    if (btnState == ButtonState.idle) {
                      startLoading();
                      _loading = true;
                      context
                          .read<OtpBloc>()
                          .add(GetOtpEvent(_phoneNumber.text));
                      await context.read<OtpBloc>().stream.firstWhere((state) =>
                          state.otpStatus == OtpStatus.success ||
                          state.otpStatus == OtpStatus.error);
                      _loading = false;
                      stopLoading();
                    }
                  }
                }),
          ],
        );
        // } else{
        //   return SizedBox();
        // }
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
                  ChangeLocale(context).appLocal!.pleaseEnterMobileNumber,
                  style: AppTextStyles.body1,
                ),
              ),
              MobileNumberTextField(
                readOnly: _loading,
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
              const SizedBox(
                height: 16,
              ),
              TextButton(
                  style: AppButtonsStyle.linkPrimaryTextButton,
                  onPressed: () {
                    setState(() {
                      context
                          .read<AuthScreensBloc>()
                          .add(AuthNavigatePasswordEvent());
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
                      Text(ChangeLocale(context).appLocal!.loginWithPassword),
                    ],
                  ))
            ],
          );
  }
}
