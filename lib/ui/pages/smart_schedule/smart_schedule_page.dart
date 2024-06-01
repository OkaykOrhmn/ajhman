import 'dart:ui';

import 'package:ajhman/ui/pages/smart_schedule/screens/time_screen.dart';
import 'package:ajhman/ui/pages/smart_schedule/screens/timer_screen.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/widgets/app_bar/primary_app_bar.dart';
import 'package:ajhman/ui/widgets/button/outlined_primary_button.dart';
import 'package:ajhman/ui/widgets/button/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/bloc/smart_schedule/smart_schedule_bloc.dart';
import '../../../core/utils/app_locale.dart';
import '../../../core/utils/language/bloc/language_bloc.dart';
import '../../../data/model/language.dart';
import '../../../gen/assets.gen.dart';
import 'screens/calender_screen.dart';
import '../../theme/bloc/theme_bloc.dart';
import '../../theme/text/text_styles.dart';
import '../../widgets/card/rounded_card_icon.dart';
import '../../widgets/divider/dashed_line.dart';

class SmartSchedulePage extends StatefulWidget {
  const SmartSchedulePage({super.key});

  @override
  State<SmartSchedulePage> createState() => _SmartSchedulePageState();
}

class _SmartSchedulePageState extends State<SmartSchedulePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PrimaryAppBar(title: ChangeLocale
        (context).appLocal!.smartScheduleTitle,),
      body: BlocConsumer<SmartScheduleBloc, SmartScheduleState>(
        listener: (context, state) {
          if (state is SmartScheduleCalender) {
            ShowWelcomeDialog(context);
          }
        },
        builder: (context, state) {
          return Column(
            children: [StepsBar(state), Expanded(child: StepsView(state))],
          );
        },
      ),
    );
  }

  Future<dynamic> ShowWelcomeDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            title: Center(child: Assets.icon.main.sIcon.svg()),
            content: Text(
              ChangeLocale(context).appLocal!.welcomeSmartSchedule,
              style: AppTextStyles.descWelcomeDialogSmartSchedule,
              textAlign: TextAlign.center,
            ),
            actions: [
              Center(
                child: OutlinedPrimaryButton(
                  title: ChangeLocale(context).appLocal!.confirm,
                  onClick: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget StepsView(SmartScheduleState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: primaryColor50, borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: state is SmartScheduleCalender
                    ? const CalenderScreen()
                    : state is SmartScheduleTime
                        ? const TimeScreen()
                        : state is SmartScheduleTimer
                            ? const TimerScreen()
                            : state is SmartScheduleError
                                ? Center(
                                    child: Text(state.error),
                                  )
                                : const Center(
                                    child: Text("empty"),
                                  ),
              ),
              ChangeStateButtons(context, state)
            ],
          )),
    );
  }


  Widget ChangeStateButtons(BuildContext context, SmartScheduleState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: PrimaryButton(
                title: ChangeLocale(context).appLocal!.confirm.toUpperCase(),
                onClick: () {
                  late SmartScheduleEvent cl = SmartScheduleToCalender();
                  if (state is SmartScheduleCalender) {
                    cl = SmartScheduleToTime();
                  } else if (state is SmartScheduleTime) {
                    cl = SmartScheduleToTimer();
                  } else if (state is SmartScheduleTimer) {
                    cl = SmartScheduleToSuccess();
                  }
                  context.read<SmartScheduleBloc>().add(cl);
                }),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: OutlinedPrimaryButton(
              title: ChangeLocale(context).appLocal!.reject.toUpperCase(),
              onClick: () {},
            ),
          )
        ],
      ),
    );
  }

  Widget StepsBar(SmartScheduleState state) {
    bool activeCalender = false;
    bool activeTime = false;
    bool activeTimer = false;

    if (state is SmartScheduleCalender) {
      activeCalender = true;
    } else if (state is SmartScheduleTime) {
      activeTime = true;
      activeCalender = true;
    } else if (state is SmartScheduleTimer || state is SmartScheduleSuccess) {
      activeTimer = true;
      activeTime = true;
      activeCalender = true;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
      child: Row(
        children: [
          RoundedCardIcon(
              svgGenImage: Assets.icon.outline.calendarTick,
              active: activeCalender),
          Expanded(
            child: MySeparator(
              active: activeCalender,
              dashed: activeCalender,
              dashSize: 8,
              height: 2,
            ),
          ),
          RoundedCardIcon(
              svgGenImage: Assets.icon.outline.timer, active: activeTime),
          Expanded(
            child: MySeparator(
              active: activeTime,
              dashed: activeTime,
              dashSize: 8,
              height: 2,
            ),
          ),
          RoundedCardIcon(
              svgGenImage: Assets.icon.outline.alarm, active: activeTimer),
        ],
      ),
    );
  }
}
