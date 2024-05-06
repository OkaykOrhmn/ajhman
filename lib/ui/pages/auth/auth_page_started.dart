import 'package:ajhman/ui/pages/auth/auth_page.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/widgets/button/outlined_primary_button.dart';
import 'package:ajhman/utils/app_locale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';

class AuthPageStarted extends StatefulWidget {
  const AuthPageStarted({super.key});

  @override
  State<AuthPageStarted> createState() => _AuthPageStartedState();
}

class _AuthPageStartedState extends State<AuthPageStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor50,
      body: SafeArea(
          child: Stack(
        children: [
          Center(
            child: Assets.icon.main.lIcon.svg(),
          ),
          Positioned(
            bottom: 64,
            left: 18,
            right: 18,
            child: OutlinedPrimaryButton(
              title: ChangeLocale(context).appLocal!.continues,
              onClick: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (context) {
                  return const AuthPage();
                }));
              },
            ),
          )
        ],
      )),
    );
  }
}
