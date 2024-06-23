import 'package:ajhman/core/enum/dialogs_status.dart';
import 'package:ajhman/core/routes/route_generator.dart';
import 'package:ajhman/core/routes/route_paths.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/pages/auth/auth_page.dart';
import 'package:ajhman/ui/pages/auth/auth_page_started.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/widgets/button/primary_button.dart';
import 'package:ajhman/ui/widgets/snackbar/snackbar_handler.dart';
import 'package:ajhman/ui/widgets/states/no_connectivity_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/bloc/profile/profile_bloc.dart';
import '../../core/enum/state_status.dart';
import '../../data/api/dio_helper.dart';
import '../../data/model/error_response_model.dart';
import '../../data/model/profile_response_model.dart';
import '../../data/shared_preferences/auth_token.dart';
import '../../data/shared_preferences/profile_data.dart';
import '../../gen/assets.gen.dart';
import '../widgets/dialogs/dialog_handler.dart';
import '../widgets/loading/three_bounce_loading.dart';
import 'home/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(GetProfileInfo());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).background(),
      body: FutureBuilder(
          future: getToken(),
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              token = snapshot.data!;
            }
            return BlocConsumer<ProfileBloc, ProfileState>(
                listener: (context, state) {
              if (state is ProfileSuccess) {
                setProfile(state.response);
                navigatorKey.currentState!.pushNamed(RoutePaths.home);
              } else if (state is ProfileFailConnection) {
                SnackBarHandler(context).show(
                    "اینترنت خود را بررسی کنید", DialogStatus.error, true);
              } else if (state is ProfileFail) {
                navigatorKey.currentState!.pushReplacementNamed(RoutePaths.auth);
              }
            }, builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Assets.icon.main.lIcon
                      .svg(color: Theme.of(context).primaryColor),
                  Center(
                    child: state is ProfileFailConnection
                        ? PrimaryButton(
                      title: "تلاش مجدد",
                      onClick: () {
                        context
                            .read<ProfileBloc>()
                            .add(GetProfileInfo());
                      },
                    )
                        : const ThreeBounceLoading(),
                  ),
                ],
              );
            });
          }),
    );
  }
}
