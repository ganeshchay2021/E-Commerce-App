// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myecomapp/Features/Order%20Details/cubit/single_order_details_cubit.dart';
import 'package:myecomapp/Features/Order%20Details/ui/widgets/order_details_body.dart';
import 'package:myecomapp/Features/Order%20History/resources/order_repository.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;
  const OrderDetailsScreen({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SingleOrderDetailsCubit(orderRepository: context.read<OrderRepository>())..fetchSIngleOrdersDetails(orderId: orderId),
      child: const OrderDetailsBody(),
    );
  }
}
