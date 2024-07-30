// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myecomapp/Common/bloc/common_state.dart';
import 'package:myecomapp/Features/Cat%20Page/model/cart_model.dart';
import 'package:myecomapp/Features/Cat%20Page/resources/cart_repository.dart';

class FetchCartProductCubit extends Cubit<CommonState> {
  final CartRepository cartRepository;
  FetchCartProductCubit({required this.cartRepository})
      : super(CommonInitialState());

  fetchCartProduct() async {
    emit(CommonLoadingState());
    final result = await cartRepository.fetchCartProduct();
    result.fold(
      (error) => emit(CommonErrorState(errorMsg: error)),
      (data) => emit(
        CommonSuccessState<List<CartModel>>(userModel: data),
      ),
    );
  }
}
