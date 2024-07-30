import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myecomapp/Common/bloc/common_state.dart';
import 'package:myecomapp/Features/Cat%20Page/cubit/delete_cart_cubit.dart';
import 'package:myecomapp/Features/Cat%20Page/cubit/update_cart_product_quantity_cubit.dart';
import 'package:myecomapp/Features/Cat%20Page/model/cart_model.dart';

class CartProductCard extends StatefulWidget {
  final CartModel cart;
  const CartProductCard({
    super.key,
    required this.cart,
  });

  @override
  State<CartProductCard> createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
  late int count;
  @override
  void initState() {
    count = widget.cart.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateCartProductQuantityCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonSuccessState<CartModel> &&
            state.userModel.id == widget.cart.id) {
          setState(() {
            count = state.userModel.quantity;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Stack(
          children: [
            const SizedBox(
              width: double.infinity,
            ),
            Container(
              margin: const EdgeInsets.only(left: 50),
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(18)),
            ),
            SizedBox(
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/product.png",
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          maxLines: 2,
                          widget.cart.product.name,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          maxLines: 1,
                          widget.cart.product.brand,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "\$${widget.cart.product.price}",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          count == 1
                              ? IconButton(
                                  onPressed: () {
                                    context
                                        .read<DeleteCartCubit>()
                                        .deleteCartProduct(
                                            cartId: widget.cart.id);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ))
                              : IconButton(
                                  onPressed: () {
                                    if (count > 1) {
                                      context
                                          .read<
                                              UpdateCartProductQuantityCubit>()
                                          .updateCartProductQuantity(
                                              cartId: widget.cart.id,
                                              quantity: count - 1);
                                    }
                                  },
                                  icon: const Icon(Icons.remove)),
                          Text("$count"),
                          IconButton(
                              onPressed: () {
                                context
                                    .read<UpdateCartProductQuantityCubit>()
                                    .updateCartProductQuantity(
                                        cartId: widget.cart.id,
                                        quantity: count + 1);
                              },
                              icon: const Icon(Icons.add))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
