import 'package:automanager/core/core.dart';
import 'package:automanager/feature/authentication/data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class HttpTestClient extends Mock implements Client {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const String baseUrl = 'http://192.168.100.12/api';
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;
  late AuthLocalDataSource authLocalDataSourceImpl;
  late SharedPreferencesWrapper sharedPrefsWrapper;
  late HttpTestClient mockHttpClient;

  setUp(() {
    mockHttpClient = HttpTestClient();
    sharedPrefsWrapper = SharedPreferencesWrapper();
    authLocalDataSourceImpl = AuthLocalDataSourceImpl(sharedPrefsWrapper);
    Get.put<AuthLocalDataSource>(authLocalDataSourceImpl);

    // Pass the mock client to AppHTTPClient
    authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(
      client: AppHTTPClient( authLocalDataSource: authLocalDataSourceImpl, httpClient: mockHttpClient),
    );
  });

  test(
      'given the AuthRemoteDataSourceImpl when login is called then return LoginResponse',
          () async {
        // Arrange
        const LoginRequest request = LoginRequest(email: 'joelaj06@gmail.com', password: 'test');
        const String responseJson = '{"token": "mockToken"}';

        // Set up the mock to return a successful response
        when(() => mockHttpClient.post(
          Uri.parse(baseUrl + AuthEndpoints.signin),
          headers: any(named: 'headers'),
          body: request.toJson(),
        )).thenAnswer((_) async => Response(responseJson, 200));

        // Act
        final LoginResponse res = await authRemoteDataSourceImpl.login(request);

        // Assert
        expect(res, isA<LoginResponse>());
        expect(res.token, equals('mockToken'));
      });
}
