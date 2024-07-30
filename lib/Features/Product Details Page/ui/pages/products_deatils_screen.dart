// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myecomapp/Features/Cat%20Page/cubit/cart_cubit.dart';
import 'package:myecomapp/Features/Cat%20Page/resources/cart_repository.dart';
import 'package:myecomapp/Features/Home%20Page/resources/product_repository.dart';
import 'package:myecomapp/Features/Product%20Details%20Page/cubit/product_details_cubit.dart';

import 'package:myecomapp/Features/Product%20Details%20Page/ui/widgets/product_details__body.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;
  const ProductDetailsScreen({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductDetailsCubit(
            productRepository: context.read<ProductRepository>(),
          )..fetcSingleProduct(productId: productId),
        ),
        BlocProvider(
          create: (context) =>
              CartCubit(cartRepository: context.read<CartRepository>()),
        ),
      ],
      child: const ProductDetailsBody(),
    );
  }
}
