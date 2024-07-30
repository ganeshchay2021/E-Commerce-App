// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myecomapp/Common/bloc/common_state.dart';
import 'package:myecomapp/Features/Cat%20Page/resources/cart_repository.dart';

class FetchTotalCartPriceCubit extends Cubit<CommonState> {
  final CartRepository cartRepository;
  FetchTotalCartPriceCubit(
    {required this.cartRepository}
  ) : super(CommonInitialState());

  fetchTotalCartPrice() async {
    emit(CommonLoadingState());
    final result = await cartRepository.fetchTotalCartPrice();
    result.fold((error) => emit(CommonErrorState(errorMsg: error)),
        (data) => emit(CommonSuccessState<int>(userModel: data)));
  }
}
