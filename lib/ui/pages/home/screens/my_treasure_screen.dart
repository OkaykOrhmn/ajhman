import 'package:ajhman/core/utils/usefull_funcs.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/button/outlined_primary_button.dart';
import 'package:ajhman/ui/widgets/image/primary_image_network.dart';
import 'package:ajhman/ui/widgets/listview/vertical_listview.dart';
import 'package:ajhman/ui/widgets/states/place_holder/default_place_holder.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/treasure/treasure_bloc.dart';
import '../../../../data/model/my_treasure_model.dart';
import '../../../../gen/assets.gen.dart';

class MyTreasureScreen extends StatefulWidget {
  const MyTreasureScreen({super.key});

  @override
  State<MyTreasureScreen> createState() => _MyTreasureScreenState();
}

class _MyTreasureScreenState extends State<MyTreasureScreen> {
  @override
  void initState() {
    context.read<TreasureBloc>().add(GetAllTreasure());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<TreasureBloc, TreasureState>(
          builder: (context, state) {
            if (state is TreasureSuccess) {
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: backgroundColor100,
                        borderRadius: DesignConfig.highBorderRadius,
                        boxShadow: DesignConfig.lowShadow),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              borderRadius: DesignConfig.highBorderRadius,
                              boxShadow: DesignConfig.lowShadow,
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Assets.icon.bold.medalStar
                                  .svg(color: goldColor, width: 32, height: 32),
                              const SizedBox(
                                width: 8,
                              ),
                              PrimaryText(
                                  text: "گواهینامه‌های طلایی",
                                  style: mThemeData.textTheme.headerLargeBold,
                                  color: goldColor),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PrimaryText(
                              text:
                                  "با اعلام این امتیاز به سازمان خود، می‌توانید سرتیفیکت معتبر دریافت نمایید.",
                              style: mThemeData.textTheme.title,
                              color: grayColor900),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        state.response.gold!.isEmpty
                            ? _empty()
                            : VerticalListView(
                                item: (context, index) =>
                                    _goldCard(state.response.gold![index]),
                                items: state.response.gold,
                                placeholder: _goldCardPlaceholder(),
                              ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: DesignConfig.highBorderRadius,
                      color: backgroundColor100,
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              borderRadius: DesignConfig.highBorderRadius,
                              boxShadow: DesignConfig.lowShadow,
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Assets.icon.bold.medalStar.svg(
                                  color: silverColor, width: 32, height: 32),
                              const SizedBox(
                                width: 8,
                              ),
                              PrimaryText(
                                  text: "گواهینامه‌های نقره‌ای",
                                  style: mThemeData.textTheme.headerLargeBold,
                                  color: silverColor),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PrimaryText(
                              text:
                                  "با اعلام این امتیاز به سازمان خود، می‌توانید سرتیفیکت معتبر دریافت نمایید.",
                              style: mThemeData.textTheme.title,
                              color: grayColor900),
                        ),
                        state.response.silver!.isEmpty
                            ? _empty()
                            : VerticalListView(
                                item: (context, index) =>
                                    _goldCard(state.response.silver![index]),
                                items: state.response.silver,
                                placeholder: _goldCardPlaceholder(),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: DesignConfig.highBorderRadius,
                      color: backgroundColor100,
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              borderRadius: DesignConfig.highBorderRadius,
                              boxShadow: DesignConfig.lowShadow,
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Assets.icon.bold.medalStar.svg(
                                  color: bronzeColor, width: 32, height: 32),
                              const SizedBox(
                                width: 8,
                              ),
                              PrimaryText(
                                  text: "گواهینامه‌های برنزی",
                                  style: mThemeData.textTheme.headerLargeBold,
                                  color: bronzeColor),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PrimaryText(
                              text:
                                  "با اعلام این امتیاز به سازمان خود، می‌توانید سرتیفیکت معتبر دریافت نمایید.",
                              style: mThemeData.textTheme.title,
                              color: grayColor900),
                        ),
                        state.response.bronze!.isEmpty
                            ? _empty()
                            : VerticalListView(
                                item: (context, index) =>
                                    _goldCard(state.response.bronze![index]),
                                items: state.response.bronze,
                                placeholder: _goldCardPlaceholder(),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  )
                ],
              );
            } else {
              return VerticalListView(item: (_,index)=>const SizedBox(),items: null,placeholder: _goldCardPlaceholder(),);
            }
          },
        ),
      ),
    );
  }

  Column _empty() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Assets.image.emptyMessageFrame.svg(),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: PrimaryText(
              text: "هنوز موفق به کسب امتیاز حد نصاب نشده‌اید.",
              style: mThemeData.textTheme.title,
              color: grayColor900),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 24.0,
            right: 24,
          ),
          child: OutlinedPrimaryButton(
            title: "رفتن به دوره‌ها",
            fill: true,
          ),
        )
      ],
    );
  }

  Widget _goldCardPlaceholder() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: DefaultPlaceHolder(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: DesignConfig.highBorderRadius,
              color: Colors.white,
              boxShadow: DesignConfig.lowShadow),
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              const SizedBox(
                width: 130,
                child: PrimaryImageNetwork(
                  src:
                      "https://www.figma.com/file/Qe9pcE7Ts9ZtdwPvUUlBmA/image/bd864d27ffd8c447963a0387ee0141328e0d3715",
                  aspectRatio: 16 / 9,
                  radius: DesignConfig.lowBorderRadius,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryText(
                      text: "دوره هوش مصنوعی",
                      style: mThemeData.textTheme.title,
                      color: grayColor900),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Assets.icon.boldMedal
                          .svg(color: goldColor, width: 16, height: 16),
                      const SizedBox(
                        width: 4,
                      ),
                      PrimaryText(
                          text: "۳۲۴۱ امتیاز",
                          style: mThemeData.textTheme.searchHint,
                          color: grayColor700),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _goldCard(Gold data) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: DesignConfig.highBorderRadius,
          color: Colors.white,
          boxShadow: DesignConfig.lowShadow),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: PrimaryImageNetwork(
              src: getImageUrl(data.image..toString()),
              aspectRatio: 16 / 9,
              radius: DesignConfig.lowBorderRadius,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                  text: data.name.toString(),
                  style: mThemeData.textTheme.title,
                  color: grayColor900),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Assets.icon.boldMedal
                      .svg(color: goldColor, width: 16, height: 16),
                  const SizedBox(
                    width: 4,
                  ),
                  PrimaryText(
                      text: "${data.score!} امتیاز",
                      style: mThemeData.textTheme.searchHint,
                      color: grayColor700),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
