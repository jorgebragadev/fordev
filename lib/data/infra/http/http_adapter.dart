import 'dart:convert';
import 'package:fordev/data/http/http_error.dart';
import 'package:http/http.dart';

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);

  Future<dynamic> request({
    required String url,
    required String method,
    Map? body,
    Map<String, String>? headers, // headers como opcional
  }) async {
    final defaultHeaders = {
      'content-type': 'application/json',
      'accept': 'application/json',
      ...?headers,
    };

    final jsonBody = body != null ? jsonEncode(body) : null;

    var response = Response('', 500); 

    try {
      if (method == 'post') {
        response = await client.post(Uri.parse(url), headers: defaultHeaders, body: jsonBody);
      } else if (method == 'get') {
        response = await client.get(Uri.parse(url), headers: defaultHeaders);
      } else if (method == 'put') {
        response = await client.put(Uri.parse(url), headers: defaultHeaders, body: jsonBody);
      } else {
        throw HttpError.serverError;
      }
    } catch (error) {
      throw HttpError.serverError;
    }

    return _handleResponse(response);
  }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body.isEmpty ? null : jsonDecode(response.body);
      case 204:
        return null;
      case 400:
        throw HttpError.badRequest;
      case 401:
        throw HttpError.unauthorized;
      case 403:
        throw HttpError.forbidden;
      case 404:
        throw HttpError.notFound;
      case 500:
      default:
        throw HttpError.serverError;
    }
  }
}
