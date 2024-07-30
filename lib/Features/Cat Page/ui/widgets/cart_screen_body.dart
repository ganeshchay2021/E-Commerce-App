import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:myecomapp/Common/app%20bar/my_app_bar.dart';
import 'package:myecomapp/Common/bloc/common_state.dart';
import 'package:myecomapp/Common/widgets/toast_msg.dart';
import 'package:myecomapp/Features/Cat%20Page/cubit/cart_count_cubit.dart';
import 'package:myecomapp/Features/Cat%20Page/cubit/delete_cart_cubit.dart';
import 'package:myecomapp/Features/Cat%20Page/cubit/fetch_cart_products.dart';
import 'package:myecomapp/Features/Cat%20Page/cubit/fetch_total_cart_price.dart';
import 'package:myecomapp/Features/Cat%20Page/cubit/update_cart_product_quantity_cubit.dart';
import 'package:myecomapp/Features/Cat%20Page/model/cart_model.dart';
import 'package:myecomapp/Features/Cat%20Page/ui/widgets/cart_product_card.dart';
import 'package:myecomapp/Features/Check%20Out/ui/pages/check_out_screen.dart';
import 'package:page_transition/page_transition.dart';

class CartScreenBody extends StatefulWidget {
  const CartScreenBody({super.key});

  @override
  State<CartScreenBody> createState() => _CartScreenBodyState();
}

class _CartScreenBodyState extends State<CartScreenBody> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: BlocBuilder<FetchCartProductCubit, CommonState>(
          builder: (context, state) {
            if (state is CommonSuccessState<List<CartModel>>) {
              if (state.userModel.isEmpty) {
                return const SizedBox();
              } else {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              child: const CheckOutScreen(),
                              type: PageTransitionType.fade),
                        );
                      },
                      child: const Text(
                        "Continue to checkout",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              }
            } else {
              return const SizedBox();
            }
          },
        ),
        body: BlocListener<UpdateCartProductQuantityCubit, CommonState>(
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
            if (state is CommonErrorState) {
              toastMsg(context, state.errorMsg, Colors.red);
            } else if (state is CommonSuccessState<CartModel>) {
              context.read<FetchTotalCartPriceCubit>().fetchTotalCartPrice();
            }
          },
          child: CustomScrollView(
            slivers: [
              myAppBar(context, "Cart"),
              BlocListener<DeleteCartCubit, CommonState>(
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
                    toastMsg(context, "Product Deleted", Colors.green);
                    context.read<FetchCartProductCubit>().fetchCartProduct();
                    context.read<CartCountCubit>().cartCount();

                  } else if (state is CommonErrorState) {
                    toastMsg(context, state.errorMsg, Colors.red);
                  }
                },
                child:
                    BlocSelector<FetchTotalCartPriceCubit, CommonState, String>(
                  selector: (state) {
                    if (state is CommonLoadingState) {
                      return "Calculating";
                    } else if (state is CommonSuccessState<int>) {
                      return "Rs ${state.userModel}";
                    } else {
                      return "N/A";
                    }
                  },
                  builder: (context, state) {
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      sliver: SliverToBoxAdapter(
                        child: Row(
                          children: [
                            const Text(
                              "Your cart",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                children: [
                                  const TextSpan(text: "Total: "),
                                  TextSpan(
                                    text: state,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              BlocBuilder<FetchCartProductCubit, CommonState>(
                builder: (context, state) {
                  if (state is CommonLoadingState) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is CommonSuccessState<List<CartModel>>) {
                    if (state.userModel.isEmpty) {
                      return SliverFillRemaining(
                        child: Image.asset("assets/images/emptycart.png"),
                      );
                    } else {
                      return SliverList.builder(
                        itemCount: state.userModel.length,
                        itemBuilder: (context, index) {
                          return CartProductCard(
                            cart: state.userModel[index],
                          );
                        },
                      );
                    }
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
