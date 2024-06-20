import 'package:ajhman/core/bloc/learning/leaning_bloc.dart';
import 'package:ajhman/core/enum/card_type.dart';
import 'package:ajhman/data/model/cards/new_course_card_model.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/listview/vertical_listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../main.dart';
import '../../../../theme/color/colors.dart';
import '../../../../theme/widget/design_config.dart';
import '../../../../widgets/card/new_course_card.dart';
import '../../../../widgets/card/news_course_card_placeholder.dart';
import '../../../../widgets/text/primary_text.dart';

class LearningCompleteScreen extends StatefulWidget {

  const LearningCompleteScreen({super.key});

  @override
  State<LearningCompleteScreen> createState() => _LearningCompleteScreenState();
}

class _LearningCompleteScreenState extends State<LearningCompleteScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            margin: const EdgeInsets.all(24),
            decoration:  BoxDecoration(
                borderRadius: DesignConfig.highBorderRadius,
                color: Theme.of(context).cardBackground()),
            child: Row(
              children: [
                Assets.icon.outline.infoCircle
                    .svg(color: Theme.of(context).secondaryColor(), width: 18, height: 18),
                PrimaryText(
                    text: "کاربر گرامی شما دو دوره در حال یادگیری دارید",
                    style: Theme.of(context).textTheme.title,
                    color: Theme.of(context).secondaryColor())
              ],
            ),
          ),
          BlocBuilder<LeaningBloc, LeaningState>(
            builder: (context, state) {
              List<NewCourseCardModel>? items;
              if (state is LeaningSuccess) {
                items = state.response;
              }else if(state is LeaningEmpty){
                items = [];
              }
              return VerticalListView(
                placeholder: const NewCourseCardPlaceholder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  type: CardType.normal,
                ),
                item: (context, index) {
                  return NewCourseCard(
                    index: index,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16)
                        .copyWith(top: index == 0 ? 0 : 8),
                    response: items![index],
                  );
                },
                items: items,
              );
            },
          ),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
