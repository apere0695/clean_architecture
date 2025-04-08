import 'package:http/http.dart' as http;

abstract class HttpClient {
  Future<http.Response> get(Uri url);
}

class HttpClientImpl implements HttpClient {
  final http.Client _client;

  HttpClientImpl(this._client);

  @override
  Future<http.Response> get(Uri url) => _client.get(url);
}
