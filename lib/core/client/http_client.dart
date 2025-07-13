import 'package:http/http.dart' as http;

abstract class HttpClient {
  Future<http.Response> get(Uri url);
  Future<http.Response> post(Uri url, {Map<String, dynamic>? body});
}

class HttpClientImpl implements HttpClient {
  final http.Client _client;

  HttpClientImpl(this._client);

  @override
  Future<http.Response> get(Uri url) => _client.get(url);
  @override
  Future<http.Response> post(Uri url, {Map<String, dynamic>? body}) {
    return _client.post(url, body: body ?? {});
  }
}
