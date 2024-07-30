import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:myecomapp/Common/api/authorization_interceptor.dart';
import 'package:myecomapp/Common/wrapper/notification.dart';
import 'package:myecomapp/Features/Cat%20Page/cubit/cart_count_cubit.dart';
import 'package:myecomapp/Features/Cat%20Page/resources/cart_repository.dart';
import 'package:myecomapp/Features/Check%20Out/resources/checkout_repository.dart';
import 'package:myecomapp/Features/Home%20Page/resources/product_repository.dart';
import 'package:myecomapp/Features/Login%20Page/resources/user_repository.dart';
import 'package:myecomapp/Features/Order%20History/resources/order_repository.dart';
import 'package:myecomapp/Features/Splash%20Screen/ui/pages/splash_screen.dart';
import 'package:myecomapp/firebase_options.dart';

Future<void> onBackgroundHandler(RemoteMessage message) async {
  Firebase.initializeApp();
  print(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider(
          create: (context) => Dio()
            ..interceptors.add(
              AuthorizationInterceptor(
                userRepository: context.read<UserRepository>(),
              ),
            ),
        ),
        RepositoryProvider(
          create: (context) => ProductRepository(
            dio: context.read<Dio>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => CartRepository(
            dio: context.read<Dio>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => CheckOutRepository(
            dio: context.read<Dio>(),
          ),
        ),
        RepositoryProvider(
            create: (context) => OrderRepository(dio: context.read<Dio>()))
      ],
      child: NotificationWrapper(
        child: KhaltiScope(
          publicKey: "test_public_key_6ff8b3a2411e43dc9597ec7345e7c402",
          builder: (context, navKey) {
            return BlocProvider(
              create: (context) => CartCountCubit(
                  cartRepository: context.read<CartRepository>()),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                navigatorKey: navKey,
                supportedLocales: const [
                  Locale('en', 'US'),
                  Locale('ne', 'NP'),
                ],
                localizationsDelegates: const [
                  KhaltiLocalizations.delegate,
                ],
                title: 'E-commerce App',
                theme: ThemeData(
                  textTheme: GoogleFonts.lexendDecaTextTheme(),
                  primaryColor: generateMaterialColor(color: Colors.pink[400]!),
                ),
                home: const SplashScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
