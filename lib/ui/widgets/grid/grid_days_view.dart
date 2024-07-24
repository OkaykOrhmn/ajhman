import 'package:ajhman/core/bloc/smart_schedule/planner_cubit.dart';
import 'package:ajhman/data/model/planner_request_model.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_locale.dart';
import 'package:flutter/material.dart';

import '../../../data/model/days.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../theme/design_config.dart';
import '../check_box/days_check_box.dart';

class GridDaysView extends StatefulWidget {
  const GridDaysView({super.key});

  @override
  State<GridDaysView> createState() => _GridDaysViewState();
}

class _GridDaysViewState extends State<GridDaysView> {
  List<Days> days = [
    Days("", false),
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
    for (var element in days) {
      int index = days.indexOf(element);
      element.dayName = daysName[index];
    }

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
            return daysLayout(index);
          }),
    );
  }

  final planner = PlannerRequestModel(days: []);

  Widget daysLayout(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          days[index].isSelected = !days[index].isSelected;
          if (days[index].isSelected) {
            planner.days!.add(index + 1);
          }
          context.read<PlannerCubit>().setData(planner);
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).white(),
            borderRadius: DesignConfig.mediumBorderRadius,
            border: Border.all(
                width: 2,
                color: days[index].isSelected
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).white())),
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
                  flex: 2,
                  child: PrimaryText(
                    text: days[index].dayName,
                    style: Theme.of(context).textTheme.rate,
                    color: days[index].isSelected
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).pinTextFont(),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
