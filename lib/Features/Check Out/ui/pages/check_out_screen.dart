import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myecomapp/Features/Check%20Out/cubit/create_order_cubit.dart';
import 'package:myecomapp/Features/Check%20Out/resources/checkout_repository.dart';
import 'package:myecomapp/Features/Check%20Out/ui/widgets/check_out_body.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateOrderCubit(
          checkOutRepository: context.read<CheckOutRepository>()),
      child: const CheckOutBody(),
    );
  }
}
