// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:myecomapp/Common/constant/constant.dart';
import 'package:myecomapp/Features/Order%20Details/model/order_product_model.dart';
import 'package:myecomapp/Features/Order%20History/model/order_model.dart';

class OrderRepository {
  final Dio dio;
  OrderRepository({required this.dio});

  Future<Either<String, List<OrderModel>>> fetchallOrders() async {
    try {
      final response = await dio.get(Constant.orderList);
      final data = List.from(response.data["results"])
          .map((e) => OrderModel.fromMap(e))
          .toList();
      return Right(data);
    } on DioException catch (e) {
      return Left(e.response!.data["message"] ?? "Unable to show orderlist");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, OrderProductModel>> fetchSIngleOrdersDetails(
      {required String orderId}) async {
    try {
      final response = await dio.get("${Constant.orderList}/$orderId");
      final data = OrderProductModel.fromMap(response.data["results"]);
      return Right(data);
    } on DioException catch (e) {
      return Left(
          e.response!.data["message"] ?? "Unable to show Order Details");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> deleteOrder({required String orderId}) async {
    try {
      final _ = await dio.delete("${Constant.orderList}/$orderId");
      return const Right(null);
    } on DioException catch (e) {
      return Left(
          e.response!.data["message"] ?? "Unable to show delete Order");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
