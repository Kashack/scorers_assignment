import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../custom_exception.dart';

class AuthenticationRepository {
  final baseUrl = dotenv.get('API_URL',fallback: 'Api not found!');
  Future SignUpUser(String firstName, String lastName, String email,
      String username, String password, String repeatPassword) async {
    var body = jsonEncode({
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "username": username,
      "password": password,
      "repeat_password": repeatPassword,
    });
    try{
      final response = await http.post(
        Uri.parse('${baseUrl}auth/sign-up'),
        body: body,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      if(response.statusCode == 200 || response.statusCode == 201){
        return jsonDecode(response.body);
      }else{
        throw UserNotFoundException(jsonDecode(response.body)["data"]);
      }
    }on UserNotFoundException{
      rethrow;
    }catch (e){
      if(e is SocketException){
        throw SocketException('No Internet Connection');
      }
      throw Exception(e.runtimeType);
    }
  }

  Future SignInUser({required String email, required String password}) async {
    var body = jsonEncode({
      "email": email,
      "password": password,
    });
    try{
      final response = await http.post(
        Uri.parse('${baseUrl}auth/login'),
        body: body,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      if(response.statusCode == 200 || response.statusCode == 201){
        return jsonDecode(response.body);
      }else{
        throw UserNotFoundException(jsonDecode(response.body)['data']);
      }
    }on UserNotFoundException{
      rethrow;
    }catch (e){
      if(e is SocketException){
        throw SocketException('No Internet Connection');
      }
        throw Exception(e.runtimeType);
    }
  }
}

