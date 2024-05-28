import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:ajhman/ui/widgets/text_field/search_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../widgets/carousel/carousel_banners.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
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
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: (){

              },
              child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor100,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 1.0,
                    )
                  ],
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
          ),

        ],
      ),
    );
  }
}
