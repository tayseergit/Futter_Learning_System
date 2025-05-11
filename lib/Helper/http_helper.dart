import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpHelper {
  static String basic_url_api = "http://192.168.1.16:8000/api/";
  static String basic_url_image = "http://192.168.1.16:8000";
  static Future<Response> getData({
    required String url,
    Map<String, String>? headers,
  }) async {
    return await http.get(Uri.parse("$basic_url_api$url"), headers: headers);
  }

  static Future<Response> postData({
    required String url,
    Map<String, String>? postData,
    Map<String, String>? headers,
  }) async {
    return http.post(
      Uri.parse("$basic_url_api$url"),
      body: postData,
      headers: headers,
    );
  }

    static Future<http.Response> postMultipart({
    required String url,
    required File file,
    required String fieldName,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse("$basic_url_api$url");
    final request = http.MultipartRequest('POST', uri);

    // Attach file
    request.files.add(await http.MultipartFile.fromPath(fieldName, file.path));

    // Optional headers
    if (headers != null) {
      request.headers.addAll(headers);
    }

    // Send and get response
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    return response;
  }
}
