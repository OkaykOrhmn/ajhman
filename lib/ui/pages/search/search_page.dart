import 'package:ajhman/core/cubit/search/search_cubit.dart';
import 'package:ajhman/core/enum/course_types.dart';
import 'package:ajhman/data/model/cards/new_course_card_model.dart';
import 'package:ajhman/gen/assets.gen.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/app_bar/reversible_app_bar.dart';
import 'package:ajhman/ui/widgets/listview/vertical_listview.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:ajhman/ui/widgets/text_field/search_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';

import '../../../core/enum/card_type.dart';
import '../../../main.dart';
import '../../theme/color/colors.dart';
import '../../theme/widget/design_config.dart';
import '../../widgets/card/new_course_card.dart';
import '../../widgets/card/news_course_card_placeholder.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final GroupButtonController _radioController = GroupButtonController();

  final types = [
    CourseTypes.audio,
    CourseTypes.video,
    CourseTypes.text,
    CourseTypes.image,
    CourseTypes.any
  ];

  final btns = [];
  final TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    for (var element in types) {
      btns.add(element.title);
    }
    return Scaffold(
      appBar: ReversibleAppBar(title: "جستجو"),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SearchTextField(
                textEditingController: _search,
                hint: "دنبال چی می گردی؟",
                onChange: (val) {
                  context.read<SearchCubit>().search(CourseTypes.video, val);
                }),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
                child: GroupButton(
                  controller: _radioController,
                  options: GroupButtonOptions(
                    groupingType: GroupingType.row,
                  ),
                  isRadio: true,
                  enableDeselect: true,
                  buttonIndexedBuilder: (selected, index, context) {
                    return Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: primaryColor, width: 1),
                          borderRadius: DesignConfig.veryHighBorderRadius,
                          color: selected ? primaryColor : Colors.white),
                      padding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          SvgGenImage(types[index].outlined).svg(
                              width: 16,
                              height: 16,
                              color: selected ? Colors.white : primaryColor),
                          SizedBox(
                            width: 8,
                          ),
                          PrimaryText(
                              text: types[index].title,
                              style: mThemeData.textTheme.title,
                              color: selected ? Colors.white : primaryColor)
                        ],
                      ),
                    );
                  },
                  onSelected: (_, index, isSelected) {},
                  buttons: types,
                ),
              ),
            ),
            BlocBuilder<SearchCubit, List<NewCourseCardModel>>(
                builder: (context, state) {
              return VerticalListView(
                placeholder: const NewCourseCardPlaceholder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  type: CardType.normal,
                ),
                item: (context, index) => NewCourseCard(
                  type: CardType.normal,
                  index: index,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16)
                      .copyWith(top: index == 0 ? 0 : 8),
                  response: state[index],
                ),
                items: state.isEmpty ? [] : state,
              );
            })
          ],
        ),
      ),
    );
  }
}
