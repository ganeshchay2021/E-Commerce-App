import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:myecomapp/Common/app%20bar/my_app_bar.dart';
import 'package:myecomapp/Common/bloc/common_state.dart';
import 'package:myecomapp/Common/widgets/toast_msg.dart';
import 'package:myecomapp/Features/Order%20History/cubit/delete_order_cubit.dart';
import 'package:myecomapp/Features/Order%20History/cubit/order_cubit.dart';
import 'package:myecomapp/Features/Order%20History/model/order_model.dart';
import 'package:myecomapp/Features/Order%20History/ui/widgets/order_card.dart';

class OrderHistoryBody extends StatefulWidget {
  const OrderHistoryBody({super.key});

  @override
  State<OrderHistoryBody> createState() => _OrderHistoryBodyState();
}

class _OrderHistoryBodyState extends State<OrderHistoryBody> {
  bool isLoading = false;
  @override
  void initState() {
    context.read<OrderCubit>().fetchAllOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            myAppBar(context, "My Orders"),
            BlocListener<DeleteOrderCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonLoadingState) {
                  setState(() {
                    isLoading = true;
                  });
                } else {
                  setState(() {
                    isLoading = false;
                  });
                }
                if (state is CommonSuccessState) {
                  toastMsg(context, "Order Deleted", Colors.green);
                  context.read<OrderCubit>().fetchAllOrder();
                } else if (state is CommonErrorState) {
                  toastMsg(context, state.errorMsg, Colors.red);
                }
              },
              child: BlocBuilder<OrderCubit, CommonState>(
                builder: (context, state) {
                  if (state is CommonLoadingState) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    );
                  } else if (state is CommonSuccessState<List<OrderModel>>) {
                    if (state.userModel.isEmpty) {
                      return SliverFillRemaining(
                        child: Center(
                          child: Image.asset(
                            "assets/images/emptycart.png",
                          ),
                        ),
                      );
                    }
                    return SliverList.builder(
                      itemCount: state.userModel.length,
                      itemBuilder: (context, index) {
                        return OrderCard(
                          order: state.userModel[index],
                        );
                      },
                    );
                  } else if (state is CommonErrorState) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text(state.errorMsg),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
