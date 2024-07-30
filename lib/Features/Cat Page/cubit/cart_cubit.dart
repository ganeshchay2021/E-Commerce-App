import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myecomapp/Common/bloc/common_state.dart';
import 'package:myecomapp/Features/Cat%20Page/resources/cart_repository.dart';

class CartCubit extends Cubit<CommonState> {
  final CartRepository cartRepository;
  CartCubit({required this.cartRepository}) : super(CommonInitialState());

  addToCart({required String productId}) async {
    emit(CommonLoadingState());
    final result = await cartRepository.addToCart(productId: productId);
    result.fold(
      (error) => emit(CommonErrorState(errorMsg: error)),
      (data) => emit(
        CommonSuccessState<String>(userModel: productId),
      ),
    );
  }

  
}
