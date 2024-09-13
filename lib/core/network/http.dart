import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class NetWork {
  static String baseUrl = baseUrl;
  final Map<String, String> headers = {};
  Future<dynamic> post(String url, {Object? data, String? token}) async {
    final tokenRes =
        await http.post(Uri.parse(baseUrl), body: jsonEncode(data), headers: {
      ...headers,
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    return jsonDecode(tokenRes.body);
  }

  Future<dynamic> get(String url, {String? token}) async {
    final tokenRes = await http.get(Uri.parse(baseUrl));
    return tokenRes;
  }

  Future<dynamic> put(String url, {Object? data, String? token}) async {
    final tokenRes =
        await http.put(Uri.parse(baseUrl), body: jsonEncode(data), headers: {
      ...headers,
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    return jsonDecode(tokenRes.body);
  }

  Future<dynamic> patch(String url, {Object? data, String? token}) async {
    final tokenRes =
        await http.patch(Uri.parse(baseUrl), body: jsonEncode(data), headers: {
      ...headers,
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    return jsonDecode(tokenRes.body);
  }

  Future<dynamic> delete(String url, {String? token}) async {
    final tokenRes = await http.delete(Uri.parse(baseUrl), headers: {
      ...headers,
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    return jsonDecode(tokenRes.body);
  }
}
