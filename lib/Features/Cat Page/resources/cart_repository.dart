import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:myecomapp/Common/constant/constant.dart';
import 'package:myecomapp/Features/Cat%20Page/model/cart_model.dart';

class CartRepository {
  final Dio dio;
  CartRepository({
    required this.dio,
  });

  Future<Either<String, void>> addToCart({required String productId}) async {
    try {
      final _ = await dio.post(
        Constant.addToCcart,
        data: {
          "product": productId,
        },
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(e.response!.data["message"] ?? "Unable to add the product");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<CartModel>>> fetchCartProduct() async {
    try {
      final response = await dio.get(Constant.addToCcart);
      final data = List.from(response.data["results"])
          .map((e) => CartModel.fromMap(e))
          .toList();
      return Right(data);
    } on DioException catch (e) {
      return Left(e.response!.data["message"] ?? "Unable to show cart List");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, int>> fetchTotalCartPrice() async {
    try {
      final response = await dio.get(Constant.cartTotalPrice);
      final data = response.data["totalPrice"];
      return Right(data);
    } on DioException catch (e) {
      return Left(e.response!.data["message"] ?? "Unable to show cart List");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, CartModel>> updateCartProductQuantity(
      {required String cartId, required int quantity}) async {
    try {
      final response = await dio.put(
        "${Constant.addToCcart}/$cartId",
        data: {
          "quantity": quantity,
        },
      );
      final data = CartModel.fromMap(response.data["results"]);
      return Right(data);
    } on DioException catch (e) {
      return Left(e.response!.data["message"] ?? "Unable to show cart List");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, int>> cartCount() async {
    try {
      final response = await dio.get(Constant.totalNumberOfCartItem);
      final data = response.data["counts"];
      return Right(data);
    } on DioException catch (e) {
      return Left(e.response!.data["message"] ?? "Unable to show cart List");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> deleteCartProduct(
      {required String cartId}) async {
    try {
      final _ = await dio.delete("${Constant.addToCcart}/$cartId");
      return const Right(null);
    } on DioException catch (e) {
      return Left(e.response!.data["message"] ?? "Unable to delete");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
