import 'dart:ffi';

import 'package:ajhman/core/bloc/smart_schedule/planner_cubit.dart';
import 'package:ajhman/core/utils/extentions.dart';
import 'package:ajhman/data/model/planner_request_model.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_locale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../../../data/model/t_buttons.dart';
import '../../../../gen/assets.gen.dart';
import '../../../widgets/button/little_primary_button.dart';
import '../../../widgets/button/toggle_buttons_row.dart';


class TimeScreen extends StatefulWidget {
  const TimeScreen({super.key});

  @override
  State<TimeScreen> createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen> {
  String timeSelectedTv = "";
  int timeSelectedValue = 0;
  final TextEditingController _minInput = TextEditingController();

  List<TButtons> buttons = [
    TButtons("", false),
    TButtons("", false),
    TButtons("", false),
  ];

  late PlannerRequestModel planner;

  @override
  void initState() {
    _minInput.addListener(() {
      setState(() {});
    });
    planner = context.read<PlannerCubit>().state;
    _minInput.addListener(() {
      planner.time = timeSelectedValue;
      context.read<PlannerCubit>().setData(planner);
    });
    super.initState();
  }

  void checkActivateButtons() {
    setState(() {
      buttons.forEach((element) {
        try {
          if (int.parse(element.name.withOutLabel) ==
              int.parse(_minInput.text.withOutLabel)) {
            print("true");
            element.active = true;
          } else {
            element.active = false;
          }
        } catch (ex) {
          element.active = false;
        }
      });
    });
  }

  dynamic _plusMinInputValue() {
    try {
      if (_minInput.text.isNotEmpty) {
        _minInput.text =
            (int.parse(_minInput.text.withOutLabel) + 15).toString().withLabel;
      } else {
        _minInput.text = 15.toString().withLabel;
      }
    } catch (ex) {}
    checkActivateButtons();
  }

  dynamic _minusMinInputValue() {
    if (_minInput.text.isNotEmpty) {
      try {
        if (int.parse(_minInput.text.withOutLabel) > 15) {
          _minInput.text = (int.parse(_minInput.text.withOutLabel) - 15)
              .toString()
              .withLabel;
        }
      } catch (ex) {}
    }
    checkActivateButtons();
  }

  @override
  Widget build(BuildContext context) {
    List<String> names = [
      ChangeLocale(context).appLocal!.min45,
      ChangeLocale(context).appLocal!.min30,
      ChangeLocale(context).appLocal!.min15,
    ];
    buttons.forEach((element) {
      int index = buttons.indexOf(element);
      element.name = names[index];
    });

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            ChangeLocale(context).appLocal!.timeTitle,
            style: body1,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: ToggleButtonsRow(
            buttons: buttons,
            extraClick: (index) {
              _minInput.clear();
            },
          ),
        ),
        TimeInput(context),
        Expanded(child: Assets.image.timerFrame.image())
      ],
    );
  }

  Padding TimeInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Row(
        children: [
          LittlePrimaryButton(
            icon: Icons.add,
            onClick: _plusMinInputValue,
          ),
          Expanded(
              flex: 2,
              child: SizedBox(
                child: Center(
                  child: TextField(
                    onChanged: (val) {
                      if (val != "" || val == "دقیقه") {
                        _minInput.text = _minInput.text.withLabel;
                        _minInput.selection = TextSelection.collapsed(
                            offset: _minInput.text.length);
                      }
                      print("change");
                    },
                    style: body1,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: _minInput,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: ChangeLocale(context).appLocal!.enterTime,
                      hintStyle: body4,
                    ),
                  ),
                ),
              )),
          LittlePrimaryButton(
            icon: Icons.remove,
            onClick: _minusMinInputValue,
          ),
        ],
      ),
    );
  }
}
