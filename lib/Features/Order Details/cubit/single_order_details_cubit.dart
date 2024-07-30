// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myecomapp/Common/bloc/common_state.dart';
import 'package:myecomapp/Features/Order%20Details/model/order_product_model.dart';
import 'package:myecomapp/Features/Order%20History/resources/order_repository.dart';

class SingleOrderDetailsCubit extends Cubit<CommonState> {
  final OrderRepository orderRepository;
  SingleOrderDetailsCubit({required this.orderRepository})
      : super(CommonInitialState());

  fetchSIngleOrdersDetails({required String orderId}) async {
    emit(CommonLoadingState());
    final result =
        await orderRepository.fetchSIngleOrdersDetails(orderId: orderId);
    result.fold((error) => emit(CommonErrorState(errorMsg: error)),
        (data) => emit(CommonSuccessState<OrderProductModel>(userModel: data)));
  }
}
