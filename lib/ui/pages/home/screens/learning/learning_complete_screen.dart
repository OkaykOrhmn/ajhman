import 'package:ajhman/core/enum/card_type.dart';
import 'package:ajhman/data/model/cards/new_course_card_model.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/listview/vertical_listview.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../main.dart';
import '../../../../theme/color/colors.dart';
import '../../../../theme/widget/design_config.dart';
import '../../../../widgets/card/new_course_card.dart';
import '../../../../widgets/text/primary_text.dart';

class LearningCompleteScreen extends StatefulWidget {
  final CardType cardType;
  const LearningCompleteScreen({super.key, required this.cardType});

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
            decoration: const BoxDecoration(
                borderRadius: DesignConfig.highBorderRadius,
                color: backgroundColor100),
            child: Row(
              children: [
                Assets.icon.outline.infoCircle
                    .svg(color: secondaryColor, width: 18, height: 18),
                PrimaryText(
                    text: "کاربر گرامی شما دو دوره در حال یادگیری دارید",
                    style: mThemeData.textTheme.title,
                    color: secondaryColor)
              ],
            ),
          ),
          VerticalListView(
            item: (context,index) => NewCourseCard(
              type: widget.cardType,
              index: index,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16).copyWith(top: index == 0? 0: 8), response: NewCourseCardModel(),
            ),
            items: [1, 2, 3, 4],
          ),
          const SizedBox(height: 100,)
        ],
      ),
    );
  }
}
