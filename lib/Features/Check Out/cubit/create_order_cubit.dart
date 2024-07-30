// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myecomapp/Common/bloc/common_state.dart';
import 'package:myecomapp/Features/Check%20Out/model/checkout_model.dart';
import 'package:myecomapp/Features/Check%20Out/resources/checkout_repository.dart';

class CreateOrderCubit extends Cubit<CommonState> {
  final CheckOutRepository checkOutRepository;
  CreateOrderCubit({required this.checkOutRepository})
      : super(CommonInitialState());

  createOrder({required CheckoutModel param}) async {
    emit(CommonLoadingState());
    final result = await checkOutRepository.createOrder(param: param);
    result.fold((error) => emit(CommonErrorState(errorMsg: error)),
        (data) => emit(CommonSuccessState(userModel: null)));
  }
}
