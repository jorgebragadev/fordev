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
  late AuthenticationParams params;

  setUp(() {
    httpClient = MockHttpClient();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = AuthenticationParams(
      email: faker.internet.email(),
      password: faker.internet.password(),
    );

    when(() => httpClient.request(
          url: any(named: 'url'),
          method: any(named: 'method'),
          body: any(named: 'body'),
        )).thenAnswer((_) async => Future.value());
  });

  test('Should call HttpClient with correct values', () async {
    when(() => httpClient.request(
              url: any(named: 'url'),
              method: any(named: 'method'),
              body: any(named: 'body'),
            ))
        .thenAnswer((_) async =>
            {'accessToken': faker.guid.guid(), 'name': faker.person.name()});

    await sut.auth(params);

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

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient return 404', () async {
    when(() => httpClient.request(
          url: any(named: 'url'),
          method: any(named: 'method'),
          body: any(named: 'body'),
        )).thenThrow(HttpError.notFound);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient return 500', () async {
    when(() => httpClient.request(
          url: any(named: 'url'),
          method: any(named: 'method'),
          body: any(named: 'body'),
        )).thenThrow(HttpError.serverError);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError if HttpClient return 401',
      () async {
    when(() => httpClient.request(
          url: any(named: 'url'),
          method: any(named: 'method'),
          body: any(named: 'body'),
        )).thenThrow(HttpError.unauthorized);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('Should return an Account if HttpClient return 200', () async {
    final accessToken = faker.guid.guid();
    when(() => httpClient.request(
              url: any(named: 'url'),
              method: any(named: 'method'),
              body: any(named: 'body'),
            ))
        .thenAnswer((_) async =>
            {'accessToken': accessToken, 'name': faker.person.name()});

    final account = await sut.auth(params);

    expect(account.token, accessToken);
  });
}
