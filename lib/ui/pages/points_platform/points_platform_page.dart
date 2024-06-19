import 'package:ajhman/core/utils/usefull_funcs.dart';
import 'package:ajhman/data/model/leaderboard_model.dart';
import 'package:ajhman/gen/assets.gen.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/app_bar/reversible_app_bar.dart';
import 'package:ajhman/ui/widgets/image/profile_image_network.dart';
import 'package:ajhman/ui/widgets/listview/vertical_listview.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PointsPlatformPage extends StatefulWidget {
  final LeaderboardModel response;

  const PointsPlatformPage({super.key, required this.response});

  @override
  State<PointsPlatformPage> createState() => _PointsPlatformPageState();
}

class _PointsPlatformPageState extends State<PointsPlatformPage> {
  late LeaderboardModel response;

  @override
  void initState() {
    response = widget.response;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    response = widget.response;

    return Scaffold(
      appBar: ReversibleAppBar(title: "سکوی امتیازات"),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            _header(),
            SizedBox(
              height: 24,
            ),
            _self(),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: VerticalListView(
                  items: response.users,
                  item: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: response.users![index].current!
                                  ? Theme.of(context).primaryColor50()
                                  : backgroundColor100,
                              borderRadius: DesignConfig.highBorderRadius,
                              border: response.users![index].current!
                                  ? Border(
                                      right: BorderSide(
                                          color: Theme.of(context).primaryColor, width: 4))
                                  : null,
                              boxShadow: DesignConfig.lowShadow),
                          padding: EdgeInsets.all(16),
                          child: _prof(response.users![index], index + 1)),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  Container _self() {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor50(),
        borderRadius: DesignConfig.highBorderRadius,
      ),
      child: Column(
        children: [
          _prof(response.user!, response.user!.rating!),
          SizedBox(
            height: 16,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: DesignConfig.highBorderRadius,
                color: Colors.white),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: VerticalListView(
                items: response.user!.examAnswer,
                item: (context, index) {
                  final exam = response.user!.examAnswer![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimaryText(
                            text:
                                "آزمون ${getChapterNumber(response.user!.examAnswer!.length - (index + 1))}",
                            style: mThemeData.textTheme.rate,
                            color: Theme.of(context).primaryColor800()),
                        
                        Expanded(
                          child: PrimaryText(
                              text: getIsoTimeDate(exam.createdAt.toString()),
                              style: mThemeData.textTheme.searchHint,
                              color: grayColor700),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: DesignConfig.lowBorderRadius,
                              color: exam.score! > 60
                                  ? successBackground
                                  : errorBackground),
                          padding: EdgeInsets.all(8),
                          child: PrimaryText(
                              text: exam.score.toString(),
                              style: mThemeData.textTheme.rate,
                              color:
                              exam.score! > 60 ? successMain : errorMain),
                        )

                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Column _leaderUser(User users) {
    return Column(
      children: [
        ProfileImageNetwork(
          src: getImageUrl(users.image),
          width: 48,
          height: 48,
        ),
        SizedBox(
          height: 8,
        ),
        PrimaryText(
            text: users.name.toString(),
            style: mThemeData.textTheme.title,
            color: Theme.of(context).primaryColor900()),
        SizedBox(
          height: 36,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Assets.icon.outlineMedal
                .svg(width: 14, height: 14, color: secondaryColor),
            Expanded(
              child: PrimaryText(
                  text: "${users.score} امتیاز",
                  maxLines: 1,
                  textAlign: TextAlign.end,
                  style: mThemeData.textTheme.navbarTitle,
                  color: grayColor700),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Assets.icon.outline.exam
                .svg(width: 14, height: 14, color: secondaryColor),
            Expanded(
              child: PrimaryText(
                  text: "${users.courses} دوره",
                  maxLines: 1,
                  textAlign: TextAlign.end,
                  style: mThemeData.textTheme.navbarTitle,
                  color: grayColor700),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Assets.icon.outline.note2
                .svg(width: 14, height: 14, color: secondaryColor),
            Expanded(
              child: PrimaryText(
                  text: "${users.licenses} گواهینامه",
                  maxLines: 1,
                  textAlign: TextAlign.end,
                  style: mThemeData.textTheme.navbarTitle,
                  color: grayColor700),
            ),
          ],
        ),
      ],
    );
  }

  Column _prof(User user, int index) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ProfileImageNetwork(
                    src: getImageUrl(user.image), width: 48, height: 48),
                SizedBox(
                  width: 8,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryText(
                        text: user.name.toString(),
                        style: mThemeData.textTheme.rate,
                        color: grayColor900),
                    /*       SizedBox(
                      height: 8,
                    ),
                    PrimaryText(
                        text: " کارمند بخش انبار",
                        style: mThemeData.textTheme.navbarTitle,
                        color: grayColor800),*/
                  ],
                )
              ],
            ),
            Container(
              width: 32,
              height: 32,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: secondaryColor),
              padding: EdgeInsets.all(6),
              child: Center(
                  child: PrimaryText(
                      text: index.toString(),
                      style: mThemeData.textTheme.titleBold,
                      color: Colors.white)),
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
            Assets.icon.outlineMedal
                .svg(width: 14, height: 14, color: secondaryColor),
            SizedBox(
              width: 8,
            ),
            PrimaryText(
                text: "${user.score} امتیاز",
                style: mThemeData.textTheme.searchHint,
                color: grayColor800)
                          ],
                        ),
            Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
            Assets.icon.outline.exam
                .svg(width: 14, height: 14, color: secondaryColor),
            SizedBox(
              width: 8,
            ),
            PrimaryText(
                text: "${user.courses} دوره",
                style: mThemeData.textTheme.searchHint,
                color: grayColor800)
                          ],
                        ),
            Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
            Assets.icon.outline.note2
                .svg(width: 14, height: 14, color: secondaryColor),
            SizedBox(
              width: 8,
            ),
            PrimaryText(
                text: "${user.licenses} گواهینامه",
                style: mThemeData.textTheme.searchHint,
                color: grayColor800)
                          ],
                        ),
          ],
        ),
      ],
    );
  }

  Widget _header() {
    User userOne = response.users![0];
    User userTwo = response.users![1];
    User userThree = response.users![2];
    return Column(
      children: [
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 12),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: backgroundColor100,
                          borderRadius: DesignConfig.highBorderRadius,
                          boxShadow: DesignConfig.lowShadow),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Assets.icon.medal2.image(width: 32, height: 32),
                          SizedBox(
                            height: 16,
                          ),
                          _leaderUser(userTwo)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor50(),
                          borderRadius: BorderRadius.only(
                              topLeft: DesignConfig.aHighBorderRadius,
                              topRight: DesignConfig.aHighBorderRadius)),
                      child: SizedBox(
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(4),
                              child: Center(
                                child: PrimaryText(
                                    text: "2",
                                    style: mThemeData.textTheme.titleBold,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 12, left: 12),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: backgroundColor100,
                          borderRadius: DesignConfig.highBorderRadius,
                          boxShadow: DesignConfig.lowShadow),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Assets.icon.medal1.image(width: 32, height: 32),
                          SizedBox(
                            height: 16,
                          ),
                          _leaderUser(userOne)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor50(),
                          borderRadius: BorderRadius.only(
                              topLeft: DesignConfig.aHighBorderRadius,
                              topRight: DesignConfig.aHighBorderRadius)),
                      child: SizedBox(
                        height: 110,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(4),
                              child: Center(
                                child: PrimaryText(
                                    text: "1",
                                    style: mThemeData.textTheme.titleBold,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 12, left: 16),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: backgroundColor100,
                          borderRadius: DesignConfig.highBorderRadius,
                          boxShadow: DesignConfig.lowShadow),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Assets.icon.medal3.image(width: 32, height: 32),
                          SizedBox(
                            height: 16,
                          ),
                          _leaderUser(userThree)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor50(),
                          borderRadius: BorderRadius.only(
                              topLeft: DesignConfig.aHighBorderRadius,
                              topRight: DesignConfig.aHighBorderRadius)),
                      child: SizedBox(
                        height: 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(4),
                              child: Center(
                                child: PrimaryText(
                                    text: "3",
                                    style: mThemeData.textTheme.titleBold,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 12,
          width: MediaQuery.sizeOf(context).width,
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor800(),
              borderRadius: BorderRadius.only(
                  bottomRight: DesignConfig.aLowBorderRadius,
                  bottomLeft: DesignConfig.aLowBorderRadius)),
        ),
      ],
    );
  }
}
