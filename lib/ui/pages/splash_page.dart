import 'package:ajhman/core/routes/route_generator.dart';
import 'package:ajhman/core/routes/route_paths.dart';
import 'package:ajhman/main.dart';
import 'package:ajhman/ui/pages/auth/auth_page_started.dart';
import 'package:ajhman/ui/widgets/button/primary_button.dart';
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
import '../widgets/dialogs/dialog_handler.dart';
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
            return BlocConsumer<ProfileBloc, ProfileState>(
                builder: (context, state) {
              switch (state.status) {
                case StateStatus.success:
                  return const HomePage();
                case StateStatus.fail:
                  return const AuthPageStarted();
                case StateStatus.loading:
                default:
                  return const Center(child: CircularProgressIndicator());
              }
            }, listener: (context, state) {
              if (state.status == StateStatus.loading) {}
              if (state.status == StateStatus.success) {
                setProfile(state.data);
              } else if (state.status == StateStatus.fail) {
                var data = ErrorResponseModel.fromJson(state.data);
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    DialogHandler.showErrorDialog(
                        data.message!.message.toString(),
                        "صفحه ورورد",
                        () => _tryAgain());
                  }
                }
              }
            });
          }),
    );
  }
}
