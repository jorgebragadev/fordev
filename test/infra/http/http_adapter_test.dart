import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

class HttpAdapter {
  final http.Client client;

  HttpAdapter(this.client);

  Future<void> request({required String url, required String method}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    final uri = Uri.parse(url);
    if (method == 'post') {
      try {
        final response = await client.post(uri, headers: headers);
        // Processar a resposta, se necessário
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
      } catch (e) {
        print('Error during POST request: $e');
        throw e; // Lançar exceção para indicar erro na requisição
      }
      return; // Retorna void após o processamento
    }
    throw Exception('Unsupported method');
  }
}

void main() {
  late HttpAdapter sut;
  late MockClient mockClient;
  late String url;

  setUp(() {
    mockClient = MockClient();
    sut = HttpAdapter(mockClient);
    url = faker.internet.httpUrl();
  });

  group('post', () {
    test('Should call post with correct values', () async {
      // Configuração do mocktail para post com resposta simulada
      final headers = {
        'content-type': 'application/json',
        'accept': 'application/json'
      };

      // Simulando a resposta com uma Future<Response> válida
      when(() => mockClient.post(Uri.parse(url), headers: headers))
          .thenAnswer((_) async => http.Response('{}', 200));

      // Chama o método que você está testando
      await sut.request(url: url, method: 'post');

      // Verifica se o método foi chamado com os parâmetros corretos
      verify(() => mockClient.post(Uri.parse(url), headers: headers)).called(1);
    });
  });
}
