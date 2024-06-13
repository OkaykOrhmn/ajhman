import 'package:ajhman/core/bloc/learning/leaning_bloc.dart';
import 'package:ajhman/core/cubit/learn/selected_tab_cubit.dart';
import 'package:ajhman/core/enum/card_type.dart';
import 'package:ajhman/data/api/api_end_points.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../gen/assets.gen.dart';
import 'learning_complete_screen.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen>
    with TickerProviderStateMixin {
  late TabController _controller;
  String path = '';

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    context.read<LeaningBloc>().add(GetCards(path: ApiEndPoints.learned));

    _controller.addListener(() {
      context.read<SelectedTabCubit>().changeSelectedIndex(_controller.index);
      String path = '';
      switch (_controller.index) {
        case 0:
          path = ApiEndPoints.learned;
          break;
        case 1:
          path = ApiEndPoints.learning;
          break;
        case 2:
          path = ApiEndPoints.marked;
          break;
      }
      context.read<LeaningBloc>().add(GetCards(path: path));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          _tabBar(),
          const Expanded(
            child: LearningCompleteScreen(),
          ),
        ],
      ),
    );
  }

  Container _tabBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 22, horizontal: 16),
      decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: DesignConfig.aHighBorderRadius,
              bottomRight: DesignConfig.aHighBorderRadius)),
      child: BlocBuilder<SelectedTabCubit, int>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _tabBtn(0, state, Assets.icon.outlineTickCircle,
                  Assets.icon.boldTickCircle, "تکمیل شده"),
              _tabBtn(1, state, Assets.icon.outlineNote, Assets.icon.boldNote,
                  "درحال یادگیری"),
              _tabBtn(2, state, Assets.icon.outlineArchive,
                  Assets.icon.boldArchive, "نشان شده"),
            ],
          );
        },
      ),
    );
  }

  InkWell _tabBtn(int index, int state, SvgGenImage icon, SvgGenImage fillIcon,
      String title) {
    return InkWell(
      onTap: () {
        _controller.animateTo(
          index,
          duration: const Duration(milliseconds: 500),
        );
        context.read<SelectedTabCubit>().changeSelectedIndex(index);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          state == index
              ? fillIcon.svg(color: Colors.white, width: 16, height: 16)
              : icon.svg(color: backgroundColor800, width: 16, height: 16),
          SizedBox(
            width: 4,
          ),
          PrimaryText(
              text: title,
              style: state == index
                  ? mThemeData.textTheme.titleBold
                  : mThemeData.textTheme.title,
              color: state == index ? Colors.white : backgroundColor700),
        ],
      ),
    );
  }
}
