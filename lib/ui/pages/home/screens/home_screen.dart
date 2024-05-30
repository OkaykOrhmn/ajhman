import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/button/primary_button.dart';
import 'package:ajhman/ui/widgets/card/new_course_card.dart';
import 'package:ajhman/ui/widgets/card/online_card.dart';
import 'package:ajhman/ui/widgets/card/recent_course_card.dart';
import 'package:ajhman/ui/widgets/image/primary_image_network.dart';
import 'package:ajhman/ui/widgets/listview/horizontal_listview.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:ajhman/ui/widgets/text_field/search_text_field.dart';
import 'package:ajhman/ui/widgets/text/title_divider.dart';
import 'package:ajhman/ui/widgets/text/title_divider.dart';
import 'package:ajhman/ui/widgets/text/title_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../gen/assets.gen.dart';
import '../../../widgets/carousel/carousel_banners.dart';
import '../../../widgets/states/place_holder/default_place_holder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchText = TextEditingController();
  final items = [1, 2, 3, 4];

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 120),
        child: Column(
          children: [
            _mainAppBar(context, themeData),
            _searchBar(themeData),
            _gridLayout(),
            const TitleDivider(title: "آنلاین‌شو"),
            const OnlineCard(),
            TitleDivider(title: "دوره‌های اخیرا دیده شده", btn: () {}),
            HorizontalListView(
              height: 195,
              item: (index) =>
                  RecentCourseCard(
                    index: index,
                  ),
              items: items,
            ),
            const SizedBox(
              height: 40,
            ),
            TitleDivider(title: "جدیدترین دوره ها", btn: () {}),
            HorizontalListView(
              height: 430,
              item: (index) => NewCourseCard(index: index),
              items: items,
              width: MediaQuery
                  .sizeOf(context)
                  .width / 1.6,
            ),

          ],
        ),
      ),
    );
  }

  Container _mainAppBar(BuildContext context, ThemeData themeData) {
    return Container(
      width: MediaQuery
          .sizeOf(context)
          .width,
      decoration: BoxDecoration(color: themeData.colorScheme.appPrimary),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 24),
            child: PrimaryText(
                text: "ظهر بخیر آقای موسوی",
                style: themeData.textTheme.titleBold,
                color: Colors.white),
          ),
          CarouseBanners(
            items: ["1", "2", "3", "4"],
          ),
          SizedBox(
            height: 24,
          )
        ],
      ),
    );
  }

  Padding _searchBar(ThemeData themeData) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: InkWell(
        borderRadius: DesignConfig.highBorderRadius,
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor100,
            borderRadius: DesignConfig.highBorderRadius,
            boxShadow: DesignConfig.defaultShadow,
          ),
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Assets.icon.outline.searchNormal.svg(color: backgroundColor600),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  color: backgroundColor600,
                  width: 1,
                  height: 20,
                ),
              ),
              PrimaryText(
                  text: "دنبال چی می گردی؟",
                  style: themeData.textTheme.searchHint,
                  color: backgroundColor600)
            ],
          ),
        ),
      ),
    );
  }

  Padding _gridLayout() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 40),
      child: Column(
        children: [
          Row(
            children: [
              _iconBtn("توسعه فردی", Assets.icon.twotone.userOctagon),
              _iconBtn("مدیریت کسب و کار", Assets.icon.twotone.presentionChart),
              _iconBtn("آژمان پلاس", Assets.icon.twotone.crown),
            ],
          ),
          Row(
            children: [
              _iconBtn("سواد مالی", Assets.icon.twotone.securityCard),
              _iconBtn("سواد فناوری", Assets.icon.twotone.monitorMobbile),
              _iconBtn("لقمه کتاب", Assets.icon.twotone.book),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconBtn(String title, SvgGenImage icon) {
    ThemeData themeData = Theme.of(context);
    return Expanded(
      child: InkWell(
        borderRadius: DesignConfig.highBorderRadius,
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
                color: backgroundColor100,
                borderRadius: DesignConfig.highBorderRadius,
                boxShadow: DesignConfig.defaultShadow),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon.svg(color: themeData.colorScheme.appPrimary),
                const SizedBox(
                  height: 8,
                ),
                PrimaryText(
                    text: title,
                    style: themeData.textTheme.searchHint,
                    color: grayColor700)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
