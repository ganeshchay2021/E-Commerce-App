// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:myecomapp/Common/widgets/toast_msg.dart';
import 'package:myecomapp/Features/Cat%20Page/cubit/cart_cubit.dart';
import 'package:myecomapp/Features/Product%20Details%20Page/ui/widgets/product_description.dart';

import 'package:myecomapp/Common/bloc/common_state.dart';
import 'package:myecomapp/Features/Home%20Page/model/product_model.dart';
import 'package:myecomapp/Features/Product%20Details%20Page/cubit/product_details_cubit.dart';
import 'package:myecomapp/Features/Product%20Details%20Page/ui/widgets/product_review.dart';

class ProductDetailsBody extends StatefulWidget {
  const ProductDetailsBody({super.key});

  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: Theme.of(context).primaryColor,
              title: const Text(
                "Product Details",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: BlocListener<CartCubit, CommonState>(
                listener: (context, state) {
                  if (state is CommonLoadingState) {
                    setState(() {
                      isLoading = true;
                    });
                  } else {
                    setState(
                      () {
                        isLoading = false;
                      },
                    );
                  }
                  if (state is CommonSuccessState) {
                    context
                        .read<ProductDetailsCubit>()
                        .fetcSingleProduct(productId: state.userModel);
                    toastMsg(context, "Product Add Successfully", Colors.green);
                  } else if (state is CommonErrorState) {
                    toastMsg(context, state.errorMsg, Colors.red);
                  }
                },
                child: BlocBuilder<ProductDetailsCubit, CommonState>(
                  builder: (context, state) {
                    if (state is CommonLoadingState) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: const Center(
                            child: CircularProgressIndicator.adaptive()),
                      );
                    } else if (state is CommonSuccessState<Product>) {
                      return Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height,
                            color: Theme.of(context).primaryColor,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            top: MediaQuery.of(context).size.height * 0.20,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              height: MediaQuery.of(context).size.height,
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //image section
                                  Hero(
                                    tag: state.userModel.name,
                                    child: Image.asset(
                                      "assets/images/product.png",
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Text(
                                    state.userModel.name,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "\$${state.userModel.price}",
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.grey),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),

                                  //Rating and Branding Sections
                                  ProductReview(
                                    brand: state.userModel.brand,
                                    category: state.userModel.catagories[0],
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),

                                  const Text(
                                    "Description",
                                    style: TextStyle(
                                      height: 2,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  //Product Description
                                  ProductDescription(
                                    description: state.userModel.description,
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),

                                  //Add to cart button
                                  if (state.userModel.addToCart == false)
                                    SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                        ),
                                        onPressed: () {
                                          context.read<CartCubit>().addToCart(
                                              productId: state.userModel.id);
                                        },
                                        child: const Text(
                                          "Add to Cart",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    } else if (state is CommonErrorState) {
                      return Center(
                        child: Text(state.errorMsg),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
