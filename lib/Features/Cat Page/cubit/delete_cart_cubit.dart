// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myecomapp/Common/bloc/common_state.dart';
import 'package:myecomapp/Features/Cat%20Page/resources/cart_repository.dart';

class DeleteCartCubit extends Cubit<CommonState> {
  final CartRepository cartRepository;
  DeleteCartCubit(
    {required this.cartRepository}
  ) : super(CommonInitialState());

  deleteCartProduct({required String cartId}) async {
    emit(CommonLoadingState());
    final result = await cartRepository.deleteCartProduct(cartId: cartId);
    result.fold((error) => emit(CommonErrorState(errorMsg: error)),
        (data) => emit(CommonSuccessState(userModel: null)));
  }
}
