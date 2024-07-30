// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myecomapp/Common/bloc/common_state.dart';
import 'package:myecomapp/Features/Order%20History/model/order_model.dart';
import 'package:myecomapp/Features/Order%20History/resources/order_repository.dart';

class OrderCubit extends Cubit<CommonState> {
  final OrderRepository orderRepository;
  OrderCubit({required this.orderRepository}) : super(CommonInitialState());

  fetchAllOrder() async {
    emit(CommonLoadingState());
    final result = await orderRepository.fetchallOrders();
    result.fold((error) => emit(CommonErrorState(errorMsg: error)),
        (data) => emit(CommonSuccessState<List<OrderModel>>(userModel: data)));
  }
}
