import 'package:ajhman/utils/app_locale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/model/days.dart';
import '../../theme/color/colors.dart';
import '../../theme/text/text_styles.dart';
import '../check_box/days_check_box.dart';

class GridDaysView extends StatefulWidget {
  const GridDaysView({super.key});

  @override
  State<GridDaysView> createState() => _GridDaysViewState();
}

class _GridDaysViewState extends State<GridDaysView> {
  List<Days> days = [
    Days("", true),
    Days("", false),
    Days("", false),
    Days("", false),
    Days("", false),
    Days("", false),
    Days("", false),
  ];

  @override
  Widget build(BuildContext context) {
    List<String> daysName = [
      ChangeLocale(context).appLocal!.saturday,
      ChangeLocale(context).appLocal!.sunday,
      ChangeLocale(context).appLocal!.monday,
      ChangeLocale(context).appLocal!.tuesday,
      ChangeLocale(context).appLocal!.wednesday,
      ChangeLocale(context).appLocal!.thursday,
      ChangeLocale(context).appLocal!.friday,
    ];
    days.forEach((element) {
      int index = days.indexOf(element);
      element.dayName = daysName[index];
    });

    return SizedBox(
      height: (48 * 3) + (16 * 2),
      child: GridView.builder(
          itemCount: days.length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            mainAxisExtent: 48,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            return DaysLayout(index);
          }),
    );
  }

  Widget DaysLayout(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          days[index].isSelected = !days[index].isSelected;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: days[index].isSelected ? primaryColor : Colors.white)),
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                flex: 1,
                child: Transform.scale(
                  scale: 0.7,
                  child: DaysCheckBox(
                    value: days[index].isSelected,
                  ),
                ),
              ),
              Flexible(
                  flex: 3,
                  child: Text(
                    days[index].dayName,
                    style: AppTextStyles.body4,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
