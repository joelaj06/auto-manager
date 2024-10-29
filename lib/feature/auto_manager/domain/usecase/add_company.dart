import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/data/model/model.dart';
import 'package:dartz/dartz.dart';

import '../repository/automanager_repository.dart';

class AddCompany implements UseCase<Company, Company>{
  AddCompany({required this.autoManagerRepository});
  final AutoManagerRepository autoManagerRepository;
  @override
  Future<Either<Failure, Company>> call(Company request) {
    return autoManagerRepository.addCompany(companyRequest: request);
  }

}