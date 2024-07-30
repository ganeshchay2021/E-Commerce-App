import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myecomapp/Common/bloc/common_state.dart';
import 'package:myecomapp/Features/Cat%20Page/cubit/cart_count_cubit.dart';
import 'package:myecomapp/Features/Cat%20Page/ui/pages/cart_screen.dart';
import 'package:myecomapp/Features/Drawer/ui/pages/drawer_screen.dart';
import 'package:myecomapp/Features/Home%20Page/cubit/all_product_bloc.dart';
import 'package:myecomapp/Features/Home%20Page/cubit/product_event.dart';
import 'package:myecomapp/Features/Home%20Page/model/product_model.dart';
import 'package:myecomapp/Features/Home%20Page/ui/widgets/Product_card.dart';
import 'package:myecomapp/Features/Home%20Page/ui/widgets/home_banner_section.dart';
import 'package:myecomapp/Features/Login%20Page/resources/user_repository.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  final ScrollController controller = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    context.read<CartCountCubit>().cartCount();
  }

  void handleLoadMore() {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      print("Handle Load More");
      // Add your load more logic here
      timer.cancel();
    });
  }

// /////////////
//   @override
//   void dispose() {
//     controller.dispose();
//     _debounce?.cancel();
//     super.dispose();
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerScreen(),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels >
                  (notification.metrics.maxScrollExtent / 2) &&
              controller.position.userScrollDirection ==
                  ScrollDirection.reverse) {
            context.read<AllproductBloc>().add(LoadMoreProductEvent());
          }
          return true;
        },
        child: CustomScrollView(
          controller: controller,
          slivers: [
            //Dashboard App bar section
            SliverAppBar(
              iconTheme: const IconThemeData(
                color: Colors.white, // Set the drawer icon color here
              ),
              centerTitle: true,
              floating: true,
              title: const Text(
                "Dashboard",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            child: const CartScreen(),
                            type: PageTransitionType.fade),
                      );
                    },
                    icon: BlocBuilder<CartCountCubit, int>(
                      builder: (context, state) {
                        return Badge.count(
                          count: state,
                          textColor:
                              state > 0 ? Colors.white : Colors.transparent,
                          backgroundColor:
                              state > 0 ? Colors.blue : Colors.transparent,
                          child: const Icon(Icons.shopping_cart),
                        );
                      },
                    ),
                  ),
                ),
              ],
              backgroundColor: Theme.of(context).primaryColor,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Greating User text
                    AnimatedTextKit(
                      pause: const Duration(seconds: 5),
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TyperAnimatedText(
                          "Hi.. ${context.read<UserRepository>().userModel?.name}",
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    //info text
                    AnimatedTextKit(
                      pause: const Duration(milliseconds: 1500),
                      repeatForever: true,
                      animatedTexts: [
                        TyperAnimatedText(
                          "Find your products",
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                        TyperAnimatedText(
                          "Laptops",
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                        TyperAnimatedText(
                          "Mobiles",
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                        TyperAnimatedText(
                          "Groceries",
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                        TyperAnimatedText(
                          "and many more..!",
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            //HomeBanner Section
            const SliverToBoxAdapter(
              child: HomeBannerSection(),
            ),

            //Product Grid View Sections
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              sliver: BlocBuilder<AllproductBloc, CommonState>(
                buildWhen: (previous, current) {
                  if (current is CommonLoadingState) {
                    return current.showLoading;
                  } else {
                    return true;
                  }
                },
                builder: (context, state) {
                  if (state is CommonLoadingState) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is CommonSuccessState<List<Product>>) {
                    return SliverGrid.builder(
                      itemCount: state.userModel.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 5,
                        mainAxisExtent: 260,
                      ),
                      itemBuilder: (context, index) {
                        final product = state.userModel[index];
                        return ProductCard(product: product);
                      },
                    );
                  } else if (state is CommonErrorState) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(state.errorMsg),
                      ),
                    );
                  } else {
                    return const SliverFillRemaining(
                      child: SizedBox(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
