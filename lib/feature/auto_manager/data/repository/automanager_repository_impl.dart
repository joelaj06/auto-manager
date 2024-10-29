import 'package:automanager/core/errors/failure.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/utils/repository.dart';
import '../../domain/domain.dart';
import '../data.dart';

class AutoManagerRepositoryImpl extends Repository
    implements AutoManagerRepository {
  AutoManagerRepositoryImpl({required this.autoManagerRemoteDataSource});

  final AutoManagerRemoteDatasource autoManagerRemoteDataSource;

  @override
  Future<Either<Failure, Company>> addCompany(
      {required Company companyRequest}) {
    return makeRequest(autoManagerRemoteDataSource.addCompany(companyRequest));
  }


}
