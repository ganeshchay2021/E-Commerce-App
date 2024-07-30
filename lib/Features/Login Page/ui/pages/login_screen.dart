import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myecomapp/Features/Login%20Page/bloc/loginwithsocialmedia_bloc.dart';
import 'package:myecomapp/Features/Login%20Page/cubit/user_cubit.dart';
import 'package:myecomapp/Features/Login%20Page/resources/user_repository.dart';
import 'package:myecomapp/Features/Login%20Page/ui/widgets/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(
            userRepository: context.read<UserRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => LoginwithsocialmediaBloc(
              userRepository: context.read<UserRepository>()),
        ),
      ],
      child: const LoginBody(),
    );
  }
}
