import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:dartz/dartz.dart';

class UpdateCompany implements UseCase<Company, Company> {
  UpdateCompany({required this.autoManagerRepository});

  final AutoManagerRepository autoManagerRepository;

  @override
  Future<Either<Failure, Company>> call(Company request) {
    return autoManagerRepository.updateCompany(companyRequest: request);
  }
}
