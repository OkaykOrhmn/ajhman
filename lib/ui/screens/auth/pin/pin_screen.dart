import 'package:ajhman/data/bloc/auth/auth_screen_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../../data/model/auth/auth_user_otp_request.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../utils/app_locale.dart';
// import '../../pages/auth/bloc/auth_screen_bloc.dart';
import '../../../theme/color/colors.dart';
import '../../../theme/text/text_styles.dart';
import '../../../theme/widget/app_buttons_style.dart';
import '../../../theme/widget/pin_put_style.dart';
import '../../../widgets/button/primary_button.dart';

class PinScreen extends StatefulWidget {
  final AuthScreensState state;
  final bool error;

  const PinScreen({super.key, required this.state, required this.error});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${ChangeLocale(context).appLocal!.otpSendToNumber} "
                "${widget.state.phoneNumber} "
                "${ChangeLocale(context).appLocal!.sent}",
                style: AppTextStyles.body1,
              ),
            ),
            TextButton(
                style: AppButtonsStyle.linkPrimaryTextButton,
                onPressed: () {
                  // context.read<AuthScreensBloc>().add(AuthChangeLoginEvent(
                  //     inOtp: true));
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Assets.icon.outline.edit2
                        .svg(color: primaryColor, width: 16),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(ChangeLocale(context).appLocal!.changeNumber),
                  ],
                )),
            Pinput(
              length: 6,
              onCompleted: (pin) {
                // context.read<AuthScreensBloc>().add(AuthPostOtpEvent(
                //     AuthUserOtpRequest(
                //         otp: pin, mobileNumber: widget.state.phoneNumber)));
              },
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              closeKeyboardWhenCompleted: true,
              validator: (s) {
                if (widget.error) {
                  return "success";
                } else {
                  return "کد اشتباه است";
                }
              },
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              ChangeLocale(context).appLocal!.resendPassword,
              style: AppTextStyles.hintText,
            )
          ],
        ),
        SizedBox(
            width: double.infinity,
            child: true
                ? const SizedBox()
                : PrimaryButton(
                    title: ChangeLocale(context).appLocal!.continues,
                  ))
      ],
    );
  }
}
