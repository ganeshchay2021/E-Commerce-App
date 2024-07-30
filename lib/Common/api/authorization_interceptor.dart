// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:myecomapp/Features/Login%20Page/resources/user_repository.dart';

class AuthorizationInterceptor extends Interceptor {
  final UserRepository userRepository;
  AuthorizationInterceptor({
    required this.userRepository,
  });
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (userRepository.token.isNotEmpty) {
      options.headers.addAll(
        {
          "Authorization":
              "Bearer ${userRepository.token}",
        },
      );
    }
    handler.next(options);
  }
}
