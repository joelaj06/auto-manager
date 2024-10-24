import 'package:automanager/core/core.dart';
import 'package:automanager/feature/authentication/data/data.dart';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class HttpTestClient extends Mock implements Client {}

void main() {
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
    authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(
        client: AppHTTPClient(authLocalDataSourceImpl));
  });

  test(
      'given the AuthRemoteDataSourceImpl when login is called then return LoginResponse',
      () async {
    //arrange
    const LoginRequest request = LoginRequest(email: '1', password: '1');
    when(() => mockHttpClient.post(Uri.parse(baseUrl + AuthEndpoints.signin),
        body: request.toJson())).thenAnswer((_) async => Response('{}', 500));
    //act
    final LoginResponse res = await authRemoteDataSourceImpl.login(request);
    //assert
    expect(res,throwsException);
  });
}
