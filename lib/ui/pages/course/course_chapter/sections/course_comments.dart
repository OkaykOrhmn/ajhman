import 'package:ajhman/core/bloc/comments/comments_bloc.dart';
import 'package:ajhman/core/cubit/subchapter/sub_chapter_cubit.dart';
import 'package:ajhman/core/enum/comment.dart';
import 'package:ajhman/data/args/course_args.dart';
import 'package:ajhman/data/model/add_comment_request_model.dart';
import 'package:ajhman/data/model/comments_response_model.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/button/primary_button.dart';
import 'package:ajhman/ui/widgets/comment/comment_layout.dart';
import 'package:ajhman/ui/widgets/image/profile_image_network.dart';
import 'package:ajhman/ui/widgets/listview/vertical_listview.dart';
import 'package:ajhman/ui/widgets/loading/three_bounce_loading.dart';
import 'package:ajhman/ui/widgets/text/icon_info.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:ajhman/ui/widgets/text/title_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/cubit/comment/feed_comment_cubit.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../widgets/button/loading_btn.dart';

class CourseComments extends StatefulWidget {
  const CourseComments({super.key});

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
    comments.clear();
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: backgroundColor100,
          borderRadius: DesignConfig.highBorderRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(
              height: 1,
              color: backgroundColor600,
            ),
          ),
          _comments()
        ],
      ),
    );
  }

  Widget _comments() {
    return BlocBuilder<CommentsBloc, CommentsState>(
      builder: (context, state) {

        List<CommentsResponseModel> comments = [];

        if(state is CommentSuccess){
          comments = state.response;
        }else if(state is CommentAddFail){
          comments = state.response;

        }else if(state is CommentChangeFail){
          comments = state.response;

        }
        if (state is CommentSuccess ||
            state is CommentAddFail ||
            state is CommentChangeFail) {
          return Column(
            children: [
              VerticalListView(
                  item: (context, index) {
                    return Column(
                      children: [
                        BlocProvider<FeedCommentCubit>(
                          create: (context) => FeedCommentCubit(comments,
                              response.chapterId, response.chapterModel.id!),
                          child: CommentLayout(
                              index: index, data: comments[index]),
                        ),
                        VerticalListView(
                          item: (contextR, indexR) {
                            return BlocProvider<FeedCommentCubit>(
                              create: (context) => FeedCommentCubit(
                                  comments,
                                  response.chapterId,
                                  response.chapterModel.id!),
                              child: CommentLayout(
                                  index: index,
                                  data:
                                  comments[index].replies![indexR]),
                            );
                          },
                          items: comments[index].replies,
                          physics: const NeverScrollableScrollPhysics(),
                        )
                      ],
                    );
                  },
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height / 3,
                  items: comments,
                  physics: const NeverScrollableScrollPhysics()),
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
          title: "یک لقمه یادگیری",
          hasPadding: false,
        ),
        const SizedBox(
          height: 16,
        ),
        _commentTextField(
            "اطلاعات خود را با همکارانتان به اشتراک بگذارید ",
            "مثال: برای کسب امتیاز بیشتر باید در مذاکره آرام باشیم",
            true,
            _text),
        const SizedBox(
          height: 16,
        ),
        _commentTextField(
            "افزودن منابع ",
            "در صورت نیاز منابع خود را به صورت لینک وارد کنید",
            false,
            _resource),
        const SizedBox(
          height: 16,
        ),
        PrimaryLoadingButton(
            disable: false,
            title: "تایید و ارسال",
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
                      _text.clear();
                      _resource.clear();
                      FocusScope.of(context).unfocus();
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
        Row(
          children: [
            PrimaryText(
                text: title,
                style: mThemeData.textTheme.title,
                color: backgroundColor800),
            important
                ? PrimaryText(
                    text: "*",
                    style: mThemeData.textTheme.title,
                    color: errorMain)
                : SizedBox(),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: DesignConfig.mediumBorderRadius,
              boxShadow: DesignConfig.lowShadow),
          padding: EdgeInsets.all(16),
          child: TextField(
            controller: controller,
            minLines: 4,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            maxLines: null,
            decoration: InputDecoration.collapsed(
              hintText: hint,
              hintStyle:
                  mThemeData.textTheme.searchHint.copyWith(color: grayColor300),
            ),
          ),
        ),
      ],
    );
  }
}
