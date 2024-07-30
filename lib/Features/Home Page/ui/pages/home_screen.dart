import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myecomapp/Features/Home%20Page/cubit/all_product_bloc.dart';
import 'package:myecomapp/Features/Home%20Page/cubit/home_banner_cubit.dart';
import 'package:myecomapp/Features/Home%20Page/cubit/product_event.dart';
import 'package:myecomapp/Features/Home%20Page/resources/product_repository.dart';
import 'package:myecomapp/Features/Home%20Page/ui/widgets/home_screen_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBannerCubit(
              productRepository: context.read<ProductRepository>())
            ..fetchHomeBanner(),
        ),
        BlocProvider(
          create: (context) => AllproductBloc(
              productRepository: context.read<ProductRepository>())
            ..add(FetchAllProductEvent()),
        ),
      ],
      child: const HomeScreenBody(),
    );
  }
}
