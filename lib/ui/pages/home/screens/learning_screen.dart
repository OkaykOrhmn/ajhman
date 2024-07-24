import 'package:ajhman/core/bloc/learning/leaning_bloc.dart';
import 'package:ajhman/core/cubit/learn/selected_tab_cubit.dart';
import 'package:ajhman/core/enum/card_type.dart';
import 'package:ajhman/data/api/api_end_points.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/colors.dart';
import 'package:ajhman/ui/theme/text_styles.dart';
import 'package:ajhman/ui/theme/design_config.dart';
import 'package:ajhman/ui/widgets/states/empty_screen.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/new_course_card_model.dart';
import '../../../../gen/assets.gen.dart';
import '../../../widgets/card/new_course_card.dart';
import '../../../widgets/card/news_course_card_placeholder.dart';
import '../../../widgets/listview/vertical_listview.dart';

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
    context.read<LeaningBloc>().add(ClearCards());
    _controller.index = context.read<SelectedTabCubit>().state;

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
    context.read<LeaningBloc>().add(ClearCards());
    context.read<LeaningBloc>().add(GetCards(path: path));

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
      context.read<LeaningBloc>().add(ClearCards());
      context.read<LeaningBloc>().add(GetCards(path: path));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  List<NewCourseCardModel>? items;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          _tabBar(),
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      BlocBuilder<LeaningBloc, LeaningState>(
                        builder: (context, state) {
                          if (state is LeaningSuccess) {
                            items = state.response;
                          } else if (state is LeaningEmpty) {
                            items = [];
                          } else if (state is LeaningLoading) {
                            items = null;
                          }
                          return Column(
                            children: [
                              state is LeaningLoading
                                  ? const SizedBox()
                                  : Container(
                                      padding: const EdgeInsets.all(18),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 24),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              DesignConfig.highBorderRadius,
                                          color: Theme.of(context)
                                              .cardBackground()),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Assets.icon.outline.infoCircle.svg(
                                              color: Theme.of(context)
                                                  .secondaryColor(),
                                              width: 18,
                                              height: 18),
                                          const SizedBox(width: 8),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2.0),
                                            child: PrimaryText(
                                                text:
                                                    "کاربر گرامی شما ${items != null && items!.isNotEmpty ? items!.length : 'هیچ'} دوره ${_controller.index == 0 ? 'تکمیل شده' : _controller.index == 1 ? 'در حال یادگیری' : 'نشان شده'} ${items != null && items!.isNotEmpty ? '' : 'ن'}دارید.",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .title,
                                                color: Theme.of(context)
                                                    .secondaryColor()),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                        ],
                                      ),
                                    ),
                              VerticalListView(
                                placeholder: const NewCourseCardPlaceholder(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  type: CardType.normal,
                                ),
                                item: (context, index) {
                                  return NewCourseCard(
                                    index: index,
                                    padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 16)
                                        .copyWith(top: index == 0 ? 0 : 8),
                                    response: items![index],
                                  );
                                },
                                items: items,
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
                Positioned.fill(
                  child: items != null && items!.isEmpty
                      ? const Center(child: EmptyScreen())
                      : const SizedBox(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _tabBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
      decoration: BoxDecoration(
          color: Theme.of(context).surfacePrimaryColor(),
          borderRadius: const BorderRadius.only(
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
                  "در حال یادگیری"),
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
          const SizedBox(
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
