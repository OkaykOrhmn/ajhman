import 'package:ajhman/core/bloc/comments/comments_bloc.dart';
import 'package:ajhman/core/cubit/subchapter/sub_chapter_cubit.dart';
import 'package:ajhman/core/enum/dialogs_status.dart';
import 'package:ajhman/data/args/course_args.dart';
import 'package:ajhman/data/model/add_comment_request_model.dart';
import 'package:ajhman/data/model/comments_response_model.dart';
import 'package:ajhman/ui/theme/colors.dart';
import 'package:ajhman/ui/theme/text_styles.dart';
import 'package:ajhman/ui/theme/design_config.dart';
import 'package:ajhman/ui/widgets/comment/comment_layout.dart';
import 'package:ajhman/ui/widgets/loading/three_bounce_loading.dart';
import 'package:ajhman/ui/widgets/snackbar/snackbar_handler.dart';
import 'package:ajhman/ui/widgets/text/title_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_btn/loading_btn.dart';

import '../../../../../core/cubit/comment/feed_comment_cubit.dart';
import '../../../../theme/bloc/theme_bloc.dart';
import '../../../../widgets/button/loading_btn.dart';

class CourseComments extends StatefulWidget {
  final bool eng;
  const CourseComments({super.key, this.eng = false});

  @override
  State<CourseComments> createState() => _CourseCommentsState();
}

class _CourseCommentsState extends State<CourseComments> {
  late CourseArgs response;
  List<CommentsResponseModel> comments = [];

  @override
  void initState() {
    response = context.read<SubChapterCubit>().getData();
    super.initState();
  }

  final TextEditingController _text = TextEditingController();
  final TextEditingController _resource = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Theme.of(context).cardBackground(),
          borderRadius: DesignConfig.highBorderRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Divider(
              height: 1,
              color: Theme.of(context).disable(),
            ),
          ),
          _comments()
        ],
      ),
    );
  }

  Widget _comments() {
    return BlocConsumer<CommentsBloc, CommentsState>(
      listener: (context, state) async {
        // if (state is CommentSuccess) {
        //   await SnackBarHandler(context)
        //       .show("دیدگاهتون ثبت شد 😃", DialogStatus.success, true);
        // } else if (state is CommentAddFail) {
        //   await SnackBarHandler(context)
        //       .show("خطا در ثبت دیدگاه!!", DialogStatus.error, true);
        // } else if (state is CommentChangeFail) {
        //   await SnackBarHandler(context)
        //       .show("خطا در ثبت نظر!!", DialogStatus.error, true);
        // }
      },
      builder: (context, state) {
        if (state is CommentSuccess) {
          comments = state.response;
        } else if (state is CommentAddFail) {
          comments = state.response;
        } else if (state is CommentChangeFail) {
          comments = state.response;
        }
        if (state is CommentSuccess ||
            state is CommentAddFail ||
            state is CommentChangeFail) {
          return Column(
            children: [
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        BlocProvider<FeedCommentCubit>(
                          create: (context) => FeedCommentCubit(
                              comments,
                              response.chapterId,
                              response.chapterModel.id!,
                              context),
                          child: CommentLayout(
                              index: index, data: comments[index]),
                        ),
                        comments[index].replies != null
                            ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: comments[index].replies!.length,
                                itemBuilder: (context, indexR) {
                                  return BlocProvider<FeedCommentCubit>(
                                    create: (context) => FeedCommentCubit(
                                        comments,
                                        response.chapterId,
                                        response.chapterModel.id!,
                                        context),
                                    child: CommentLayout(
                                        index: indexR,
                                        data: comments[index].replies![indexR]),
                                  );
                                })
                            : const SizedBox()
                      ],
                    );
                  })
            ],
          );
        } else if (state is CommentEmpty) {
          return const SizedBox();
        } else {
          return const Center(
            child: ThreeBounceLoading(),
          );
        }
      },
    );
  }

  Column _header() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TitleDivider(
          title: widget.eng ? 'A bite to learn' : "یک لقمه یادگیری",
          hasPadding: false,
        ),
        const SizedBox(
          height: 16,
        ),
        _commentTextField(
            widget.eng
                ? "Share your information with your colleagues"
                : "اطلاعات خود را با همکارانتان به اشتراک بگذارید ",
            widget.eng
                ? "Example: To get more points, we must be calm in the negotiation"
                : "مثال: برای کسب امتیاز بیشتر باید در مذاکره آرام باشیم",
            true,
            _text),
        const SizedBox(
          height: 16,
        ),
        _commentTextField(
            widget.eng ? "Add resources" : "افزودن منابع ",
            widget.eng
                ? "If necessary, enter your sources as links"
                : "در صورت نیاز منابع خود را به صورت لینک وارد کنید",
            false,
            _resource),
        const SizedBox(
          height: 16,
        ),
        PrimaryLoadingButton(
            disable: false,
            title: widget.eng ? "Confirm and send" : "تایید و ارسال",
            onTap: (Function startLoading, Function stopLoading,
                ButtonState btnState) async {
              if (_text.text.isNotEmpty) {
                if (btnState == ButtonState.idle) {
                  startLoading();
                  AddCommentRequestModel request = AddCommentRequestModel(
                      text: _text.text,
                      resource: _resource.text,
                      commentId: null,
                      replyUserId: null);
                  context.read<CommentsBloc>().add(PostComments(
                      chapterId: response.chapterId,
                      subChapterId: response.chapterModel.id!,
                      request: request,
                      data: comments));
                  await context
                      .read<CommentsBloc>()
                      .stream
                      .firstWhere((state) =>
                          state is CommentSuccess || state is CommentAddFail)
                      .then((value) {
                    if (value is CommentSuccess) {
                      SnackBarHandler(context).show(
                          "دیدگاهتون ثبت شد 😃", DialogStatus.success, true);
                      _text.clear();
                      _resource.clear();
                      FocusScope.of(context).unfocus();
                    }
                    if (value is CommentAddFail) {
                      SnackBarHandler(context)
                          .show("خطا در ثبت نظر!!", DialogStatus.error, true);
                    }
                  });
                  stopLoading();
                }
              }
            }),
      ],
    );
  }

  Column _commentTextField(String title, String hint, bool important,
      TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: Theme.of(context).textTheme.title.copyWith(
                color: Theme.of(context).cardText(),
                fontSize: Theme.of(context).textTheme.title.fontSize! *
                    context.read<ThemeBloc>().state.fontSize),
            children: important
                ? <TextSpan>[
                    TextSpan(
                        text: '*',
                        style: Theme.of(context).textTheme.title.copyWith(
                            color: errorMain,
                            fontSize:
                                Theme.of(context).textTheme.title.fontSize! *
                                    context.read<ThemeBloc>().state.fontSize)),
                  ]
                : null,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).onWhite(),
              borderRadius: DesignConfig.mediumBorderRadius,
              boxShadow: DesignConfig.lowShadow),
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: controller,
            minLines: 4,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            maxLines: null,
            decoration: InputDecoration.collapsed(
              hintText: hint,
              hintStyle: Theme.of(context)
                  .textTheme
                  .searchHint
                  .copyWith(color: Theme.of(context).editTextFont()),
            ),
          ),
        ),
      ],
    );
  }
}
