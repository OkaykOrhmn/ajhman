import 'package:ajhman/gen/assets.gen.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/home/selected_index_cubit.dart';

class BottomNavigationBtn extends StatelessWidget{
  final int index;
  final String? title;
  final SvgGenImage selectedIcon;
  final SvgGenImage unselectedIcon;
  const BottomNavigationBtn({super.key, required this.index, this.title, required this.selectedIcon, required this.unselectedIcon});

  @override
  Widget build(BuildContext context) {
    var read = context.read<SelectedIndexCubit>();
    return InkWell(
      borderRadius: BorderRadius.circular(360),
      onTap: () {
        read.changeSelectedIndex(index,title);

      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            read.state.index == index
                ? selectedIcon
                .svg(color: Theme.of(context).primaryColor)
                : unselectedIcon
                .svg(color: Theme.of(context).primaryColor),
            const SizedBox(
              height: 6,
            ),
            title != null?
            PrimaryText(
             text:  title!,
              color:  Theme.of(context).pinTextFont(),
              style: Theme.of(context).textTheme.navbarTitle,
            ):const SizedBox(),
            const SizedBox(
              height: 12,
            ),
            read.state.index == index
                ? Container(
              width: 28,
              height: 4,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
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