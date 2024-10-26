import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/models.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(LoginRequest request);

  Future<Either<Failure, User>> loadUser();

  Future<Either<Failure, User>> fetchUser(String userId);

  Future<Either<Failure, User>> updateUser({
    required String id,
    String? firstName,
    String? lastName,
    String? email,
    String? address,
    String? phone,
    String? image,
    String? jobTitle,
    String? jobDescription,
    String? company,
    List<String>? skills,
    bool? isAgent,
  });

  Future<Either<Failure, MessageResponse>> logout();

  Future<Either<Failure, UserRegistration>> addUser(
      {required UserRequest userRequest});

  Future<Either<Failure, MessageResponse>> passwordReset(
      {required PasswordResetRequest resetRequest});

  Future<Either<Failure, UserRegistration>> verifyOtp(
      {required OtpVerificationRequest request});

  Future<Either<Failure, UserRegistration>> loadUserSignUpData();


}
