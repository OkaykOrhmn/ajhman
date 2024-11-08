// ignore_for_file: deprecated_member_use_from_same_package

import 'package:ajhman/core/cubit/comment/feed_comment_cubit.dart';
import 'package:ajhman/core/enum/comment.dart';
import 'package:ajhman/data/model/comments_response_model.dart';
import 'package:ajhman/data/shared_preferences/profile_data.dart';
import 'package:ajhman/ui/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/usefull_funcs.dart';
import '../../../gen/assets.gen.dart';
import '../../theme/colors.dart';
import '../../theme/design_config.dart';
import '../image/profile_image_network.dart';
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

  @override
  Widget build(BuildContext context) {
    index = widget.index;
    data = widget.data;
    return FutureBuilder(
        future: getProfile(),
        builder: (context, snapshot) {
          return Container(
            width: MediaQuery.sizeOf(context).width,
            margin: const EdgeInsets.symmetric(vertical: 8)
                .copyWith(right: data.replyUser != null ? 32 : 0),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color:
                    snapshot.data != null && snapshot.data!.id == data.user!.id
                        ? Theme.of(context).surfaceCard()
                        : Theme.of(context).onWhite(),
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
                BlocBuilder<FeedCommentCubit, FeedCommentState>(
                  builder: (context, state) {
                    if (state is FeedCommentInitial ||
                        state is FeedCommentSuccess ||
                        state is FeedCommentFail) {
                      return Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if (data.userFeedback != null &&
                                  data.userFeedback!) {
                                context
                                    .read<FeedCommentCubit>()
                                    .changeFeed(null, data);
                              } else {
                                context
                                    .read<FeedCommentCubit>()
                                    .changeFeed(true, data);
                              }
                            },
                            child: _commentButton(data.likes.toString(),
                                CommentBtnType.like, data.userFeedback),
                          ),
                          Container(
                              height: 12,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: VerticalDivider(
                                width: 1,
                                color: Theme.of(context).secondaryColor(),
                              )),
                          InkWell(
                            onTap: () {
                              if (data.userFeedback != null &&
                                  !data.userFeedback!) {
                                context
                                    .read<FeedCommentCubit>()
                                    .changeFeed(null, data);
                              } else {
                                context
                                    .read<FeedCommentCubit>()
                                    .changeFeed(false, data);
                              }
                            },
                            child: _commentButton(
                              data.dislikes.toString(),
                              CommentBtnType.disLike,
                              data.userFeedback != null
                                  ? !data.userFeedback!
                                  : null,
                            ),
                          ),
                          Container(
                              height: 12,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: VerticalDivider(
                                width: 1,
                                color: Theme.of(context).secondaryColor(),
                              )),
                          _commentButton(
                              data.replies != null && data.replies!.isNotEmpty
                                  ? data.replies!.length.toString()
                                  : '',
                              CommentBtnType.reply,
                              false),
                        ],
                      );
                    } else {
                      return _loadingFeedBack();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Row _loadingFeedBack() {
    return Row(
      children: [
        Shimmer.fromColors(
          baseColor: Theme.of(context).placeholderBaseColor(),
          highlightColor: Theme.of(context).placeholderHighlightColor(),
          child: _commentButton(
              data.likes.toString(), CommentBtnType.like, data.userFeedback),
        ),
        Container(
            height: 12,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: VerticalDivider(
              width: 1,
              color: Theme.of(context).secondaryColor(),
            )),
        Shimmer.fromColors(
          baseColor: Theme.of(context).placeholderBaseColor(),
          highlightColor: Theme.of(context).placeholderHighlightColor(),
          child: _commentButton(data.dislikes.toString(),
              CommentBtnType.disLike, data.userFeedback),
        ),
        Container(
            height: 12,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: VerticalDivider(
              width: 1,
              color: Theme.of(context).secondaryColor(),
            )),
        Shimmer.fromColors(
          baseColor: Theme.of(context).placeholderBaseColor(),
          highlightColor: Theme.of(context).placeholderHighlightColor(),
          child: _commentButton(
              data.replies != null && data.replies!.isNotEmpty
                  ? data.replies!.length.toString()
                  : '',
              CommentBtnType.reply,
              false),
        ),
      ],
    );
  }

  Row _profile() {
    return Row(
      children: [
        ProfileImageNetwork(
          src: data.user!.image.toString(),
          width: 48,
          height: 48,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                  text: data.user!.name.toString(),
                  style: Theme.of(context).textTheme.rate,
                  color: Theme.of(context).progressText()),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Assets.icon.outline.clock.svg(
                      width: 12,
                      height: 12,
                      color: Theme.of(context).progressText()),
                  const SizedBox(
                    width: 8,
                  ),
                  PrimaryText(
                      maxLines: 1,
                      text:
                          "${convertDatetimeComment(data.createdAt!)} ساعت پیش",
                      style: Theme.of(context).textTheme.navbarTitle,
                      color: Theme.of(context).progressText())
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _commentButton(String number, CommentBtnType type, bool? active) {
    String src = type.icon;
    Color color = Theme.of(context).pinTextFont();
    if (active != null && active) {
      src = type.fill;
      color = errorMain;
    }

    return Row(
      children: [
        SvgGenImage(src).svg(color: color, width: 16, height: 16),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 4, 4, 0),
          child: PrimaryText(
              text: number,
              style: Theme.of(context).textTheme.title,
              color: Theme.of(context).pinTextFont()),
        )
      ],
    );
  }

  Column _commentInfoes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            data.replyUser != null
                ? PrimaryText(
                    text: "${data.replyUser!.name} ",
                    style: Theme.of(context).textTheme.titleBold,
                    textAlign: TextAlign.justify,
                    color: Theme.of(context).primaryColor)
                : const SizedBox(),
            PrimaryText(
                text: data.text.toString(),
                style: Theme.of(context).textTheme.title,
                textAlign: TextAlign.justify,
                color: Theme.of(context).pinTextFont()),
          ],
        ),
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
                      style: Theme.of(context).textTheme.title,
                      textAlign: TextAlign.justify,
                      color: Theme.of(context).pinTextFont()),
                ],
              )
            : const SizedBox(),
      ],
    );
  }
}

/*Widget _commentButtons() {
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
}*/
