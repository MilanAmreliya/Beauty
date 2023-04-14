import 'dart:convert';
import 'dart:developer';

import 'package:beuty_app/model/apis/api_exception.dart';
import 'package:beuty_app/model/services/base_service.dart';
import 'package:beuty_app/sharedPreference/shared_preference.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'base_service.dart';

enum APIType { aPost, aGet }

class ApiService extends BaseService {
  var response;

  Future<dynamic> getResponse(
      {@required APIType apiType,
      @required String url,
      Map<String, dynamic> body,
      bool fileUpload = false}) async {
    try {
      Map<String, String> header = {'Content-Type': 'application/json'};
      Map<String, String> headerWithToken = {
        'Content-Type': 'application/json',
        "Authorization": 'Bearer ${PreferenceManager.getToken()}'
      };
      Map<String, String> headerTokenGet = {
        "Authorization": 'Bearer ${PreferenceManager.getToken()}'
      };
      log("URL ---> ${Uri.parse(baseURL + url)}");
      log('Header :$headerTokenGet');
      if (apiType == APIType.aGet) {
        var result =
            await http.get(Uri.parse(baseURL + url), headers: headerTokenGet);
        response = returnResponse(
          result.statusCode,
          result.body,
        );
        // log("response......${response}");
      } else if (fileUpload) {
        dio.FormData formData = new dio.FormData.fromMap(body);

        dio.Response result = await dio.Dio().post(baseURL + url,
            data: formData,
            options: dio.Options(
                contentType: "form-data", headers: headerWithToken));

        response = returnResponse(result.statusCode, jsonEncode(result.data));
        // log("response......${response}");
      } else {
        String encodeBody = jsonEncode(body);
        var result = await http.post(
          Uri.parse(baseURL + url),
          headers:
              url == registerURL || url == loginURL ? header : headerWithToken,
          body: encodeBody,
        );
        response = returnResponse(result.statusCode, result.body);
        log("response......${response}");
      }
      return response;
    } catch (e) {
      log('Error=>.. $e');
    }
  }

  returnResponse(int status, String result) {
    switch (status) {
      case 200:
        return jsonDecode(result);
      case 400:
        throw BadRequestException('Bad Request');
      case 401:
        throw UnauthorisedException('Unauthorised user');
      case 404:
        throw ServerException('Server Error');
      case 500:
      default:
        throw FetchDataException('Internal Server Error');
    }
  }
}
