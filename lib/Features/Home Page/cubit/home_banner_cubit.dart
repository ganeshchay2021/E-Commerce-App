// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myecomapp/Common/bloc/common_state.dart';
import 'package:myecomapp/Features/Home%20Page/resources/product_repository.dart';

class HomeBannerCubit extends Cubit<CommonState> {
  final ProductRepository productRepository;
  HomeBannerCubit({required this.productRepository})
      : super(CommonInitialState());

  fetchHomeBanner() async {
    emit(CommonLoadingState());
    final result = await productRepository.fetcHomeBanner();
    result.fold(
        (data) => emit(CommonSuccessState<List<String>>(userModel: data)),
        (error) => emit(CommonErrorState(errorMsg: error)));
  }
}
