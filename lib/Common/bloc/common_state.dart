// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class CommonState {}

class CommonInitialState extends CommonState {}

class CommonLoadingState extends CommonState {
  final bool showLoading;
  CommonLoadingState({
    this.showLoading = true,
  });
}

class CommonSuccessState<Type> extends CommonState {
  final Type userModel;

  CommonSuccessState({required this.userModel});
}

class CommonErrorState extends CommonState {
  final String errorMsg;

  CommonErrorState({required this.errorMsg});
}
