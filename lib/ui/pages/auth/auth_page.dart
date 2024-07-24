// ignore_for_file: deprecated_member_use_from_same_package

import 'package:ajhman/ui/pages/auth/screens/login_otp/login_otp_screen.dart';
import 'package:ajhman/ui/pages/auth/screens/login_password/login_password_screen.dart';
import 'package:ajhman/ui/pages/auth/screens/pin/pin_screen.dart';
import 'package:ajhman/ui/theme/colors.dart';
import 'package:ajhman/ui/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/bloc/auth/auth_screen_bloc.dart';
import '../../../core/utils/app_locale.dart';
import '../../../gen/assets.gen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String _title = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).primaryColor50(),
        body: Column(
          children: [header(context), body()],
        ));
  }

  Widget body() {
    return Expanded(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).white(),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24))),
          child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
              child: authScreensBuilder()),
        ),
      ),
    );
  }

  Widget authScreensBuilder() {
    return BlocConsumer<AuthScreensBloc, AuthScreensState>(
      listener: (context, state) {
        switch (state.authScreen) {
          case AuthScreens.loading:
            break;
          case AuthScreens.otp:
          case AuthScreens.pin:
            setState(() {
              _title = ChangeLocale(context).appLocal!.loginWithOtp.toString();
            });

            break;
          case AuthScreens.password:
            setState(() {
              _title =
                  ChangeLocale(context).appLocal!.loginWithPassword.toString();
            });

            break;
        }
      },
      builder: (context, state) {
        if (state.authScreen == AuthScreens.otp) {
          return const LoginOtpScreen();
        } else if (state.authScreen == AuthScreens.password) {
          return const LoginPasswordScreen();
        } else if (state.authScreen == AuthScreens.pin) {
          return const PinScreen();
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Container header(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height / 3,
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Assets.icon.main.lIcon.svg(color: Colors.white, width: 85),
            const SizedBox(
              height: 32,
            ),
            Text(
              _title,
              style: AppTextStyles.headerBoldWhite,
            ),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
