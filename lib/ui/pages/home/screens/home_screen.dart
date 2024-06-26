import 'package:ajhman/core/cubit/home/news_course_home_cubit.dart';
import 'package:ajhman/core/enum/card_type.dart';
import 'package:ajhman/core/routes/route_paths.dart';
import 'package:ajhman/data/args/category_args.dart';
import 'package:ajhman/data/model/cards/new_course_card_model.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/card/new_course_card.dart';
import 'package:ajhman/ui/widgets/card/recent_course_card.dart';
import 'package:ajhman/ui/widgets/card/recent_course_card_placeholder.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:ajhman/ui/widgets/text/title_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/api/api_end_points.dart';
import '../../../../data/repository/learning_repository.dart';
import '../../../../gen/assets.gen.dart';
import '../../../theme/bloc/theme_bloc.dart';
import '../../../widgets/card/news_course_card_placeholder.dart';
import '../../../widgets/carousel/carousel_banners.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchText = TextEditingController();
  final items = [1, 2, 3, 4];
  List<NewCourseCardModel>? newsCards;
  List<NewCourseCardModel>? recentCards;

  @override
  void initState() {
    context.read<NewsCourseHomeCubit>().getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 120),
        child: Column(
          children: [
            _mainAppBar(context),
            _searchBar(),
            _gridLayout(),
            // const TitleDivider(title: "آنلاین‌شو"),
            // const OnlineCard(),

            FutureBuilder(
              future: learningRepository.getCards(ApiEndPoints.learning),
              builder: (context, state) {
                if (state.hasData) {
                  if (state.data!.isEmpty) {
                    return const SizedBox();
                  } else {
                    recentCards = state.data;
                    return Column(
                      children: [
                        TitleDivider(
                            title: "دوره‌های اخیرا دیده شده", btn: () {}),
                        SizedBox(
                          height: context.read<ThemeBloc>().state.fontSize >= 1
                              ? (200 + (context.read<ThemeBloc>().state.fontSize * 10))
                              : (200 -  (context.read<ThemeBloc>().state.fontSize * 10)),                          width: MediaQuery.sizeOf(context).width,
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: recentCards!.length,
                              itemExtent:
                              context.read<ThemeBloc>().state.fontSize >= 1
                                  ? (MediaQuery.sizeOf(context).width / 1.2 +
                                  (context
                                      .read<ThemeBloc>()
                                      .state
                                      .fontSize *
                                      30))
                                  : (MediaQuery.sizeOf(context).width / 1.2 -
                                  (context
                                      .read<ThemeBloc>()
                                      .state
                                      .fontSize *
                                      60)),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return RecentCourseCard(
                                  // width: MediaQuery.sizeOf(context).width / 1.1,
                                  padding:
                                      DesignConfig.horizontalListViwItemPadding(
                                          16, index, items.length),
                                  index: index,
                                  response: recentCards![index],
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    );
                  }
                } else {
                  return Column(
                    children: [
                      TitleDivider(
                          title: "دوره‌های اخیرا دیده شده", btn: () {}),
                      SizedBox(
                        height: context.read<ThemeBloc>().state.fontSize >= 1
                            ? (210 + (context.read<ThemeBloc>().state.fontSize * 10))
                            : (210 -  (context.read<ThemeBloc>().state.fontSize * 10)),
                        width: MediaQuery.sizeOf(context).width,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: 4,
                            itemExtent: MediaQuery.sizeOf(context).width / 1.1,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return RecentCourseCardPlaceholder(
                                // width: MediaQuery.sizeOf(context).width / 1.1,
                                padding:
                                    DesignConfig.horizontalListViwItemPadding(
                                        16, index, items.length),
                              );
                            }),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                    ],
                  );
                }
              },
            ),

            BlocBuilder<NewsCourseHomeCubit, List<NewCourseCardModel>?>(
              builder: (context, state) {
                if (state == null) {
                  return Column(
                    children: [
                      TitleDivider(title: "جدیدترین دوره ها", btn: () {}),
                      SizedBox(
                        height: context.read<ThemeBloc>().state.fontSize >= 1
                            ? (340 + (context.read<ThemeBloc>().state.fontSize * 10))
                            : (340 -  (context.read<ThemeBloc>().state.fontSize * 10)),
                        width: MediaQuery.sizeOf(context).width,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: 4,
                            itemExtent: MediaQuery.sizeOf(context).width / 1.2,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return NewCourseCardPlaceholder(
                                // width: MediaQuery.sizeOf(context).width / 1.1,
                                padding:
                                    DesignConfig.horizontalListViwItemPadding(
                                        16, index, items.length),
                                type: CardType.normal,
                              );
                            }),
                      ),
                    ],
                  );
                } else {
                  if (state.isEmpty) {
                    return const SizedBox();
                  } else {
                    newsCards = state;
                    return Column(
                      children: [
                        TitleDivider(
                            title: "جدیدترین دوره ها",
                            btn: () {
                              navigatorKey.currentState!.pushNamed(
                                  RoutePaths.category,
                                  arguments:
                                      CategoryArgs(categoriesId: [1, 2, 3], title: 'دوره ها'));
                            }),
                        SizedBox(
                          height: context.read<ThemeBloc>().state.fontSize >= 1
                              ? (500 +
                                  (context.read<ThemeBloc>().state.fontSize *
                                      10))
                              : (500 -
                                  (context.read<ThemeBloc>().state.fontSize *
                                      100)),
                          width: MediaQuery.sizeOf(context).width,
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: newsCards!.length,
                              itemExtent:
                                  context.read<ThemeBloc>().state.fontSize >= 1
                                      ? (MediaQuery.sizeOf(context).width / 1.2 +
                                          (context
                                                  .read<ThemeBloc>()
                                                  .state
                                                  .fontSize *
                                              30))
                                      : (MediaQuery.sizeOf(context).width / 1.2 -
                                          (context
                                                  .read<ThemeBloc>()
                                                  .state
                                                  .fontSize *
                                              60)),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return NewCourseCard(
                                  // width: MediaQuery.sizeOf(context).width / 1.1,
                                  padding:
                                      DesignConfig.horizontalListViwItemPadding(
                                          16, index, items.length),
                                  index: index,
                                  response: newsCards![index],
                                );
                              }),
                        ),
                      ],
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Container _mainAppBar(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(color: Theme.of(context).surfacePrimaryColor()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 24),
            child: PrimaryText(
                text: "ظهر بخیر آقای عامری",
                style: mThemeData.textTheme.titleBold,
                color: Colors.white),
          ),
          const CarouseBanners(
            items: ["1", "2", "3", "4"],
          ),
          const SizedBox(
            height: 24,
          )
        ],
      ),
    );
  }

  Padding _searchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: InkWell(
        borderRadius: DesignConfig.highBorderRadius,
        onTap: () {
          navigatorKey.currentState!.pushNamed(RoutePaths.search);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).editTextFilled(),
            borderRadius: DesignConfig.highBorderRadius,
            boxShadow: DesignConfig.lowShadow,
          ),
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Assets.icon.outline.searchNormal.svg(color: backgroundColor600),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  color: backgroundColor600,
                  width: 1,
                  height: 20,
                ),
              ),
              PrimaryText(
                  text: "دنبال چی می گردی؟",
                  style: mThemeData.textTheme.searchHint,
                  color: backgroundColor600)
            ],
          ),
        ),
      ),
    );
  }

  Padding _gridLayout() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 24),
      child: Column(
        children: [
          Row(
            children: [
              _iconBtn(1, "توسعه فردی", Assets.icon.twotone.userOctagon),
              _iconBtn(
                  2, "مدیریت کسب و کار", Assets.icon.twotone.presentionChart),
              _iconBtn(3, "آژمان پلاس", Assets.icon.twotone.crown),
            ],
          ),
          Row(
            children: [
              _iconBtn(4, "سواد مالی", Assets.icon.twotone.securityCard),
              _iconBtn(5, "سواد فناوری", Assets.icon.twotone.monitorMobbile),
              _iconBtn(6, "لقمه کتاب", Assets.icon.twotone.book),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconBtn(int index, String title, SvgGenImage icon) {
    return Expanded(
      child: InkWell(
        borderRadius: DesignConfig.highBorderRadius,
        onTap: () {
          navigatorKey.currentState!.pushNamed(RoutePaths.category,
              arguments: CategoryArgs(categoriesId: [index], title: title));
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
                color: Theme.of(context).cardBackground(),
                borderRadius: DesignConfig.highBorderRadius,
                boxShadow: DesignConfig.lowShadow),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon.svg(color: Theme.of(context).primaryColor),
                const SizedBox(
                  height: 8,
                ),
                PrimaryText(
                    text: title,
                    style: Theme.of(context).textTheme.searchHint,
                    maxLines: 1,
                    color: Theme.of(context).cardText())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
