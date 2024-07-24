// ignore_for_file: deprecated_member_use_from_same_package

import 'package:ajhman/core/bloc/search/search_bloc.dart';
import 'package:ajhman/core/enum/course_types.dart';
import 'package:ajhman/gen/assets.gen.dart';
import 'package:ajhman/ui/theme/text_styles.dart';
import 'package:ajhman/ui/widgets/app_bar/reversible_app_bar.dart';
import 'package:ajhman/ui/widgets/listview/vertical_listview.dart';
import 'package:ajhman/ui/widgets/loading/three_bounce_loading.dart';
import 'package:ajhman/ui/widgets/states/empty_screen.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:ajhman/ui/widgets/text_field/search_text_field.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';

import '../../../core/enum/card_type.dart';
import '../../../main.dart';
import '../../theme/colors.dart';
import '../../theme/design_config.dart';
import '../../widgets/card/new_course_card.dart';
import '../../widgets/card/news_course_card_placeholder.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final GroupButtonController _radioController = GroupButtonController();
  bool loading = false;
  final types = [
    CourseTypes.audio,
    CourseTypes.video,
    CourseTypes.text,
    CourseTypes.image,
    CourseTypes.any
  ];
  CourseTypes? courseTypes;

  final TextEditingController _search = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ReversibleAppBar(title: "جستجو"),
      backgroundColor: Theme.of(context).background(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SearchTextField(
                textEditingController: _search,
                hint: "دنبال چی می گردی؟",
                onChange: (val) {
                  context.read<SearchBloc>().add(TypingSearch());

                  EasyDebounce.debounce(
                      'my-debouncer',
                      // <-- An ID for this particular debouncer
                      const Duration(seconds: 1), // <-- The debounce duration
                      () {
                    if (val.isNotEmpty) {
                      context.read<SearchBloc>().add(
                          GetAllSearch(type: courseTypes?.type, search: val));
                    } else {
                      context.read<SearchBloc>().add(ClearAllSearch());
                    }
                  } // <-- The target method
                      );
                }),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
                child: GroupButton(
                  controller: _radioController,
                  options: const GroupButtonOptions(
                    groupingType: GroupingType.row,
                  ),
                  isRadio: true,
                  enableDeselect: true,
                  buttonIndexedBuilder: (selected, index, context) {
                    return Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).primaryColor, width: 1),
                          borderRadius: DesignConfig.veryHighBorderRadius,
                          color: selected
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).white()),
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          SvgGenImage(types[index].outlined).svg(
                              width: 16,
                              height: 16,
                              color: selected
                                  ? Colors.white
                                  : Theme.of(context).primaryColor),
                          const SizedBox(
                            width: 8,
                          ),
                          PrimaryText(
                              text: types[index].title,
                              style: mThemeData.textTheme.title,
                              color: selected
                                  ? Colors.white
                                  : Theme.of(context).primaryColor)
                        ],
                      ),
                    );
                  },
                  onSelected: (_, index, isSelected) {
                    setState(() {
                      if (isSelected) {
                        courseTypes = types[index];
                      } else {
                        courseTypes = null;
                      }
                      if (_search.text.isNotEmpty) {
                        context.read<SearchBloc>().add(GetAllSearch(
                            type: courseTypes?.type, search: _search.text));
                      }
                    });
                  },
                  buttons: types,
                ),
              ),
            ),
            BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
              if (state is SearchSuccess) {
                return VerticalListView(
                  placeholder: const NewCourseCardPlaceholder(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    type: CardType.normal,
                  ),
                  item: (context, index) => NewCourseCard(
                    index: index,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16)
                            .copyWith(top: index == 0 ? 0 : 8),
                    response: state.response[index],
                  ),
                  items: state.response,
                );
              } else if (state is SearchEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(top: 86.0),
                  child: EmptyScreen(),
                );
              } else if (state is SearchLoading) {
                return const Padding(
                  padding: EdgeInsets.only(top: 220.0),
                  child: ThreeBounceLoading(),
                );
              } else {
                return const SizedBox();
              }
            })
          ],
        ),
      ),
    );
  }
}
