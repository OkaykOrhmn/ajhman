import 'package:ajhman/core/routes/route_generator.dart';
import 'package:ajhman/core/routes/route_paths.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/pages/auth/auth_page_started.dart';
import 'package:ajhman/ui/widgets/button/primary_button.dart';
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

  void _tryAgain() {
    setState(() {
      clearToken();
      DialogHandler.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getToken(),
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              token = snapshot.data!;
            }
            return BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
              if (state is ProfileSuccess) {
                setProfile(state.response);
                profile = state.response;
                return const HomePage();
              } else if (state is ProfileFail) {
                if (state.error == "connection") {
                  return NoConnectivityScreen(
                    click: () {
                      context.read<ProfileBloc>().add(GetProfileInfo());
                    },
                  );
                } else {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      DialogHandler.showErrorDialog(
                          state.error, "صفحه ورورد", () => _tryAgain());
                    }
                  }
                }
                return const AuthPageStarted();
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Assets.icon.main.lIcon.svg(),
                    ThreeBounceLoading(),
                  ],
                );
              }
            });
          }),
    );
  }
}
