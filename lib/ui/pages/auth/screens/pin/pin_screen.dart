import 'package:ajhman/core/routes/route_paths.dart';
import 'package:ajhman/core/utils/extentions.dart';
import 'package:ajhman/data/shared_preferences/auth_token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../../../core/bloc/auth/auth_screen_bloc.dart';
import '../../../../../core/bloc/pin/pin_bloc.dart';
import '../../../../../core/bloc/ticker/timer_bloc.dart';
import '../../../../../core/utils/app_locale.dart';
import '../../../../../data/model/auth/auth_user_otp_request.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../theme/color/colors.dart';
import '../../../../theme/text/text_styles.dart';
import '../../../../widgets/button/primary_button.dart';
import '../../../../widgets/loading/three_bounce_loading.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  bool _complete = false;
  bool _error = false;
  String _errorTitle = "";

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthScreensBloc>().state;
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, timerState) {
        return BlocConsumer<PinBloc, PinState>(
          listener: (context, pinState) {
            if (pinState is PinSuccessState) {
              setState(() {
                setToken(pinState.token);
                context.read<TimerBloc>().add(TimerReset());
                Navigator.of(context)
                    .restorablePushReplacementNamed(RoutePaths.splash);
              });
            } else if (pinState is PinGetAgainState) {
              _complete = false;
              context.read<TimerBloc>().add(const TimerStarted(120));
            } else if (pinState is PinErrorState) {
              setState(() {
                _complete = false;
                _error = true;
                _errorTitle = pinState.error;
              });
            }
          },
          builder: (context, pinState) {
            if (timerState is TimerInitial) {
              context.read<TimerBloc>().add(const TimerStarted(120));
            }
            if (timerState is TimerRunComplete) {
              _error = true;
              _complete = true;
              _errorTitle = ChangeLocale(context).appLocal!.getCodeAgain;
            }

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
                        "${authState.phoneNumber} "
                        "${ChangeLocale(context).appLocal!.sent}",
                        style: body1,
                      ),
                    ),
                    TextButton(
                        style: OutlinedButton.styleFrom(
                            foregroundColor: Theme.of(context).primaryColor,
                            textStyle: AppTextStyles.linkPrimaryTextButtonText),
                        onPressed: () async {
                          context.read<TimerBloc>().add(TimerReset());
                          await context
                              .read<TimerBloc>()
                              .stream
                              .firstWhere((state) => state is TimerInitial);
                          context
                              .read<AuthScreensBloc>()
                              .add(AuthNavigateOtpEvent());
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Assets.icon.outline.edit2.svg(
                                color: Theme.of(context).primaryColor,
                                width: 16),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(ChangeLocale(context).appLocal!.changeNumber),
                          ],
                        )),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        readOnly: _complete,
                        length: 5,
                        androidSmsAutofillMethod:
                            AndroidSmsAutofillMethod.smsRetrieverApi,
                        onCompleted: (pin) async {
                          _complete = true;
                          final req = AuthUserOtpRequest(
                              mobileNumber: context
                                  .read<AuthScreensBloc>()
                                  .state
                                  .phoneNumber
                                  .toString(),
                              otp: pin.toString());
                          context.read<PinBloc>().add(PostOtp(req));
                          await context
                              .read<PinBloc>()
                              .stream
                              .lastWhere((state) =>
                                  state is PinErrorState ||
                                  state is PinSuccessState)
                              .then((value) {
                            if (value is PinStartState) {
                              context
                                  .read<AuthScreensBloc>()
                                  .add(AuthNavigateOtpEvent());
                            }
                          });
                        },
                        defaultPinTheme: _error
                            ? PinTheme(
                                width: 56,
                                height: 56,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .title
                                    .copyWith(color: errorMain),
                                decoration: BoxDecoration(
                                  border: Border.all(color: errorMain),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              )
                            : PinTheme(
                                width: 56,
                                height: 56,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .title
                                    .copyWith(
                                        color: Theme.of(context).pinTextFont()),
                                decoration: BoxDecoration(
                                  border: Border.all(color: backgroundColor600),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                        focusedPinTheme: PinTheme(
                          width: 56,
                          height: 56,
                          textStyle: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(color: Theme.of(context).pinTextFont()),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        submittedPinTheme: _error
                            ? PinTheme(
                                width: 56,
                                height: 56,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .title
                                    .copyWith(color: errorMain),
                                decoration: BoxDecoration(
                                  border: Border.all(color: errorMain),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              )
                            : PinTheme(
                                width: 56,
                                height: 56,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .title
                                    .copyWith(
                                        color: Theme.of(context).primaryColor),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                        closeKeyboardWhenCompleted: true,
                        onChanged: (s) {
                          if (s.length < 6) {
                            setState(() {
                              _complete = false;
                              _error = false;
                            });
                          }
                        },
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                      ),
                    ),
                    _error
                        ? Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              _errorTitle,
                              style: AppTextStyles.errorText,
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      "${context.select((TimerBloc bloc) => bloc.state.duration).formattedToMinute} ${ChangeLocale(context).appLocal!.resendPassword}",
                      style: AppTextStyles.hintText,
                    )
                  ],
                ),
                pinState is PinLoadingState
                    ? const ThreeBounceLoading()
                    : const SizedBox(),
                SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      title: ChangeLocale(context).appLocal!.sendAgain,
                      onClick: timerState is TimerRunComplete
                          ? () {
                              context.read<PinBloc>().add(
                                  GetOtp(authState.phoneNumber.toString()));
                            }
                          : null,
                    ))
              ],
            );
          },
        );
      },
    );
  }
}
