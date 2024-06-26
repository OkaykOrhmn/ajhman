
import 'package:ajhman/core/bloc/smart_schedule/planner_cubit.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/pages/smart_schedule/screens/time_screen.dart';
import 'package:ajhman/ui/pages/smart_schedule/screens/timer_screen.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/widgets/app_bar/primary_app_bar.dart';
import 'package:ajhman/ui/widgets/button/outlined_primary_button.dart';
import 'package:ajhman/ui/widgets/button/primary_button.dart';
import 'package:ajhman/ui/widgets/dialogs/dialog_handler.dart';
import 'package:ajhman/ui/widgets/loading/three_bounce_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/bloc/smart_schedule/smart_schedule_bloc.dart';
import '../../../core/enum/dialogs_status.dart';
import '../../../core/utils/app_locale.dart';
import '../../../gen/assets.gen.dart';
import '../../widgets/snackbar/snackbar_handler.dart';
import 'screens/calender_screen.dart';
import '../../widgets/card/rounded_card_icon.dart';
import '../../widgets/divider/horizontal_dashed_line.dart';

class SmartSchedulePage extends StatefulWidget {
  const SmartSchedulePage({super.key});

  @override
  State<SmartSchedulePage> createState() => _SmartSchedulePageState();
}

class _SmartSchedulePageState extends State<SmartSchedulePage> {
  @override
  void initState() {
    super.initState();
    DialogHandler(context).showWelcomeDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).background(),
      appBar: PrimaryAppBar(
        title: ChangeLocale(context).appLocal!.smartScheduleTitle,
      ),
      body: BlocConsumer<SmartScheduleBloc, SmartScheduleState>(
        listener: (context, state) {
          if (state is SmartScheduleSuccess) {
            navigatorKey.currentState!.pop();
            SnackBarHandler(context)
                .show("با موفقیت انتخاب شد!", DialogStatus.success, true);
          } else if (state is SmartScheduleError) {
            SnackBarHandler(context)
                .show("خطا! دوباره امتحان کنید.", DialogStatus.error, true);
            context.read<SmartScheduleBloc>().add(SmartScheduleToCalender());
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

  Widget StepsView(SmartScheduleState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Theme.of(context).surfaceCard()
              , borderRadius: BorderRadius.circular(20)),
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
                            : const ThreeBounceLoading(),
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
                    if (context.read<PlannerCubit>().state.days == null ||
                        context.read<PlannerCubit>().state.days!.isEmpty) {
                      SnackBarHandler(context).show(
                          "حداقل یک روز را انتخاب کنید!",
                          DialogStatus.warning,
                          true);
                      return;
                    }
                    cl = SmartScheduleToTime();
                  } else if (state is SmartScheduleTime) {

                    if (context.read<PlannerCubit>().state.time == null) {
                      SnackBarHandler(context).show(
                          "زمان را انتخاب کنید!", DialogStatus.warning, true);
                      return;
                    }
                    cl = SmartScheduleToTimer();
                  } else if (state is SmartScheduleTimer) {
                    cl = PutPlanner(
                        plannerRequestModel:
                            context.read<PlannerCubit>().state);
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
              onClick: () {
                late SmartScheduleEvent cl = SmartScheduleToCalender();
                if (state is SmartScheduleTimer) {
                  cl = SmartScheduleToTime();
                } else if (state is SmartScheduleTime) {
                  cl = SmartScheduleToCalender();
                }

                context.read<SmartScheduleBloc>().add(cl);
              },
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
            child: HorizontalDashedLine(
              active: activeCalender ? Theme.of(context).primaryColor : null,
              dashed: activeCalender,
              dashSize: 8,
              height: 2,
            ),
          ),
          RoundedCardIcon(
              svgGenImage: Assets.icon.outline.timer, active: activeTime),
          Expanded(
            child: HorizontalDashedLine(
              active: activeCalender ? Theme.of(context).primaryColor : null,
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
