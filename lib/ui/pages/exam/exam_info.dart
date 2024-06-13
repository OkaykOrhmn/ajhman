import 'package:ajhman/core/routes/route_paths.dart';
import 'package:ajhman/data/args/exam_args.dart';
import 'package:ajhman/data/model/exam_response_model.dart';
import 'package:ajhman/data/repository/exam_repository.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/pages/exam/screens/exam_comment_screen.dart';
import 'package:ajhman/ui/pages/exam/screens/exam_info_screen.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/app_bar/reversible_app_bar.dart';
import 'package:ajhman/ui/widgets/button/loading_btn.dart';
import 'package:ajhman/ui/widgets/button/primary_button.dart';
import 'package:ajhman/ui/widgets/listview/highlight_listview.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:pinput/pinput.dart';

import '../../../gen/assets.gen.dart';

class ExamInfo extends StatefulWidget {
  final int courseId;
  const ExamInfo({super.key, required this.courseId});

  @override
  State<ExamInfo> createState() => _ExamInfoState();
}

class _ExamInfoState extends State<ExamInfo> {
  int index = 0;
  TextEditingController _comment = TextEditingController();

  @override
  void initState() {
    _comment.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (index == 1) {
          setState(() {
            index -= 1;
          });
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
          appBar: ReversibleAppBar(
              title: index == 0 ? "آزمون دوره" : "آنچه شما یاد گرفته‌اید"),
          body: Container(
            margin: const EdgeInsets.all(16),
            child: Stack(
              children: [
                IndexedStack(
                  index: index,
                  children: [
                    ExamCommentScreen(
                      comment: _comment,
                    ),
                    ExamInfoScreen(comment: _comment.text,),
                  ],
                ),
                Positioned(
                  bottom: 38,
                  left: 16,
                  right: 16,
                  child: PrimaryLoadingButton(
                    title: index == 0 ? 'تایید و ادامه' : "شروع آزمون",
                    disable: _comment.text.length < 5,
                    onTap: (Function startLoading, Function stopLoading,
                        ButtonState btnState) async {
                      if (btnState == ButtonState.idle) {
                        startLoading();
                        FocusScope.of(context).unfocus();
                        switch (index) {
                          case 0:
                            if (_comment.text.length >= 5) {
                              setState(() {
                                index += 1;
                              });
                            }

                            break;
                          case 1:
                            try {
                              ExamResponseModel response =
                              await examRepository.getExam(widget.courseId);
                              final args = ExamArgs(
                                  model: response, comment: _comment.text);
                              navigatorKey.currentState!.pushReplacementNamed(
                                  RoutePaths.exam,
                                  arguments: args);
                            } on DioError catch (e) {}
                            break;
                        }

                        stopLoading();
                      }
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }
}
