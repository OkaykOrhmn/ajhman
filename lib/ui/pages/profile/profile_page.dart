import 'package:ajhman/core/cubit/image_picker/image_picker_cubit.dart';
import 'package:ajhman/core/cubit/image_picker/image_picker_cubit.dart';
import 'package:ajhman/core/routes/route_paths.dart';
import 'package:ajhman/core/utils/usefull_funcs.dart';
import 'package:ajhman/data/model/profile_response_model.dart';
import 'package:ajhman/data/repository/profile_repository.dart';
import 'package:ajhman/data/shared_preferences/auth_token.dart';
import 'package:ajhman/data/shared_preferences/profile_data.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/theme/widget/design_config.dart';
import 'package:ajhman/ui/widgets/app_bar/reversible_app_bar.dart';
import 'package:ajhman/ui/widgets/dialogs/dialog_handler.dart';
import 'package:ajhman/ui/widgets/image/profile_image_network.dart';
import 'package:ajhman/ui/widgets/loading/three_bounce_loading.dart';
import 'package:ajhman/ui/widgets/states/place_holder/default_place_holder.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:ajhman/ui/widgets/text/title_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/cubit/home/selected_index_cubit.dart';
import '../../../core/enum/dialogs_status.dart';
import '../../../gen/assets.gen.dart';
import '../../theme/bloc/theme_bloc.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/snackbar/snackbar_handler.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigatorKey.currentState!.restorablePopAndPushNamed(RoutePaths.home);
        return true;
      },
      child: Scaffold(
        appBar: ReversibleAppBar(title: "تنظیمات حساب"),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: backgroundColor100,
                      borderRadius: DesignConfig.highBorderRadius,
                      boxShadow: DesignConfig.lowShadow),
                  child: Column(
                    children: [
                      const TitleDivider(
                        title: "حساب کاربری",
                        hasPadding: false,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          BlocConsumer<ImagePickerCubit, ImagePickerState>(
                            listener: (context, state)async{
                              if(state is ImagePickerSuccess){
                                await SnackBarHandler(context).show("عکس پروفایل با موفقیت تغییر کرد 😃", DialogStatus.success, true);

                              }else if(state is ImagePickerError){
                                await SnackBarHandler(context).show("خطا در تغییر عکس پروفایل!!", DialogStatus.error, true);

                              }
                            },
                            builder: (context, state) {

                              return Stack(
                                children: [
                                  SizedBox(
                                      width: 72,
                                      height: 72,
                                      child: InkWell(
                                        onTap: state is ImagePickerLoading
                                            ? null
                                            : () {
                                                DialogHandler(context)
                                                    .showChoiceProfileSheet();
                                              },
                                        child: FutureBuilder(
                                            future: getProfile(),
                                            builder: (context, snapshot) {
                                              return ProfileImageNetwork(
                                                  src: getImageUrl(
                                                      snapshot.data!.image),
                                                  width: 72,
                                                  height: 72);
                                            }),
                                      )),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      padding: EdgeInsets.all(4),
                                      child: Assets.icon.outline.add.svg(
                                          width: 16,
                                          height: 16,
                                          color: Colors.white),
                                    ),
                                  ),
                                  state is ImagePickerLoading
                                      ? Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                            ),
                                            child: const ThreeBounceLoading(
                                              size: 32,
                                            ),
                                          ),
                                        )
                                      : const SizedBox()
                                ],
                              );
                            },
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          FutureBuilder(
                              future: getProfile(),
                              builder: (context, snapshot) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    snapshot.hasData
                                        ? PrimaryText(
                                            text:
                                                snapshot.data!.name.toString(),
                                            style: mThemeData.textTheme.title,
                                            color: grayColor900)
                                        : DefaultPlaceHolder(
                                            child: PrimaryText(
                                                text: "اسم",
                                                style:
                                                    mThemeData.textTheme.title,
                                                color: grayColor900),
                                          ),
                                    Row(
                                      children: [
                                        snapshot.hasData
                                            ? PrimaryText(
                                                text: snapshot
                                                    .data!.mobileNumber
                                                    .toString(),
                                                style: mThemeData
                                                    .textTheme.searchHint,
                                                color: grayColor700)
                                            : DefaultPlaceHolder(
                                                child: PrimaryText(
                                                    text: "موبایل",
                                                    style: mThemeData
                                                        .textTheme.searchHint,
                                                    color: grayColor700),
                                              ),
                                        Container(
                                          height: 12,
                                          width: 1,
                                          color: Theme.of(context).primaryColor,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                        ),
                                        PrimaryText(
                                            text: "کارشناس ارشد",
                                            style:
                                                mThemeData.textTheme.searchHint,
                                            color: grayColor700),
                                      ],
                                    )
                                  ],
                                );
                              }),
                        ],
                      ),
                      // const SizedBox(
                      //   height: 16,
                      // ),
                      // _rowBtn("تغییر رمز عبور", Assets.icon.outline.key, null)
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 24,
                // ),
                // Container(
                //   padding: EdgeInsets.all(16),
                //   decoration: BoxDecoration(
                //       color: backgroundColor100,
                //       borderRadius: DesignConfig.highBorderRadius,
                //       boxShadow: DesignConfig.lowShadow),
                //   child: Column(
                //     children: [
                //       const TitleDivider(
                //         title: "ذخیره شده‌ها",
                //         hasPadding: false,
                //       ),
                //       SizedBox(
                //         height: 16,
                //       ),
                //       _rowBtn("لیست ذخیره‌ شده‌ها", Assets.icon.outline.download,
                //           null)
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: backgroundColor100,
                      borderRadius: DesignConfig.highBorderRadius,
                      boxShadow: DesignConfig.lowShadow),
                  child: Column(
                    children: [
                      const TitleDivider(
                        title: "ظاهر نرم‌افزار",
                        hasPadding: false,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      _rowSwitch(
                          "حالت تاریک",
                          Assets.icon.outline.moon,
                          (p0) => {
                                context
                                    .read<ThemeBloc>()
                                    .add(ThemeSwitchEvent())
                              }),
                      const SizedBox(
                        height: 16,
                      ),
                      _rowTitle("انتخاب قالب", Assets.icon.outline.brush),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              context.read<ThemeBloc>().add(
                                  ThemePrimaryEvent(color:purple));
                              setState(() {});
                            },
                            child: Container(
                              height: 52,
                              decoration: BoxDecoration(
                                  borderRadius: DesignConfig.lowBorderRadius,
                                  color: purple),
                            ),
                          )),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              context.read<ThemeBloc>().add(
                                  ThemePrimaryEvent(color: blue));
                              setState(() {});
                            },
                            child: Container(
                              height: 52,
                              decoration: BoxDecoration(
                                  borderRadius: DesignConfig.lowBorderRadius,
                                  color: blue),
                            ),
                          )),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              context.read<ThemeBloc>().add(
                                  ThemePrimaryEvent(color: pink));
                              setState(() {});
                            },
                            child: Container(
                              height: 52,
                              decoration: BoxDecoration(
                                  borderRadius: DesignConfig.lowBorderRadius,
                                  color: pink),
                            ),
                          )),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              context
                                  .read<ThemeBloc>()
                                  .add(ThemePrimaryEvent(color: primaryColor));
                              setState(() {});
                            },
                            child: Container(
                              height: 52,
                              decoration: BoxDecoration(
                                  borderRadius: DesignConfig.lowBorderRadius,
                                  color: primaryColor),
                              // child: Stack(
                              //   children: [
                              //     Positioned(
                              //       bottom: 0,
                              //       left: 0,
                              //       right: 0,
                              //       child: Column(
                              //         children: [
                              //           Container(
                              //             width: 16,
                              //             height: 16,
                              //             decoration: BoxDecoration(
                              //                 color: Colors.white,
                              //                 shape: BoxShape.circle),
                              //           ),
                              //           Container(
                              //             width: 4,
                              //             height: 8,
                              //             decoration: BoxDecoration(
                              //                 color: Colors.white,
                              //                 shape: BoxShape.rectangle),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      _rowTitle("اندازه متن", Assets.icon.outline.smallcaps),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).primaryColor300(), width: 1),
                                borderRadius: DesignConfig.lowBorderRadius),
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 18),
                            margin:
                                EdgeInsetsDirectional.symmetric(vertical: 4),
                            child: Center(
                              child: PrimaryText(
                                  text:
                                      "${(context.read<ThemeBloc>().state.fontSize * 10).round() + 4}",
                                  style: mThemeData.textTheme.title,
                                  color: Theme.of(context).primaryColor900()),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                              child: Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Slider(
                                      value: context
                                              .read<ThemeBloc>()
                                              .state
                                              .fontSize -
                                          0.5,
                                      thumbColor: Theme.of(context).primaryColor700(),
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      inactiveColor: backgroundColor300,
                                      onChanged: (v) {
                                        setState(() {
                                          context.read<ThemeBloc>().add(
                                              ThemeSizeEvent(
                                                  fontSize: v + 0.5));
                                        });
                                      })))
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: PrimaryText(
                            text: "این یک متن نمونه است",
                            style: mThemeData.textTheme.title,
                            color: grayColor900),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: backgroundColor100,
                      borderRadius: DesignConfig.highBorderRadius,
                      boxShadow: DesignConfig.lowShadow),
                  child: Column(
                    children: [
                      const TitleDivider(
                        title: "آموزش",
                        hasPadding: false,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      _rowBtn("مهارت‌های مورد علاقه",
                          Assets.icon.outline.brush2, null),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () async {
                          navigatorKey.currentState!
                              .pushNamed(RoutePaths.smartSchedule);
                        },
                        child: _rowBtn("برنامه‌ریز هوشمند",
                            Assets.icon.outline.calendar, null),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: backgroundColor100,
                      borderRadius: DesignConfig.highBorderRadius,
                      boxShadow: DesignConfig.lowShadow),
                  child: Column(
                    children: [
                      const TitleDivider(
                        title: "درباره‌ ما",
                        hasPadding: false,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      _rowBtn("راهنمای نرم‌افزار",
                          Assets.icon.outline.helpCircle, null),
                      SizedBox(
                        height: 8,
                      ),
                      _rowBtn(
                          "معرفی آژمان", Assets.icon.outline.helpCircle, null),
                      SizedBox(
                        height: 8,
                      ),
                      _rowBtn("پیام به پشتیبانی", Assets.icon.outline.messages,
                          null),
                      SizedBox(
                        height: 8,
                      ),
                      _rowBtn("قوانین و حرم خصوصی", Assets.icon.outline.privacy,
                          null),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  borderRadius: DesignConfig.highBorderRadius,
                  onTap: () async {
                    await clearToken();
                    await clearProfile();
                    navigatorKey.currentState!
                        .restorablePopAndPushNamed(RoutePaths.splash);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: backgroundColor100,
                        borderRadius: DesignConfig.highBorderRadius,
                        boxShadow: DesignConfig.lowShadow),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Assets.icon.outline.logout
                                .svg(width: 16, height: 16, color: errorMain),
                            const SizedBox(
                              width: 8,
                            ),
                            PrimaryText(
                                text: "خروج از حساب کاربری",
                                style: mThemeData.textTheme.title,
                                color: errorMain)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 4, vertical: 16),
                  child: PrimaryText(
                      text: "نسخه نرم‌افزار: ۱.۲.۰",
                      style: mThemeData.textTheme.title,
                      color: grayColor800),
                ),
                const SizedBox(
                  height: 16 + 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _rowBtn(String title, SvgGenImage icon, Function()? click) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon.svg(color: grayColor600, width: 16, height: 16),
              SizedBox(
                width: 8,
              ),
              PrimaryText(
                  text: title,
                  style: mThemeData.textTheme.title,
                  color: grayColor900)
            ],
          ),
          Assets.icon.outline.arrowLeft
              .svg(width: 18, height: 18, color: Theme.of(context).primaryColor)
        ],
      ),
    );
  }

  Padding _rowTitle(String title, SvgGenImage icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon.svg(color: grayColor600, width: 16, height: 16),
          SizedBox(
            width: 8,
          ),
          PrimaryText(
              text: title,
              style: mThemeData.textTheme.title,
              color: grayColor900),
        ],
      ),
    );
  }

  Padding _rowSwitch(String title, SvgGenImage icon, Function(bool)? click) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon.svg(color: grayColor600, width: 16, height: 16),
              SizedBox(
                width: 8,
              ),
              PrimaryText(
                  text: title,
                  style: mThemeData.textTheme.title,
                  color: grayColor900)
            ],
          ),
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return CupertinoSwitch(
                  activeColor: Theme.of(context).primaryColor,
                  value: state.themeData.brightness == Brightness.dark,
                  onChanged: (val) => click!(val));
              ;
            },
          )
        ],
      ),
    );
  }
}
