import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myecomapp/Features/Order%20History/cubit/delete_order_cubit.dart';
import 'package:myecomapp/Features/Order%20History/cubit/order_cubit.dart';
import 'package:myecomapp/Features/Order%20History/resources/order_repository.dart';
import 'package:myecomapp/Features/Order%20History/ui/widgets/order_history_body.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              OrderCubit(orderRepository: context.read<OrderRepository>()),
        ),
        BlocProvider(
          create: (context) =>DeleteOrderCubit(context.read<OrderRepository>()),
        ),
      ],
      child: const OrderHistoryBody(),
    );
  }
}
