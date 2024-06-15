import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fordev/data/http/http_client.dart';
import 'package:fordev/data/http/http_error.dart';
import 'package:fordev/data/remote_authentication.dart';
import 'package:fordev/domain/helpers/domain_error.dart';
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

    // Chamar o método auth que deve acionar a request no HttpClient
    await sut.auth(params);

    // Verificar se o HttpClient.request foi chamado corretamente
    verify(() => httpClient.request(
          url: url,
          method: 'post',
          body: {'email': params.email, 'password': params.password},
        )).called(1);
  });

  test('Should throw UnexpectedError if HttpClient return 400', () async {
    when(() => httpClient.request(
          url: any(named: 'url'),
          method: any(named: 'method'),
          body: any(named: 'body'),
        )).thenThrow(HttpError.badRequest);

    final params = AuthenticationParams(
      email: faker.internet.email(),
      password: faker.internet.password(),
    );

    // Chamar o método auth dentro do escopo do teste
    final future = sut.auth(params);

    // Verificar se o futuro lança a exceção esperada
    expect(
        future,
        throwsA(
            DomainError.unexpected)); // Corrigido para DomainError.unexpected
  });
}
