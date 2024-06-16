import 'package:ajhman/gen/assets.gen.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/theme/text/text_styles.dart';
import 'package:ajhman/ui/widgets/app_bar/reversible_app_bar.dart';
import 'package:ajhman/ui/widgets/button/loading_btn.dart';
import 'package:ajhman/ui/widgets/text/primary_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif/gif.dart';
import 'package:loading_btn/loading_btn.dart';

class NoConnectivityScreen extends StatelessWidget {
  final Function()? click;

  const NoConnectivityScreen({super.key, this.click});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: mThemeData,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const ReversibleAppBar(
          title: "آفلاین",
          canBack: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 16),
                child: Gif(
                  image: Assets.gif.connection.provider(),
                  autostart: Autostart.loop,
                ),
              ),
              PrimaryText(
                  text:
                      "اتصال اینترنت وجود ندارد!\nلطفا از اتصال به اینترنت اطمینان حاصل فرمایید.",
                  style: mThemeData.textTheme.titleBold,
                  color: errorMain),
              SizedBox(height: 16,),
              click != null
                  ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: PrimaryLoadingButton(
                        disable: false,
                        title: "تلاش مجدد",
                        onTap: (Function startLoading, Function stopLoading,
                            ButtonState btnState) async {
                          if (btnState == ButtonState.idle) {
                            startLoading();
                            click!();
                            stopLoading();
                          }
                        }),
                  )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
