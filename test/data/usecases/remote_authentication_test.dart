import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fordev/data/http/http_client.dart';
import 'package:fordev/data/remote_authentication.dart';
import 'package:mocktail/mocktail.dart';


import 'package:fordev/domain/usecases/authentication.dart';



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
