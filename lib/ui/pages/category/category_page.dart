import 'package:ajhman/core/bloc/category/category_bloc.dart';
import 'package:ajhman/core/enum/card_type.dart';
import 'package:ajhman/data/args/category_args.dart';
import 'package:ajhman/data/model/new_course_card_model.dart';
import 'package:ajhman/ui/theme/colors.dart';
import 'package:ajhman/ui/theme/text_styles.dart';
import 'package:ajhman/ui/theme/design_config.dart';
import 'package:ajhman/ui/widgets/app_bar/reversible_app_bar.dart';
import 'package:ajhman/ui/widgets/card/new_course_card.dart';
import 'package:ajhman/ui/widgets/card/news_course_card_placeholder.dart';
import 'package:ajhman/ui/widgets/listview/vertical_listview.dart';
import 'package:ajhman/ui/widgets/states/empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';

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

  @override
  void initState() {
    context.read<CategoryBloc>().add(GetAllCategoryCards(
        categories: widget.args.categoriesId!, tag: Tags.none));
    super.initState();
  }

  List<NewCourseCardModel>? cards;
  late ReversibleAppBar appBar =
      ReversibleAppBar(title: widget.args.title.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar,
        backgroundColor: Theme.of(context).background(),
        body: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoadingState) {
              cards = null;
            } else if (state is CategorySuccessState) {
              cards = state.newsCards;
            }
            return Stack(
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  child: cards != null && cards!.isEmpty
                      ? const Center(child: EmptyScreen())
                      : const SizedBox(),
                ),
                SingleChildScrollView(
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
                              selectedColor: Theme.of(context).primaryColor,
                              selectedShadow: DesignConfig.defaultShadow,
                              unselectedShadow: DesignConfig.defaultShadow,
                              selectedTextStyle: Theme.of(context)
                                  .textTheme
                                  .navbarTitle
                                  .copyWith(color: Colors.white),
                              unselectedBorderColor:
                                  Theme.of(context).primaryColor,
                              unselectedColor: Theme.of(context).white(),
                              unselectedTextStyle: Theme.of(context)
                                  .textTheme
                                  .navbarTitle
                                  .copyWith(
                                      color: Theme.of(context).primaryColor),
                              textAlign: TextAlign.center,
                              textPadding:
                                  const EdgeInsets.symmetric(horizontal: 16),
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
                                  GetAllCategoryCards(
                                      categories: widget.args.categoriesId!,
                                      tag: t));
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
                      cards != null && cards!.isEmpty
                          ? const SizedBox()
                          : VerticalListView(
                              items: cards,
                              placeholder: const NewCourseCardPlaceholder(
                                padding: EdgeInsets.symmetric(
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
                            )
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
