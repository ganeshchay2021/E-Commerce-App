import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myecomapp/Features/Login%20Page/resources/user_repository.dart';
import 'package:myecomapp/Features/Splash%20Screen/cubit/splash_cubit.dart';
import 'package:myecomapp/Features/Splash%20Screen/ui/widgets/splash_body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SplashCubit(userRepository: context.read<UserRepository>())
            ..startUp(),
      child: const SplashBody(),
    );
  }
}
