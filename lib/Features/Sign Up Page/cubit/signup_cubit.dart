

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myecomapp/Common/bloc/common_state.dart';
import 'package:myecomapp/Features/Login%20Page/resources/user_repository.dart';

class SignupCubit extends Cubit<CommonState> {
  final UserRepository userRepository;
  SignupCubit({required this.userRepository}) : super(CommonInitialState());

  signUpUser(
      {required String name,
      required String email,
      required String password,
      required String phoneNumber,
      required String address}) async {
    emit(CommonLoadingState());
    final result = await userRepository.signUpUser(
        name: name,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        address: address);
    result.fold(
      (data) => emit(CommonSuccessState(userModel: null)),
      (error) => emit(CommonErrorState(errorMsg: error)),
    );
  }
}
