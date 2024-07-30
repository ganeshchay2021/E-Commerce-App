import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myecomapp/Common/bloc/common_state.dart';
import 'package:myecomapp/Features/Order%20Details/cubit/single_order_details_cubit.dart';
import 'package:myecomapp/Features/Order%20Details/model/order_product_model.dart';
import 'package:myecomapp/Features/Order%20Details/ui/widgets/order_product_card.dart';
import 'package:myecomapp/Features/Order%20Details/ui/widgets/user_details_box.dart';
import 'package:myecomapp/Features/Order%20Details/ui/widgets/user_details_text.dart';

class OrderDetailsBody extends StatefulWidget {
  const OrderDetailsBody({super.key});

  @override
  State<OrderDetailsBody> createState() => _OrderDetailsBodyState();
}

class _OrderDetailsBodyState extends State<OrderDetailsBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Order Details",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: SizedBox(
          child: BlocBuilder<SingleOrderDetailsCubit, CommonState>(
            builder: (context, state) {
              if (state is CommonLoadingState) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is CommonSuccessState<OrderProductModel>) {
                return Column(
                  children: [
                    UserDetailBox(
                      orderDetail: state.userModel,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Products List",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          MyRichText(
                              title: "Total no. of Items: ",
                              text:
                                  state.userModel.orderItems.length.toString())
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.userModel.orderItems.length,
                      itemBuilder: (context, index) {
                        return OrderProductCard(
                          cart: state.userModel.orderItems[index],
                        );
                      },
                    )
                  ],
                );
              } else if (state is CommonErrorState) {
                return Text(state.errorMsg);
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
