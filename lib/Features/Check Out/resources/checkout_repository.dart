// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:myecomapp/Common/constant/constant.dart';
import 'package:myecomapp/Features/Check%20Out/model/checkout_model.dart';

class CheckOutRepository {
  final Dio dio;
  CheckOutRepository({
    required this.dio,
  });

  Future<Either<String, void>> createOrder(
      {required CheckoutModel param}) async {
    try {
      final _ = await dio.post(Constant.createOrder, data: param.toMap());
      return const Right(null);
    } on DioException catch (e) {
      return Left(e.response!.data["message"] ?? "Unable to create order");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
