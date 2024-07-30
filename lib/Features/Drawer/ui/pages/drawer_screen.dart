// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:myecomapp/Features/Cat%20Page/ui/pages/cart_screen.dart';
import 'package:myecomapp/Features/Drawer/ui/widgets/drawer_tiles.dart';
import 'package:myecomapp/Features/Login%20Page/resources/user_repository.dart';
import 'package:myecomapp/Features/Login%20Page/ui/pages/login_screen.dart';
import 'package:myecomapp/Features/Order%20History/ui/pages/order_history_screen.dart';
import 'package:page_transition/page_transition.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final repo = context.read<UserRepository>();
    return LoadingOverlay(
      isLoading: isLoading,
      child: Drawer(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Image.asset(
                "assets/images/profile.png",
                height: 120,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                repo.userModel!.name,
                style: const TextStyle(fontSize: 20),
              ),
              const Divider(
                thickness: 2,
              ),
              DrawerTiles(
                text: "Your cart",
                icon: Icons.shopping_cart,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      PageTransition(
                          child: const CartScreen(),
                          type: PageTransitionType.fade));
                },
              ),
              DrawerTiles(
                text: "Order History",
                icon: Icons.online_prediction_rounded,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    PageTransition(
                        child: const OrderHistoryScreen(),
                        type: PageTransitionType.fade),
                  );
                },
              ),
              const Spacer(),
              DrawerTiles(
                text: "Logout",
                icon: Icons.logout,
                onTap: () {
                  Navigator.pop(context);
                  myAlertDialogBoxx(context, repo);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> myAlertDialogBoxx(BuildContext context, UserRepository repo) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/logout.png",
                height: 50,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Confirm Logout",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  textAlign: TextAlign.center,
                  "Are you sure you want to logout from the app ?"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("CANCEL"),
            ),
            TextButton(
              onPressed: () {
                repo.logout();
                Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                        child: const LoginScreen(),
                        type: PageTransitionType.fade),
                    (route) => false);
              },
              child: Text(
                "YES",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
