// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myecomapp/Common/bloc/common_state.dart';
import 'package:myecomapp/Features/Home%20Page/model/product_model.dart';
import 'package:myecomapp/Features/Home%20Page/resources/product_repository.dart';

class ProductDetailsCubit extends Cubit<CommonState> {
  final ProductRepository productRepository;
  ProductDetailsCubit({required this.productRepository})
      : super(CommonInitialState());

  fetcSingleProduct({required String productId}) async {
    emit(CommonLoadingState());
    final result =
        await productRepository.fetcSingleProduct(productId: productId);
    result.fold(
      (data) => emit(CommonSuccessState<Product>(userModel: data)),
      (error) => emit(
        CommonErrorState(errorMsg: error),
      ),
    );
  }
}
