
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myecomapp/Common/bloc/common_state.dart';
import 'package:myecomapp/Features/Login%20Page/resources/user_repository.dart';

class SplashCubit extends Cubit<CommonState> {
  final UserRepository userRepository;
  SplashCubit({required this.userRepository}) : super(CommonInitialState());

  startUp() async {
    emit(CommonLoadingState());
    await userRepository.initialization();
    await Future.delayed(const Duration(seconds: 2));
    emit(CommonSuccessState<bool>(
        userModel: userRepository.userModel != null &&
            userRepository.token.isNotEmpty));
  }
}
