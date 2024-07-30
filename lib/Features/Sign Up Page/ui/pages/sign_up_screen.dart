import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myecomapp/Features/Login%20Page/resources/user_repository.dart';
import 'package:myecomapp/Features/Sign%20Up%20Page/cubit/signup_cubit.dart';
import 'package:myecomapp/Features/Sign%20Up%20Page/ui/widgets/signup_body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SignupCubit(userRepository: context.read<UserRepository>()),
      child: const SignUpBody(),
    );
  }
}
