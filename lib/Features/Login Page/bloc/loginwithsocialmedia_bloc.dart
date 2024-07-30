// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:myecomapp/Common/bloc/common_state.dart';
import 'package:myecomapp/Features/Login%20Page/bloc/loginwithsocialmedia_event.dart';
import 'package:myecomapp/Features/Login%20Page/model/user_model.dart';
import 'package:myecomapp/Features/Login%20Page/resources/user_repository.dart';

class LoginwithsocialmediaBloc
    extends Bloc<LoginwithsocialmediaEvent, CommonState> {
  final UserRepository userRepository;
  LoginwithsocialmediaBloc({required this.userRepository})
      : super(CommonInitialState()) {
    on<LoginwithsocialFacebookEvent>((event, emit) async {
      emit(CommonLoadingState());
      final result = await userRepository.loginWithFb();
      result.fold(
        (data) => emit(CommonSuccessState<UserModel>(userModel: data)),
        (error) => emit(
          CommonErrorState(errorMsg: error),
        ),
      );
    });

    on<LoginwithsocialGooogleEvent>((event, emit) async {
      emit(CommonLoadingState());
      final result = await userRepository.loginWithGoogle();
      result.fold(
        (data) => emit(CommonSuccessState<UserModel>(userModel: data)),
        (error) => emit(
          CommonErrorState(errorMsg: error),
        ),
      );
    });
  }
}
