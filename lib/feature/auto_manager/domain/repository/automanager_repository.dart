import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/model/model.dart';

abstract class AutoManagerRepository{
 Future<Either<Failure, Company>> addCompany({required Company companyRequest});
}