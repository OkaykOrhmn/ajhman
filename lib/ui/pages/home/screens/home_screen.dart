// ignore_for_file: deprecated_member_use_from_same_package

import 'package:ajhman/core/bloc/banner/banner_bloc.dart';
import 'package:ajhman/core/cubit/home/books_home_cubit.dart';
import 'package:ajhman/core/cubit/home/news_course_home_cubit.dart';
import 'package:ajhman/core/cubit/home/selected_index_cubit.dart';
import 'package:ajhman/core/cubit/learn/selected_tab_cubit.dart';
import 'package:ajhman/core/enum/card_type.dart';
import 'package:ajhman/core/routes/route_paths.dart';
import 'package:ajhman/data/args/category_args.dart';
import 'package:ajhman/data/model/new_course_card_model.dart';
import 'package:ajhman/data/shared_preferences/profile_data.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/colors.dart';
import 'package:ajhman/ui/theme/text_styles.dart';
import 'package:ajhman/ui/theme/design_config.dart';
import 'package:ajhman/ui/widgets/card/new_course_card.dart';
import 'package:ajhman/ui/widgets/card/recent_course_card.dart';
import 'package:ajhman/ui/widgets/card/recent_course_card_placeholder.dart';
import 'package:ajhman/ui/widgets/image/primary_image_network.dart';
import 'package:ajhman/ui/widgets/states/default_place_holder.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:ajhman/ui/widgets/text/title_divider.dart';
import 'package:flutter/cupertino.dart';
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
  final items = [1, 2, 3, 4];
  List<NewCourseCardModel>? newsCards;
  List<NewCourseCardModel>? recentCards;
  List<NewCourseCardModel>? booksCard;

  @override
  void initState() {
    context.read<NewsCourseHomeCubit>().getNews();
    context.read<BooksHomeCubit>().getBooks();
    context.read<BannerBloc>().add(GetAllBanners());
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
                            title: "در حال یادگیری",
                            btn: () {
                              context
                                  .read<SelectedIndexCubit>()
                                  .changeSelectedIndex(2, 'یادگیری');
                              context
                                  .read<SelectedTabCubit>()
                                  .changeSelectedIndex(1);
                            }),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          height: 180 +
                              (context.read<ThemeBloc>().state.fontSize * 10),
                          width: MediaQuery.sizeOf(context).width,
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: recentCards!.length,
                              itemExtent:
                                  MediaQuery.sizeOf(context).width / 1.2,
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
                      ],
                    );
                  }
                } else {
                  return Column(
                    children: [
                      TitleDivider(title: "در حال یادگیری", btn: () {}),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 190,
                        width: MediaQuery.sizeOf(context).width,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: 4,
                            itemExtent: MediaQuery.sizeOf(context).width / 1.2,
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
                    ],
                  );
                }
              },
            ),
            const SizedBox(
              height: 24,
            ),
            BlocBuilder<NewsCourseHomeCubit, List<NewCourseCardModel>?>(
              builder: (context, state) {
                if (state == null) {
                  return Column(
                    children: [
                      TitleDivider(title: "جدیدترین دوره ها", btn: () {}),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 340,
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
                                  arguments: CategoryArgs(
                                      categoriesId: [1, 2, 3, 4, 5, 6],
                                      title: 'دوره ها'));
                            }),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          height: 420 +
                              (context.read<ThemeBloc>().state.fontSize * 10),
                          width: MediaQuery.sizeOf(context).width,
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: newsCards!.length,
                              itemExtent:
                                  MediaQuery.sizeOf(context).width / 1.2,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return NewCourseCard(
                                  // width: MediaQuery.sizeOf(context).width / 1.1,
                                  expanded: true,

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
            const SizedBox(
              height: 24,
            ),
            BlocBuilder<BooksHomeCubit, List<NewCourseCardModel>?>(
              builder: (context, state) {
                if (state == null) {
                  return Column(
                    children: [
                      TitleDivider(
                        title: "یک لقمه کتاب",
                        btn: () {},
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 340,
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
                    booksCard = state;
                    return Column(
                      children: [
                        TitleDivider(
                            title: "یک لقمه کتاب",
                            btn: () {
                              navigatorKey.currentState!.pushNamed(
                                  RoutePaths.category,
                                  arguments: CategoryArgs(
                                      categoriesId: [6],
                                      title: "یک لقمه کتاب"));
                            }),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          height: 450 +
                              (context.read<ThemeBloc>().state.fontSize * 12),
                          width: MediaQuery.sizeOf(context).width,
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: booksCard!.length,
                              itemExtent:
                                  MediaQuery.sizeOf(context).width / 1.2,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return NewCourseCard(
                                  // width: MediaQuery.sizeOf(context).width / 1.1,
                                  expanded: true,
                                  padding:
                                      DesignConfig.horizontalListViwItemPadding(
                                          16, index, items.length),
                                  index: index,
                                  response: booksCard![index],
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
            padding: const EdgeInsets.only(top: 24, bottom: 12),
            child: FutureBuilder(
                future: getProfile(),
                builder: (context, snapshot) {
                  String name = '';
                  if (snapshot.hasData) {
                    name = snapshot.data!.name.toString();
                  }
                  return PrimaryText(
                      text: "ظهر بخیر $name 👋",
                      style: mThemeData.textTheme.titleBold,
                      color: Colors.white);
                }),
          ),
          BlocBuilder<BannerBloc, BannerState>(builder: (context, state) {
            if (state is BannerLoading) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                child: DefaultPlaceHolder(
                    child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        decoration: const BoxDecoration(
                            color: CupertinoColors.white,
                            borderRadius: DesignConfig.highBorderRadius),
                        child: const PrimaryImageNetwork(
                            src: '', aspectRatio: 16 / 9))),
              );
            } else if (state is BannerSuccess) {
              return CarouseBanners(
                items: state.response,
              );
            } else {
              return const SizedBox();
            }
          }),
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
                  2, "مدیریت و رهبری", Assets.icon.twotone.presentionChart),
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
