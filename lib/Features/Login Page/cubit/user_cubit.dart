// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myecomapp/Common/bloc/common_state.dart';
import 'package:myecomapp/Features/Login%20Page/model/user_model.dart';
import 'package:myecomapp/Features/Login%20Page/resources/user_repository.dart';

class UserCubit extends Cubit<CommonState> {
  final UserRepository userRepository;
  UserCubit({required this.userRepository}) : super(CommonInitialState());

  login(
      {required String email,
      required String password,
      required bool rememberMe}) async {
    emit(CommonLoadingState());
    final result = await userRepository.login(
        email: email, password: password, rememberMe: rememberMe);
    result.fold(
      (data) => emit(CommonSuccessState<UserModel>(userModel: data)),
      (error) => emit(
        CommonErrorState(errorMsg: error),
      ),
    );
  }
}
