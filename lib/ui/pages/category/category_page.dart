import 'package:ajhman/core/bloc/category/category_bloc.dart';
import 'package:ajhman/core/bloc/category/category_bloc.dart';
import 'package:ajhman/core/enum/card_type.dart';
import 'package:ajhman/data/args/category_args.dart';
import 'package:ajhman/data/model/cards/new_course_card_model.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/app_bar/reversible_app_bar.dart';
import 'package:ajhman/ui/widgets/button/toggle_buttons_row.dart';
import 'package:ajhman/ui/widgets/card/new_course_card.dart';
import 'package:ajhman/ui/widgets/card/news_course_card_placeholder.dart';
import 'package:ajhman/ui/widgets/listview/vertical_listview.dart';
import 'package:ajhman/ui/widgets/states/empty_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';

import '../../../core/cubit/home/news_course_home_cubit.dart';
import '../../../core/enum/tags.dart';
import '../../../data/model/t_buttons.dart';

class CategoryPage extends StatefulWidget {
  final CategoryArgs args;

  const CategoryPage({super.key, required this.args});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<TButtons> buttons = [
    TButtons("تازه‌ترین‌ها", true),
    TButtons("آنلاین شو", false),
    TButtons("مینی‌دوره‌ها", false),
    TButtons("اینترنشنال شو", false),
  ];
  final controller = GroupButtonController(selectedIndex: 0);
  List<NewCourseCardModel>? cards;

  @override
  void initState() {
    context.read<CategoryBloc>().add(GetAllCategoryCards(
        categories: widget.args.categoriesId!, tag: Tags.none));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ReversibleAppBar(title: "مدیریت کسب‌وکار"),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 24, 8, 12),
                  child: GroupButton(
                    controller: controller,
                    options: GroupButtonOptions(
                      borderRadius: DesignConfig.highBorderRadius,
                      alignment: Alignment.center,
                      buttonHeight: 32,
                      crossGroupAlignment: CrossGroupAlignment.center,
                      direction: Axis.horizontal,
                      groupingType: GroupingType.row,
                      runSpacing: 4,
                      selectedColor: primaryColor,
                      selectedTextStyle: mThemeData.textTheme.navbarTitle
                          .copyWith(color: Colors.white),
                      unselectedBorderColor: primaryColor,
                      unselectedColor: Colors.white,
                      unselectedTextStyle: mThemeData.textTheme.navbarTitle
                          .copyWith(color: primaryColor),
                      textAlign: TextAlign.center,
                      textPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    isRadio: true,
                    onSelected: (_, index, isSelected) {
                      late Tags t;
                      switch (index) {
                        case 0:
                          t = Tags.none;
                          break;
                        case 1:
                          t = Tags.online;
                          break;
                        case 2:
                          t = Tags.mini;
                          break;
                        case 3:
                          t = Tags.international;
                          break;
                      }
                      context.read<CategoryBloc>().add(
                          GetAllCategoryCards(categories: [2, 3], tag: t));
                    },
                    buttons: const [
                      "تازه‌ترین‌ها",
                      "آنلاین شو",
                      "مینی‌دوره‌ها",
                      "اینترنشنال شو"
                    ],
                  ),
                ),
              ),
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoadingState) {
                    cards = null;
                  } else if (state is CategorySuccessState) {
                    cards = state.newsCards;
                  }
                  return cards != null && cards!.isEmpty
                      ? Padding(
                          padding: EdgeInsets.only(
                              top: (MediaQuery.sizeOf(context).width / 2) +
                                  24 +
                                  12 +
                                  32),
                          child: const EmptyScreen(),
                        )
                      : VerticalListView(
                          items: cards,
                          placeholder: const NewCourseCardPlaceholder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            type: CardType.normal,
                          ),
                          item: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: NewCourseCard(
                              index: index,
                              response: cards![index],
                            ),
                          ),
                        );
                },
              ),
            ],
          ),
        ));
  }
}
