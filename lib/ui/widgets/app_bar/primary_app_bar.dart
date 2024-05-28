import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_locale.dart';
import '../../../core/utils/language/bloc/language_bloc.dart';
import '../../../data/model/language.dart';
import '../../../gen/assets.gen.dart';
import '../../theme/bloc/theme_bloc.dart';
import '../../theme/text/text_styles.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  const PrimaryAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return AppBar(
      backgroundColor: themeData.primaryColor,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              BlocProvider.of<ThemeBloc>(context).add(ThemeSwitchEvent());
            },
            child: Assets.icon.profile.svg(color: Colors.white),
          ),
          Text(
            title,
            style: AppTextStyles.headerBoldWhite,
          ),
          InkWell(
            onTap: () {
              if (context.read<LanguageBloc>().state.selectedLanguage ==
                  Language.english) {
                context.read<LanguageBloc>().add(
                    const ChangeLanguage(selectedLanguage: Language.farsi));
              } else {
                context.read<LanguageBloc>().add(
                    const ChangeLanguage(selectedLanguage: Language.english));
              }
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