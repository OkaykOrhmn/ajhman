import 'package:ajhman/ui/pages/home/cubit/selected_index_cubit.dart';
import 'package:ajhman/ui/pages/home/cubit/selected_index_cubit.dart';
import 'package:ajhman/ui/pages/home/screens/for_you_screen.dart';
import 'package:ajhman/ui/pages/home/screens/home_screen.dart';
import 'package:ajhman/ui/pages/home/screens/learning_screen.dart';
import 'package:ajhman/ui/pages/home/screens/my_treasure_screen.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/bottom_navigation/bottom_navigation_Btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/app_locale.dart';
import '../../../gen/assets.gen.dart';
import '../../widgets/app_bar/primary_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    var state = context.watch<SelectedIndexCubit>().state;
    return Scaffold(
        backgroundColor: themeData.colorScheme.background,
        appBar: PrimaryAppBar(
          title: state.title,
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: IndexedStack(
                index: state.index,
                children: [
                  HomeScreen(),
                  MyTreasureScreen(),
                  LearningScreen(),
                  ForYouScreen(),
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: const BoxDecoration(
                        //this is why click effect Inkwell not work
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: const Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 1.0,
                          )
                        ],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16),
                            topLeft: Radius.circular(16))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BottomNavigationBtn(
                            index: 0,
                            title: "Home",
                            selectedIcon: Assets.icon.bold.home,
                            unselectedIcon: Assets.icon.outline.home),
                        BottomNavigationBtn(
                            index: 1,
                            title: "MyT",
                            selectedIcon: Assets.icon.bold.ranking,
                            unselectedIcon: Assets.icon.outline.ranking),
                        BottomNavigationBtn(
                            index: 2,
                            title: "Learn",
                            selectedIcon: Assets.icon.bold.documentText,
                            unselectedIcon: Assets.icon.outline.documentText),
                        BottomNavigationBtn(
                            index: 3,
                            title: "For U",
                            selectedIcon: Assets.icon.bold.lamp,
                            unselectedIcon: Assets.icon.outline.lamp)
                      ],
                    ),
                  ),
                ))
          ],
        ));
    ;
  }
}
