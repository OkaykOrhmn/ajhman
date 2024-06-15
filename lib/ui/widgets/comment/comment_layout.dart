import 'package:ajhman/core/enum/comment.dart';
import 'package:ajhman/data/model/comments_response_model.dart';
import 'package:ajhman/data/shared_preferences/profile_data.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/bloc/comments/comments_bloc.dart';
import '../../../core/utils/usefull_funcs.dart';
import '../../../data/model/profile_response_model.dart';
import '../../../gen/assets.gen.dart';
import '../../../main.dart';
import '../../theme/color/colors.dart';
import '../../theme/widget/design_config.dart';
import '../image/profile_image_network.dart';
import '../text/icon_info.dart';
import '../text/primary_text.dart';
import '../text/title_divider.dart';

class CommentLayout extends StatefulWidget {
  final int index;
  final CommentsResponseModel data;

  const CommentLayout({super.key, required this.index, required this.data});

  @override
  State<CommentLayout> createState() => _CommentLayoutState();
}

class _CommentLayoutState extends State<CommentLayout> {
  late int index;
  late CommentsResponseModel data;
  late ProfileResponseModel profile = ProfileResponseModel();

  void _clickFeed(CommentsResponseModel comment) {
    context.read<CommentsBloc>().add(ChangeFeedComment(
        comment: comment,
        chapter: 1,
        subChapter: 1,
        commentType: CommentType.normal));
  }

  @override
  Widget build(BuildContext context) {
    index = widget.index;
    data = widget.data;




          return Column(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: profile.id == data.user!.id
                        ? primaryColor50
                        : Colors.white,
                    borderRadius: DesignConfig.highBorderRadius,
                    boxShadow: DesignConfig.lowShadow),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _profile(),
                    const SizedBox(
                      height: 16,
                    ),
                    _commentInfoes(),
                    const SizedBox(
                      height: 16,
                    ),
                    _commentButtons()
                  ],
                ),
              ),
            ],
          );

  }

  Row _profile() {
    return Row(
      children: [
        ProfileImageNetwork(
            src:
                "https://s3-alpha-sig.figma.com/img/6979/d837/b8c3d365a834f21f938e34ba7b745063?Expires=1717977600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=K5k8b9iabWknGQvO~8wp0LRu~RGy9OZ2VdUcVft8gfvP9Hh0qfeRPKnzO-88UhmPSqGvsGOVXBU55tiIDZDBuAoEOUcd4RH9MJKhew9grmawB3a0uivmEKHZhhH46-hQfBUd-nbWkcu7GJY83hfpVubdYPpmlCpG7w87j01acFOCfcJvuAcprbyHxELs5NuJ4TRsgRRc1sOBx5yr08PI2xWZ3nlgw2z1KAeFACXAhTqizMFE7Qfv39MQoQM0~TvskHP2vZLUMNNowHRqDHrwPbXi75NS4cz6LYvAPPv1~uEa~mLEJn0M~k1KsFXhSE73zlSp8fbO~eA25n6EVLTI-g__", width: 48, height: 48,),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                  text: data.user!.name.toString(),
                  style: mThemeData.textTheme.rate,
                  color: grayColor900),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText(
                      text: "کارشناس ارشد",
                      style: mThemeData.textTheme.navbarTitle,
                      color: grayColor700),
                  IconInfo(
                      icon: Assets.icon.outline.clock,
                      desc:
                          "${convertDatetimeComment(data.createdAt!)} ساعت پیش"),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _commentButtons() {
    final state = context.watch<CommentsBloc>().state;
    return Row(
      children: [
        InkWell(
            onTap: state.status == CommentStatus.loading || state.status == CommentStatus.changeStatus? null: () {
              bool? feed = data.userFeedback;
              int countLike = data.likes!;
              int countDisLike = data.dislikes!;

              if (feed == null) {
                countLike += 1;
                feed = true;
              } else if (feed == true) {
                countLike -= 1;
                feed = null;
              } else if (feed == false) {
                countLike += 1;
                countDisLike -= 1;
                feed = true;
              }
              data.userFeedback = feed;
              data.likes = countLike;
              data.dislikes = countDisLike;

              _clickFeed(data);
            },
            child: _commentButton(data.likes.toString(), CommentBtnType.like,
                data.userFeedback, data.id!)),
        const SizedBox(
          width: 12,
        ),
        Container(
          height: 12,
          width: 1,
          color: secondaryColor,
        ),
        const SizedBox(
          width: 12,
        ),
        InkWell(
          onTap: state.status == CommentStatus.loading || state.status == CommentStatus.changeStatus? null: () {
            bool? feed = data.userFeedback;
            int countLike = data.likes!;
            int countDisLike = data.dislikes!;

            if (feed == null) {
              countDisLike += 1;
              feed = false;
            } else if (feed == true) {
              countLike -= 1;
              countDisLike += 1;
              feed = false;
            } else if (feed == false) {
              countDisLike -= 1;

              feed = false;
            }
            data.userFeedback = feed;
            data.likes = countLike;
            data.dislikes = countDisLike;

            _clickFeed(data);
          },
          child: _commentButton(
              data.dislikes.toString(),
              CommentBtnType.disLike,
              data.userFeedback != null ? !data.userFeedback! : null,
              data.id!),
        ),
        const SizedBox(
          width: 12,
        ),
        Container(
          height: 12,
          width: 1,
          color: secondaryColor,
        ),
        const SizedBox(
          width: 12,
        ),
        _commentButton(
            data.replies!.isEmpty ? '' : data.replies!.length.toString(),
            CommentBtnType.reply,
            null,
            data.id!),
      ],
    );
  }

  Widget _commentButton(
      String number, CommentBtnType type, bool? active, int id) {
    String src = type.icon;
    Color color = grayColor400;
    if (active != null && active) {
      src = type.fill;
      color = errorMain;
    }

    return Row(
      children: [
        _getSvgCommentBtn(src, color, id),
        const SizedBox(
          width: 8,
        ),
        PrimaryText(
            text: number,
            style: mThemeData.textTheme.title,
            color: grayColor800)
      ],
    );
  }

  Widget _getSvgCommentBtn(String src, Color color, int id) {
    final state = context.watch<CommentsBloc>().state;
    if (state.commentId == data.id) {
      switch (state.status) {
        case CommentStatus.success:
          return SvgGenImage(src).svg(color: color, width: 16, height: 16);

        case CommentStatus.changeStatus:
        case CommentStatus.loading:
        default:
          return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: SvgGenImage(src).svg(color: color, width: 16, height: 16));
      }
    } else {
      return SvgGenImage(src).svg(color: color, width: 16, height: 16);
    }
  }

  Column _commentInfoes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimaryText(
            text: data.text.toString(),
            style: mThemeData.textTheme.title,
            textAlign: TextAlign.justify,
            color: grayColor800),
        const SizedBox(
          height: 16,
        ),
        data.resource != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleDivider(
                    title: "منبع",
                    hasPadding: false,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  PrimaryText(
                      text: data.resource.toString(),
                      style: mThemeData.textTheme.title,
                      textAlign: TextAlign.justify,
                      color: grayColor800),
                ],
              )
            : const SizedBox(),
      ],
    );
  }
}
