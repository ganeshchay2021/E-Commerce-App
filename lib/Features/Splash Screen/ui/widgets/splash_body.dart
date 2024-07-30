import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myecomapp/Common/bloc/common_state.dart';
import 'package:myecomapp/Features/Home%20Page/ui/pages/home_screen.dart';
import 'package:myecomapp/Features/Login%20Page/ui/pages/login_screen.dart';
import 'package:myecomapp/Features/Splash%20Screen/cubit/splash_cubit.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      body: BlocListener<SplashCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonSuccessState) {
            if (state.userModel) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            }
          }
        },
        child: const Center(
          child: Icon(
            Icons.flutter_dash,
            size: 50,
          ),
        ),
      ),
    );
  }
}
