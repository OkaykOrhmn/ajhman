import 'dart:math';

import 'package:ajhman/core/bloc/smart_schedule/planner_cubit.dart';
import 'package:ajhman/data/model/planner_request_model.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../core/utils/app_locale.dart';
import '../../../theme/text/text_styles.dart';
import '../../../theme/widget/design_config.dart';
import '../../../widgets/button/toggle_button_time.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with TickerProviderStateMixin {
  double _hValue = 1;
  double _mValue = 1;
  bool _inHour = true;
  bool _inLight = false;
  late AnimationController fadeIn;
  late Animation<double> animation;
  late PlannerRequestModel planner;

  @override
  initState() {
    fadeIn = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = CurvedAnimation(parent: fadeIn, curve: Curves.easeIn);
    planner = context.read<PlannerCubit>().state;
    fadeIn.forward();
    super.initState();
  }

  void click() {
    _inHour = !_inHour;
  }

  double getYofMoon(double x) {
    double r = 12;
    double a = -12;
    return sqrt(r * r - (x + a) * (x + a));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: PrimaryText(
            text: ChangeLocale(context).appLocal!.timerTitle,
            style: Theme.of(context).textTheme.title,
            color: Theme.of(context).cardText(),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: DesignConfig.highBorderRadius,
              color: Theme.of(context).white(),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 120,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: DesignConfig.aHighBorderRadius,
                        topRight: DesignConfig.aHighBorderRadius,
                      ),
                      child: Stack(
                        children: [
                          AnimatedPositioned(
                              top: _hValue * -84,
                              left: _hValue * -84,
                              duration: const Duration(microseconds: 500),
                              child: Container(
                                width: 300 * 8,
                                height: 300 * 8,
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                      Color(0xffF2F3C9),
                                      Color(0xff292929),
                                      Color(0xffBFF2FD),
                                      Color(0xff2ED4F9),
                                      Color(0xffFAD7A3),
                                      Color(0xff2ED4F9),
                                      Color(0xffB0B0B0),
                                      Color(0xff666666),
                                      Color(0xff292929),
                                    ])),
                              )),
                          AnimatedPositioned(
                              bottom: getYofMoon(_hValue) * 4,
                              left: (_hValue + 4) * 8,
                              duration: const Duration(microseconds: 500),
                              child: AnimatedSwitcher(
                                switchInCurve: Curves.linear,
                                switchOutCurve: Curves.linear,
                                duration: const Duration(milliseconds: 500),
                                child: _inLight
                                    ? Container(
                                        key: const ValueKey<int>(1),
                                        // Unique key for the first widget
                                        child: Assets.image.moon.son.image())
                                    : Container(
                                        key: const ValueKey<int>(2),
                                        // Unique key for the second widget
                                        child: Assets.image.moon.moon.image()),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(width: 4,),
                    PrimaryText(
                      text: "دقیقه",
                      style: Theme.of(context).textTheme.rate,
                      color: Theme.of(context).cardText(),
                    ),
                    const SizedBox(width: 4,),
                    PrimaryText(
                      text: "ساعت",
                      style: Theme.of(context).textTheme.rate,
                      color: Theme.of(context).cardText(),
                    ),
                  const SizedBox(width: 4,)
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ToggleButtonTime(
                      title: _mValue.round().toString(),
                      active: !_inHour,
                      click: () {
                        setState(() {
                          click();
                        });
                      },
                    ),
                    const Text("    :    "),
                    ToggleButtonTime(
                      title: _hValue.round().toString(),
                      active: _inHour,
                      click: () {
                        setState(() {
                          click();
                        });
                      },
                    ),
                  ],
                ),
                _inHour
                    ? Slider(
                        activeColor: Theme.of(context).primaryColor,
                        inactiveColor: grayColor50,
                        min: 0,
                        max: 24,
                        // labelPlacement: LabelPlacement.onTicks,
                        value: _hValue.round().toDouble(),
                        // interval: 1,
                        // showTicks: false,
                        // showLabels: false,
                        // enableTooltip: true,
                        // tooltipShape: SfPaddleTooltipShape(),
                        // showDividers: true,
                        // minorTicksPerInterval: 1,
                        onChanged: (value) {
                          final val = value;
                          setState(() {
                            if (value >= 1) {
                              _hValue = value;
                              if (value <= 8 || value >= 18) {
                                _inLight = false;
                              } else {
                                _inLight = true;
                              }
                            }
                            if (planner.startAt == null ||
                                planner.startAt!.isEmpty) {
                              planner.startAt =
                                  "${_hValue.round().toString().padLeft(2, "0")}:01";
                            } else {
                              planner.startAt =
                                  "${_hValue.round().toString().padLeft(2, "0")}${planner.startAt!.substring(2)}";
                            }
                            context.read<PlannerCubit>().setData(planner);
                          });
                        },
                      )
                    : Slider(
                        activeColor: Theme.of(context).primaryColor,
                        inactiveColor: grayColor50,
                        // dateFormat: DateFormat.H(),
                        min: 0,
                        max: 60,
                        // labelPlacement: LabelPlacement.onTicks,
                        value: _mValue.round().toDouble(),
                        // interval: 15,
                        // showTicks: true,
                        // showLabels: true,
                        // enableTooltip: true,
                        // minorTicksPerInterval: 1,
                        onChanged: (value) {
                          final val = value;
                          setState(() {
                            if (value <= 59) {
                              _mValue = value;
                            }
                            if (planner.startAt == null ||
                                planner.startAt!.isEmpty) {
                              planner.startAt =
                                  "01:${_mValue.round().toString().padLeft(2, "0")}";
                            } else {
                              planner.startAt =
                                  "${planner.startAt!.substring(0, 3)}${_mValue.round().toString().padLeft(2, "0")}";
                            }
                            context.read<PlannerCubit>().setData(planner);
                          });
                        },
                      ),
                const SizedBox(
                  height: 14,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
