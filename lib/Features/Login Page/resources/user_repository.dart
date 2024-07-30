import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myecomapp/Common/constant/constant.dart';
import 'package:myecomapp/Common/utils/storage_utils.dart';
import 'package:myecomapp/Features/Login%20Page/model/user_model.dart';

class UserRepository {
  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  String _token = "";

  String get token => _token;

  //Finction saving the data in local varialble
  Future<void> initialization() async {
    _userModel = await StorageUtils.getUser;
    _token = await StorageUtils.getToken;
  }

  //Function Deleting the saved users details when logout
  Future<void> logout() async {
    _userModel = null;
    _token = "";
    await StorageUtils.deleteToken();
    await StorageUtils.deleteUser();
  }

  //instance of dio created
  Dio dio = Dio();

  //Login
  Future<Either<UserModel, String>> login(
      {required String email,
      required String password,
      required bool rememberMe}) async {
    try {
      //post request
      final response = await dio.post(Constant.login, data: {
        "email": email,
        "password": password,
      });
      //save login Credential
      if (rememberMe) {
        StorageUtils.saveLoginCredential((
          email: email,
          password: password,
        ));
      }

      //get response data
      final tempUserdata = UserModel.fromMap(response.data["results"]);
      final tempToken = response.data["token"];

      //save user data and token in sharedPreference
      StorageUtils.saveToken(token: tempToken);
      StorageUtils.saveUser(user: tempUserdata);

      //save user data and token in local Variable
      _userModel = tempUserdata;
      _token = tempToken;

      //return back the response data
      return Left(tempUserdata);
    } on DioException catch (e) {
      //return back the error message
      return Right(e.response!.data["message"] ?? "Unable to login");
    } catch (e) {
      //return back the error message
      return Right(e.toString());
    }
  }

  //Sign up
  Future<Either<void, String>> signUpUser(
      {required String name,
      required String email,
      required String password,
      required String phoneNumber,
      required String address}) async {
    //Maped User Data
    Map<String, dynamic> userData = {
      "name": name,
      "email": email,
      "password": password,
      "phone": phoneNumber,
      "address": address,
    };
    try {
      //post request
      final _ = await dio.post(
          "https://ecommerce-api-3sb4.onrender.com/api/auth/register",
          data: FormData.fromMap(userData));

      //return back
      return const Left(null);
    } on DioException catch (e) {
      //return back error message
      return Right(e.response!.data["message"] ?? "Unable to sign up");
    } catch (e) {
      //return back error message
      return Right(e.toString());
    }
  }

  Future<Either<UserModel, String>> loginWithFb() async {
    try {
      FacebookAuth.instance.logOut();
      final LoginResult result =
          await FacebookAuth.instance.login(permissions: []);
      // by default we request the email and the public profile
      // or FacebookAuth.i.login()
      if (result.status == LoginStatus.success) {
        // you are logged
        final AccessToken accessToken = result.accessToken!;
        final response = await Dio().post(
            "https://ecommerce-api-3sb4.onrender.com/api/auth/login/social/facebook",
            data: {
              "token": accessToken.tokenString,
            });
        final tempUserdata = UserModel.fromMap(response.data["results"]);
        final tempToken = response.data["token"];
        _userModel = tempUserdata;
        _token = tempToken;
        StorageUtils.saveToken(token: tempToken);
        StorageUtils.saveUser(user: tempUserdata);
        return Left(tempUserdata);
      } else {
        return Right(result.message ?? "Unable to Login with Facebook");
      }
    } on DioException catch (e) {
      //return back error message
      return Right(e.response!.data["message"] ?? "Unable to Login");
    } catch (e) {
      //return back error message
      return Right(e.toString());
    }
  }

  Future<Either<UserModel, String>> loginWithGoogle() async {
    try {
      //google sign in initialize
      GoogleSignIn googleSignIn = GoogleSignIn(scopes: ["email"]);

      //getting toekn
      final googleResponse = await googleSignIn.signIn();
      //signout
      await googleSignIn.signOut();
      //api hit to the google server
      if (googleResponse != null) {
        final accessToken = await googleResponse.authentication;
        final response = await dio.post(
            "https://ecommerce-api-3sb4.onrender.com/api/auth/login/social/google",
            data: {
              "token": accessToken.accessToken,
            });
        //mapping data
        final tempUserdata = UserModel.fromMap(response.data["results"]);
        final tempToken = response.data["token"];
        _userModel = tempUserdata;
        _token = tempToken;

        //savaing sata in sharedpreference
        StorageUtils.saveToken(token: tempToken);
        StorageUtils.saveUser(user: tempUserdata);

        //return back data
        return Left(tempUserdata);
      } else {
        return const Right("Unable to Login with Google");
      }
    } on DioException catch (e) {
      //return back error message
      return Right(e.response!.data["message"] ?? "Unable to sign up");
    } catch (e) {
      //return back error message
      return Right(e.toString());
    }
  }
}
