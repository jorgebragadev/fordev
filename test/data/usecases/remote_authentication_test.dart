// remote_authentication_test.dart
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Importar as classes necessárias

// Classes e Interfaces
abstract class HttpClient {
  Future<void> request({required String url, required String method});
}

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({
    required this.httpClient,
    required this.url,
  });

  Future<void> auth() async {
    await httpClient.request(url: url, method: 'post');
  }
}

// Implementação do Mock usando Mocktail
class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late RemoteAuthentication sut;
  late MockHttpClient httpClient;
  late String url;

  setUp(() {
    httpClient = MockHttpClient();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);

    // Configurar o mock para retornar um Future<void>
    when(() => httpClient.request(
        url: any(named: 'url'),
        method: any(named: 'method'))).thenAnswer((_) async => Future.value());
  });

  test('Should call HttpClient with correct values', () async {
    await sut.auth();
    verify(() => httpClient.request(url: url, method: 'post')).called(1);
  });
}
