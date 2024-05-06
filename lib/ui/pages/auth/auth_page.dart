import 'package:ajhman/data/model/auth/auth_user_otp_error.dart';
import 'package:ajhman/ui/screens/auth/login_password/login_password_screen.dart';
import 'package:ajhman/ui/theme/color/colors.dart';
import 'package:ajhman/ui/widgets/snackbars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/bloc/auth/auth_screen_bloc.dart';
import '../../screens/auth/login_otp/login_otp_screen.dart';
import '../../screens/auth/pin/pin_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _errorState = false;
  AuthScreensState _lastState = AuthScreensState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: primaryColor50,
        body: Column(
          children: [
            Container(
              height: MediaQuery
                  .sizeOf(context)
                  .height / 3,
              decoration: const BoxDecoration(color: primaryColor),
            ),
            Expanded(
              child: Container(
                color: primaryColor,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 32, 16, 32),
                      child: BlocBuilder<AuthScreensBloc, AuthScreensState>(
                        builder: (context, state) {
                          print(state);
                          if (state.authScreen == AuthScreens.otp) {
                            return LoginOtpScreen();
                          } else if (state.authScreen == AuthScreens.password) {
                            return LoginPasswordScreen();
                          } else if (state.authScreen == AuthScreens.pin) {
                            return PinScreen(state: state, error: true);
                          } else {
                            return const SizedBox();
                          }
                        },
                      )
                  ),
                ),
              ),
            )
          ],
        ));
  }

/*  BlocConsumer<AuthBloc, AuthState>(
  builder: (context, state) {
  if (state.authStatus == AuthStatus.pin ||
  state.authStatus == AuthStatus.login_otp) {
  _lastState = state;
  return LoginScreen(
  phoneNumber: state.phoneNumber,
  isOtp: state.authStatus == AuthStatus.pin,
  error: _errorState,
  );
  } else if (state.authStatus == AuthStatus.pin) {
  _lastState = state;

  return EnterOtpScreen(
  state: state,
  error: _errorState,
  );
  } else {
  return const Center(
  child: CircularProgressIndicator(),
  );
  }
  }, listener: (context, state) {
  if (state.authStatus == AuthStatus.error) {
  showErrorSnackBar(context, state.message);
  setState(() {
  _errorState = true;
  });
  context.read<AuthBloc>().emit(_lastState);
  }else if(state.authStatus == AuthStatus.success){
  showNormalSnackBar(context, state.message);
  context.read<AuthBloc>().emit(_lastState);
  }
  }),
  */
// Widget buildBlocConsumer() {
//   return BlocConsumer<AuthRegisterUserBloc, AuthRegisterUserState>(
//     listener: (context, state) {
//       if (state is AuthRegisterUserError) {
//         AuthRegisterUserOtpError data =
//             AuthRegisterUserOtpError.fromJson(state.error);
//         showErrorSnackBar(context, data.message!.message.toString());
//       }
//     },
//     builder: (context, state) {
//       if (state is AuthRegisterUserInitial) {
//         return const EnterNumberScreen();
//       } else if (state is AuthRegisterUserWithOtp) {
//         return EnterOtpScreen(
//           state: state,
//         );
//       } else if (state is AuthRegisterUserSuccess) {
//         return Container(
//           color: Colors.red,
//         );
//       } else {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       }
//     },
//   );
// }
}
