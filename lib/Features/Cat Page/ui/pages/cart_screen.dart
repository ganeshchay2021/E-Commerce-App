import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myecomapp/Features/Cat%20Page/cubit/delete_cart_cubit.dart';
import 'package:myecomapp/Features/Cat%20Page/cubit/fetch_cart_products.dart';
import 'package:myecomapp/Features/Cat%20Page/cubit/fetch_total_cart_price.dart';
import 'package:myecomapp/Features/Cat%20Page/cubit/update_cart_product_quantity_cubit.dart';
import 'package:myecomapp/Features/Cat%20Page/resources/cart_repository.dart';
import 'package:myecomapp/Features/Cat%20Page/ui/widgets/cart_screen_body.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FetchCartProductCubit(
              cartRepository: context.read<CartRepository>())
            ..fetchCartProduct(),
        ),
        BlocProvider(
          create: (context) => FetchTotalCartPriceCubit(
              cartRepository: context.read<CartRepository>())
            ..fetchTotalCartPrice(),
        ),
        BlocProvider(
            create: (context) => UpdateCartProductQuantityCubit(
                cartRepository: context.read<CartRepository>())),
        BlocProvider(
            create: (context) =>
                DeleteCartCubit(cartRepository: context.read<CartRepository>()))
      ],
      child: const CartScreenBody(),
    );
  }
}
