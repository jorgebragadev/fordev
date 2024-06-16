import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

class HttpAdpater {
  final Client client;

  HttpAdpater(this.client);

  Future<void> request({
    required String url,
    required String method,
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final uri = Uri.parse(url);
    if (method == 'post') {
      await client.post(uri, headers: headers, body: body);
    }
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  group('post', () {
    test('Should call post with correct values', () async {
      final client = ClientSpy();
      final sut = HttpAdpater(client);
      final url = faker.internet.httpUrl();

      await sut.request(url: url, method: 'post');

      verify(client.post(
        Uri.parse(url),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      ));
    });
  });
}
