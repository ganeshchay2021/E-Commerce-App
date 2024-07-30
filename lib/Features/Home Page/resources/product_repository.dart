import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:myecomapp/Common/constant/constant.dart';
import 'package:myecomapp/Features/Home%20Page/model/product_model.dart';

class ProductRepository {
  final Dio dio;
  ProductRepository({
    required this.dio,
  });

  int _currentProductPage = 1;

  int _totalProductCount = -1;

  final List<Product> _product = [];

  List<Product> get product => _product;

  Future<Either<List<String>, String>> fetcHomeBanner() async {
    try {
      final response = await dio.get(Constant.banner);
      final data =
          List.from(response.data["results"]).map((e) => e.toString()).toList();
      return Left(data);
    } on DioException catch (e) {
      return Right(e.response!.data["message"] ?? "Unabele to show banner");
    } catch (e) {
      return Right(e.toString());
    }
  }

  Future<Either<List<Product>, String>> fetcAllProduct(
      {bool isLoadmore = false}) async {
    try {
      if(_totalProductCount==_product.length && isLoadmore){
        return Left(_product);
      }
      if (isLoadmore) {
        _currentProductPage++;
      } else {
        _currentProductPage = 1;
        _totalProductCount=-1;
        _product.clear();
      }
      final response = await dio.get(Constant.allProduct, queryParameters: {
        "page": _currentProductPage,
      });
      final data = List.from(response.data["results"])
          .map((e) => Product.fromMap(e))
          .toList();
      _product.addAll(data);
      _totalProductCount=response.data["total"];
      return Left(data);
    } on DioException catch (e) {
      return Right(e.response!.data["message"] ?? "Unabele to show product");
    } catch (e) {
      return Right(e.toString());
    }
  }

  Future<Either<Product, String>> fetcSingleProduct(
      {required String productId}) async {
    try {
      final response = await dio.get("${Constant.allProduct}/$productId");
      final data = Product.fromMap(response.data["results"]);
      return Left(data);
    } on DioException catch (e) {
      return Right(e.response!.data["message"] ?? "Unabele to show product");
    } catch (e) {
      return Right(e.toString());
    }
  }
}
