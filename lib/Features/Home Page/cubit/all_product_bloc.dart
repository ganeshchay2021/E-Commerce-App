// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myecomapp/Common/bloc/common_state.dart';
import 'package:myecomapp/Features/Home%20Page/cubit/product_event.dart';
import 'package:myecomapp/Features/Home%20Page/model/product_model.dart';
import 'package:myecomapp/Features/Home%20Page/resources/product_repository.dart';

class AllproductBloc extends Bloc<ProductEvent, CommonState> {
  final ProductRepository productRepository;
  AllproductBloc({required this.productRepository})
      : super(CommonInitialState()) {
    on<FetchAllProductEvent>((event, emit) async {
      emit(CommonLoadingState());
      final result = await productRepository.fetcAllProduct();
      result.fold(
        (data) => emit(CommonSuccessState<List<Product>>(userModel: data)),
        (error) => emit(
          CommonErrorState(errorMsg: error),
        ),
      );
    });

    on<LoadMoreProductEvent>(
      (event, emit) async {
        emit(CommonLoadingState(showLoading: false));
        final _ = await productRepository.fetcAllProduct(isLoadmore: true);
        emit(
          CommonSuccessState<List<Product>>(
              userModel: productRepository.product),
        );
      },
    );
    
    on<RefreshProductEvent>(
      (event, emit) async {
        emit(CommonLoadingState(showLoading: false));
        final result = await productRepository.fetcAllProduct();
        result.fold(
        (data) => emit(CommonSuccessState<List<Product>>(userModel: data)),
        (error) => emit(
          CommonErrorState(errorMsg: error),
        ),
      );
      },
    );
  }
}
