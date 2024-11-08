import 'package:ajhman/core/routes/route_paths.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/colors.dart';
import 'package:ajhman/ui/widgets/button/outlined_primary_button.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_locale.dart';
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
      backgroundColor: Theme.of(context).primaryColor50(),
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
                navigatorKey.currentState!.pushNamed(RoutePaths.auth);
              },
            ),
          )
        ],
      )),
    );
  }
}
