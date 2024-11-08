// ignore_for_file: deprecated_member_use_from_same_package

import 'package:ajhman/core/routes/route_paths.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../theme/text_styles.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const PrimaryAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).surfacePrimaryColor(),
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              navigatorKey.currentState!.pushNamed(RoutePaths.profile);
            },
            child: Assets.icon.profile.svg(color: Colors.white),
          ),
          Text(
            title,
            style: AppTextStyles.headerBoldWhite,
          ),
          InkWell(
            onTap: () {
              // if (context.read<LanguageBloc>().state.selectedLanguage ==
              //     Language.english) {
              //   context.read<LanguageBloc>().add(
              //       const ChangeLanguage(selectedLanguage: Language.farsi));
              // } else {
              //   context.read<LanguageBloc>().add(
              //       const ChangeLanguage(selectedLanguage: Language.english));
              // }
            },
            child: Assets.icon.notification.svg(color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
