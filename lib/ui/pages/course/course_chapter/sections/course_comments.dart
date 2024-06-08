import 'package:ajhman/core/bloc/comments/comments_bloc.dart';
import 'package:ajhman/core/enum/comment.dart';
import 'package:ajhman/data/model/add_comment_request_model.dart';
import 'package:ajhman/data/model/comments_response_model.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/button/primary_button.dart';
import 'package:ajhman/ui/widgets/comment/comment_layout.dart';
import 'package:ajhman/ui/widgets/comment/reply_layout.dart';
import 'package:ajhman/ui/widgets/image/profile_image_network.dart';
import 'package:ajhman/ui/widgets/listview/vertical_listview.dart';
import 'package:ajhman/ui/widgets/text/icon_info.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:ajhman/ui/widgets/text/title_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../widgets/button/loading_btn.dart';

class CourseComments extends StatefulWidget {
  const CourseComments({super.key});

  @override
  State<CourseComments> createState() => _CourseCommentsState();
}

class _CourseCommentsState extends State<CourseComments> {
  @override
  void initState() {
    context.read<CommentsBloc>().add(GetComments(chapter: 1, subChapter: 1));
    super.initState();
  }

  List<CommentsResponseModel> comments = [];
  final TextEditingController _text = TextEditingController();
  final TextEditingController _resource = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
    return BlocConsumer<CommentsBloc, CommentsState>(
      listener: (context, state) {
        if (state.status == CommentStatus.success) {
          _text.clear();
          _resource.clear();
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case CommentStatus.addComment:
          case CommentStatus.changeStatus:
          case CommentStatus.success:
            comments = state.data!;
            return VerticalListView(
                item: (context, index) {
                  return Column(
                    children: [
                      CommentLayout(index: index, data: comments[index]),
                      VerticalListView(
                        item: (contextR, indexR) {
                          return ReplyLayout(
                              index: index,
                              data: comments[index].replies![indexR]);
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
                physics: const NeverScrollableScrollPhysics());
          case CommentStatus.fail:
            return SizedBox();
          default:
            return VerticalListView(
                item: (context,index) => Container(
                      width: MediaQuery.sizeOf(context).width,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: primaryColor50,
                          borderRadius: DesignConfig.highBorderRadius,
                          boxShadow: DesignConfig.lowShadow),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 48,
                                height: 48,
                                child: ProfileImageNetwork(
                                    src:
                                        "https://s3-alpha-sig.figma.com/img/6979/d837/b8c3d365a834f21f938e34ba7b745063?Expires=1717977600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=K5k8b9iabWknGQvO~8wp0LRu~RGy9OZ2VdUcVft8gfvP9Hh0qfeRPKnzO-88UhmPSqGvsGOVXBU55tiIDZDBuAoEOUcd4RH9MJKhew9grmawB3a0uivmEKHZhhH46-hQfBUd-nbWkcu7GJY83hfpVubdYPpmlCpG7w87j01acFOCfcJvuAcprbyHxELs5NuJ4TRsgRRc1sOBx5yr08PI2xWZ3nlgw2z1KAeFACXAhTqizMFE7Qfv39MQoQM0~TvskHP2vZLUMNNowHRqDHrwPbXi75NS4cz6LYvAPPv1~uEa~mLEJn0M~k1KsFXhSE73zlSp8fbO~eA25n6EVLTI-g__"),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PrimaryText(
                                        text: "علی موسوی",
                                        style: mThemeData.textTheme.rate,
                                        color: grayColor900),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        PrimaryText(
                                            text: "کارشناس ارشد",
                                            style: mThemeData
                                                .textTheme.navbarTitle,
                                            color: grayColor700),
                                        IconInfo(
                                            icon: Assets.icon.outline.clock,
                                            desc: "۹ ساعت پیش"),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          PrimaryText(
                              text:
                                  "یادگیریاصول و فنون مذاکرهیکی از مهارت‌هایی است که از اهمیت زیادی برخوردار است. اگر بخواهیم تعریفی مختصر و مفید از اصول و فنون مذاکره ارائه کنیم می‌توان گفت مذاکره ارتباطی بین دو یا چند نفر است که در مورد منافع خود با یکدیگر تعارض دارند.",
                              style: mThemeData.textTheme.title,
                              textAlign: TextAlign.justify,
                              color: grayColor800),
                          SizedBox(
                            height: 16,
                          ),
                          TitleDivider(
                            title: "منبع",
                            hasPadding: false,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          PrimaryText(
                              text:
                                  "دوره فنون مذاکره از مکتب خونه \n https://maktabkhooneh.org/course/fonon/mozakerh",
                              style: mThemeData.textTheme.title,
                              textAlign: TextAlign.justify,
                              color: grayColor800),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Assets.icon.bold.like.svg(
                                      color: errorMain, width: 16, height: 16),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  PrimaryText(
                                      text: "98",
                                      style: mThemeData.textTheme.title,
                                      color: grayColor800)
                                ],
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Container(
                                height: 12,
                                width: 1,
                                color: secondaryColor,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Row(
                                children: [
                                  Assets.icon.outline.dislike.svg(
                                      color: grayColor400,
                                      width: 16,
                                      height: 16),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  PrimaryText(
                                      text: "98",
                                      style: mThemeData.textTheme.title,
                                      color: grayColor800)
                                ],
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Container(
                                height: 12,
                                width: 1,
                                color: secondaryColor,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Row(
                                children: [
                                  Assets.icon.outline.reply.svg(
                                      color: grayColor400,
                                      width: 16,
                                      height: 16),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  PrimaryText(
                                      text: "98",
                                      style: mThemeData.textTheme.title,
                                      color: grayColor800)
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height / 3,
                items: null,
                physics: const NeverScrollableScrollPhysics());
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
                  context.read<CommentsBloc>().add(
                      AddComment(chapter: 1, subChapter: 1, comment: request));
                  await context.read<CommentsBloc>().stream.firstWhere(
                      (state) =>
                          state.status == CommentStatus.success ||
                          state.status == CommentStatus.fail);
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
