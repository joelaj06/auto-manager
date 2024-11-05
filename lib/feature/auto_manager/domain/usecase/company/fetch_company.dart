import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:dartz/dartz.dart';

class FetchCompany implements UseCase<Company, PageParams>{

  FetchCompany({required this.autoManagerRepository});

  final AutoManagerRepository autoManagerRepository;
  @override
  Future<Either<Failure, Company>> call(PageParams params) {
    return autoManagerRepository.fetchCompany(params.companyId!);
  }

}