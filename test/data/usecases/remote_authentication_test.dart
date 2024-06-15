import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Importar as classes necessárias
import 'package:fordev/domain/usecases/authentication.dart';

// Classes e Interfaces
abstract class HttpClient {
  Future<void> request(
      {required String url, required String method, Map? body});
}

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({
    required this.httpClient,
    required this.url,
  });

  Future<void> auth(AuthenticationParams params) async {
    final body = {'email': params.email, 'password': params.password};
    await httpClient.request(url: url, method: 'post', body: body);
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
          method: any(named: 'method'),
          body: any(named: 'body'),
        )).thenAnswer((_) async => Future.value());
  });

  test('Should call HttpClient with correct values', () async {
    final params = AuthenticationParams(
      email: faker.internet.email(),
      password: faker.internet.password(),
    );

    await sut.auth(params);

    verify(() => httpClient.request(
          url: url,
          method: 'post',
          body: {'email': params.email, 'password': params.password},
        )).called(1);
  });
}
