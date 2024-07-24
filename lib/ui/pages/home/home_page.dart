import 'package:ajhman/ui/pages/home/screens/for_you_screen.dart';
import 'package:ajhman/ui/pages/home/screens/home_screen.dart';
import 'package:ajhman/ui/pages/home/screens/learning_screen.dart';
import 'package:ajhman/ui/pages/home/screens/my_treasure_screen.dart';
import 'package:ajhman/ui/theme/colors.dart';
import 'package:ajhman/ui/theme/design_config.dart';
import 'package:ajhman/ui/widgets/bottom_navigation/bottom_navigation_Btn.dart';
import 'package:ajhman/ui/widgets/dialogs/dialog_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/home/selected_index_cubit.dart';
import '../../../gen/assets.gen.dart';
import '../../widgets/app_bar/primary_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 4, vsync: this);

  Future<bool> _onWillPop() async {
    var read = context.read<SelectedIndexCubit>();
    if (read.state.index == 0) {
      DialogHandler(context).showExitBottomSheet();
    } else {
      read.changeSelectedIndex(0, "خانه");
    }

    return false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<SelectedIndexCubit>().state;
    tabController.animateTo(state.index);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          backgroundColor: Theme.of(context).background(),
          appBar: PrimaryAppBar(
            title: state.title,
          ),
          body: Stack(
            children: [
              Positioned.fill(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: const [
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
                      decoration: BoxDecoration(
                          //this is why click effect Inkwell not work
                          color: Theme.of(context).white(),
                          boxShadow: DesignConfig.mediumShadow,
                          borderRadius: const BorderRadius.only(
                              topRight: DesignConfig.aHighBorderRadius,
                              topLeft: DesignConfig.aHighBorderRadius)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BottomNavigationBtn(
                              index: 0,
                              title: "خانه",
                              selectedIcon: Assets.icon.bold.home,
                              unselectedIcon: Assets.icon.outline.home),
                          BottomNavigationBtn(
                              index: 1,
                              title: "گنجینه من",
                              selectedIcon: Assets.icon.bold.ranking,
                              unselectedIcon: Assets.icon.outline.ranking),
                          BottomNavigationBtn(
                              index: 2,
                              title: "یادگیری",
                              selectedIcon: Assets.icon.bold.documentText,
                              unselectedIcon: Assets.icon.outline.documentText),
                          BottomNavigationBtn(
                              index: 3,
                              title: "برای تو",
                              selectedIcon: Assets.icon.bold.lamp,
                              unselectedIcon: Assets.icon.outline.lamp)
                        ],
                      ),
                    ),
                  ))
            ],
          )),
    );
  }
}
