
import '../../../../core/utils/app_http_client.dart';
import '../models/models.dart';
import 'auth_endpoints.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({required AppHTTPClient client})
      : _client = client;
  final AppHTTPClient _client;


  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final Map<String, dynamic> json = await _client.post(
      AuthEndpoints.signin,
      body: request.toJson(),
    );
    return LoginResponse.fromJson(json);
  }

  @override
  Future<User> fetchUser(String userId) async {
    final Map<String, dynamic> json =
        await _client.get(AuthEndpoints.user(userId));
    return User.fromJson(json);
  }

  @override
  Future<User> updateUser(
      {required String userId, required UserRequest userRequest}) async {
    final Map<String, dynamic> json = await _client
        .put(AuthEndpoints.user(userId), body: userRequest.toJson());
    return User.fromJson(json);
  }

  @override
  Future<MessageResponse> logout() async {
    final Map<String, dynamic> json =
        await _client.delete(AuthEndpoints.signOut);
    return MessageResponse.fromJson(json);
  }

  @override
  Future<User> addUser({required UserRequest userRequest}) async {
    final Map<String, dynamic> json =
        await _client.post(AuthEndpoints.signup, body: userRequest.toJson());
    return User.fromJson(json);
  }

  @override
  Future<MessageResponse> passwordReset(
      {required PasswordResetRequest resetRequest}) async {
    final Map<String, dynamic> json = await _client
        .put(AuthEndpoints.passwordReset, body: resetRequest.toJson());
    return MessageResponse.fromJson(json);
  }
}
