// ignore_for_file: use_build_context_synchronously

import 'package:ajhman/core/enum/dialogs_status.dart';
import 'package:ajhman/data/args/course_main_args.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/pages/course/course_info_page.dart';
import 'package:ajhman/ui/pages/roadmap/roadmap_page.dart';
import 'package:ajhman/ui/theme/colors.dart';
import 'package:ajhman/ui/widgets/app_bar/reversible_app_bar.dart';
import 'package:ajhman/ui/widgets/snackbar/snackbar_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif/gif.dart';
import 'package:loading_btn/loading_btn.dart';

import '../../../core/bloc/course/course_main_bloc.dart';
import '../../../core/bloc/questions/questions_bloc.dart';
import '../../../gen/assets.gen.dart';
import '../../widgets/button/outline_primary_loading_button.dart';

class CourseMainPage extends StatefulWidget {
  final CourseMainArgs args;

  const CourseMainPage({super.key, required this.args});

  @override
  State<CourseMainPage> createState() => _CourseMainPageState();
}

class _CourseMainPageState extends State<CourseMainPage> {
  @override
  void initState() {
    // context.read<CourseMainBloc>().add(GetCourseMainInfo(courseId: widget.args.courseId!));
    context
        .read<CourseMainBloc>()
        .add(GetRoadMap(courseId: widget.args.courseId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).background(),
      appBar: const ReversibleAppBar(title: "محتوای دوره"),
      body: BlocConsumer<CourseMainBloc, CourseMainState>(
        builder: (context, state) {
          if (state is CourseMainSuccess) {
            return CourseInfoPage(response: state.response);
          } else if (state is CourseRoadmapSuccess) {
            if (widget.args.catId == 6) {
              return Center(
                child: Gif(
                  image: Assets.gif.roadMapLoading.provider(),
                  autostart: Autostart.loop,
                ),
              );
            } else {
              return Stack(
                children: [
                  RoadMapPage(
                    response: state.response,
                    tag: widget.args.tag.toString(),
                  ),
                  Positioned(
                      bottom: 24,
                      left: 16,
                      right: 16,
                      child: OutlinePrimaryLoadingButton(
                        title: "رفتن به صفحه دوره",
                        onTap: (Function startLoading, Function stopLoading,
                            ButtonState btnState) async {
                          if (btnState == ButtonState.idle) {
                            startLoading();

                            context.read<QuestionsBloc>().add(
                                GetAllQuestions(id: widget.args.courseId!));

                            await context
                                .read<QuestionsBloc>()
                                .stream
                                .firstWhere((state) =>
                                    state is QuestionsSuccess ||
                                    state is QuestionsFail);

                            context.read<CourseMainBloc>().add(
                                GetCourseMainInfo(
                                    courseId: widget.args.courseId!));

                            await context
                                .read<CourseMainBloc>()
                                .stream
                                .firstWhere((state) =>
                                    state is CourseMainSuccess ||
                                    state is CourseMainFail);

                            stopLoading();
                          }
                        },
                        disable: false,
                      ))
                ],
              );
            }
          } else {
            return Center(
              child: Gif(
                image: Assets.gif.roadMapLoading.provider(),
                autostart: Autostart.loop,
              ),
            );
          }
        },
        listener: (BuildContext context, CourseMainState state) async {
          if (state is CourseRoadmapEmpty) {
            context
                .read<CourseMainBloc>()
                .add(GetCourseMainInfo(courseId: widget.args.courseId!));
            context
                .read<QuestionsBloc>()
                .add(GetAllQuestions(id: widget.args.courseId!));
          } else if (state is CourseMainFail) {
            SnackBarHandler(context).show(
                "خطایی رخ داده دوباره امتحان کنید!", DialogStatus.error, true);
            navigatorKey.currentState!.pop();
          } else if (widget.args.catId == 6) {
            context
                .read<QuestionsBloc>()
                .add(GetAllQuestions(id: widget.args.courseId!));

            await context.read<QuestionsBloc>().stream.firstWhere(
                (state) => state is QuestionsSuccess || state is QuestionsFail);

            context
                .read<CourseMainBloc>()
                .add(GetCourseMainInfo(courseId: widget.args.courseId!));

            await context.read<CourseMainBloc>().stream.firstWhere((state) =>
                state is CourseMainSuccess || state is CourseMainFail);
          }
        },
      ),
    );
  }
}
