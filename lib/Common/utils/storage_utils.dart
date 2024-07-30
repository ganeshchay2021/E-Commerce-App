import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myecomapp/Features/Login%20Page/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageUtils {
  //Create Storage
  static const storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  //creating key value
  static const String _emailKey = "email";
  static const String _passwordKey = "password";
  static const String _tokenKey = "token";
  static const String _userKey = "user";

  //Function save the login credential
  static Future<void> saveLoginCredential(
      ({String email, String password}) loginData) async {
    await storage.write(key: _emailKey, value: loginData.email);
    await storage.write(key: _passwordKey, value: loginData.password);
  }

  //Function Fetch the login credential
  static Future<({String email, String password})> getLoginCredential() async {
    final email = await storage.read(key: _emailKey);
    final password = await storage.read(key: _passwordKey);
    return (email: email ?? "", password: password ?? "");
  }

  //Function save the token
  static Future<void> saveToken({required String token}) async {
    final instance = await SharedPreferences.getInstance();
    instance.setString(_tokenKey, token);
  }

  //Function fetch the token
  static Future<String> get getToken async {
    final instance = await SharedPreferences.getInstance();
    return instance.getString(_tokenKey) ?? "";
  }

  //Function delete the token
  static Future<void> deleteToken() async {
    final instance = await SharedPreferences.getInstance();
    instance.remove(_tokenKey);
  }

  //Function save the User's data in local storage or shared preference
  static Future<void> saveUser({required UserModel user}) async {
    final instance = await SharedPreferences.getInstance();
    final mappedUser = user.toMap();
    final encodedData = json.encode(mappedUser);
    instance.setString(_userKey, encodedData);
  }

  //Function fetch the User's data from local storage or shared preference
  static Future<UserModel?> get getUser async {
    final instance = await SharedPreferences.getInstance();
    final encodedData = instance.getString(_userKey);
    if (encodedData != null) {
      final Map<String, dynamic> decodedData = Map<String, dynamic>.from(
        json.decode(encodedData),
      );
      return UserModel.fromMap(decodedData);
    } else {
      return null;
    }
  }

  //Function deelete the User's data from local storage or shared preference
  static Future<void> deleteUser() async {
    final instance = await SharedPreferences.getInstance();
    instance.remove(_userKey);
  }
}
