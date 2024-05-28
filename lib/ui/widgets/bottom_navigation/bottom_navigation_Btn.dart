import 'package:ajhman/ui/pages/home/cubit/selected_index_cubit.dart';
import 'package:ajhman/gen/assets.gen.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationBtn extends StatelessWidget{
  final int index;
  final String? title;
  final SvgGenImage selectedIcon;
  final SvgGenImage unselectedIcon;
  const BottomNavigationBtn({super.key, required this.index, this.title, required this.selectedIcon, required this.unselectedIcon});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    var read = context.read<SelectedIndexCubit>();
    return InkWell(
      borderRadius: BorderRadius.circular(360),
      onTap: () {
        read.changeSelectedIndex(index,title);

      },
      child: Padding(
        padding: EdgeInsets.all(18.0),
        child: Column(
          children: [
            read.state.index == index
                ? selectedIcon
                .svg(color: themeData.colorScheme.appPrimary)
                : unselectedIcon
                .svg(color: themeData.colorScheme.appPrimary),
            const SizedBox(
              height: 6,
            ),
            title != null?
            Text(
              title!,
              style: themeData.textTheme.navbarTitle
                  .copyWith(color: themeData.colorScheme.appOnSurface),
            ):const SizedBox(),
            const SizedBox(
              height: 12,
            ),
            read.state.index == index
                ? Container(
              width: 28,
              height: 4,
              decoration: BoxDecoration(
                  color: themeData.colorScheme.appPrimary,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4))),
            )
                : const SizedBox(
              height: 4,
            )
          ],
        ),
      ),
    );
  }

}