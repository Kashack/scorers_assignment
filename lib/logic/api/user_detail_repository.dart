import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../custom_exception.dart';
import '../model/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserDetailRepository{
  final baseUrl = dotenv.get('API_URL',fallback: 'Api not found!');
  Future<UserDetail> GetUserProfile({required String authorizationToken}) async{
    try{
      final response = await http.get(
        Uri.parse('${baseUrl}profile/get-profile-by-user-id'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: 'Bearer $authorizationToken',
        },
      );
      print(response.body);
      if(response.statusCode == 200 || response.statusCode == 201){
        return UserDetail.fromJson(jsonDecode(response.body)["data"]);
      }else{
        throw UserDetailException(jsonDecode(response.body)["data"]);
      }
    }on UserDetailException{
      rethrow;
    }catch (e){
      if(e is SocketException){
        throw SocketException('No Internet Connection');
      }
      throw Exception(e.runtimeType);
    }
  }

  Future UpdateUserProfile({required String authorizationToken, required UserDetail userDetail}) async {
    var request = http.MultipartRequest('PATCH', Uri.parse('${baseUrl}profile/update-profile'));
    request.fields['firstName'] = userDetail.firstName;
    request.fields['lastName'] = userDetail.lastName;
    request.fields['email'] = userDetail.email;
    request.fields['username'] = userDetail.username;
    request.fields['gender'] = userDetail.gender!;
    request.fields['age'] = userDetail.age!.toString();
    request.fields['DOB'] = userDetail.DOB!;
    if(userDetail.nationality != null){
      request.fields['nationality'] = userDetail.nationality!;
    }
    request.headers['Authorization'] = 'Bearer $authorizationToken';

    try{
      var response = await request.send();
      var responsed = await response.stream.bytesToString();

      if(response.statusCode == 200 || response.statusCode == 201){
        return UserDetail.fromJson(jsonDecode(responsed)["data"]);
      }else{
        throw UserDetailException(jsonDecode(responsed)["data"]);
      }
    }on UserDetailException{
      rethrow;
    }catch (e){
      if(e is SocketException){
        throw SocketException('No Internet Connection');
      }
      throw Exception(e.runtimeType);
    }
  }
}