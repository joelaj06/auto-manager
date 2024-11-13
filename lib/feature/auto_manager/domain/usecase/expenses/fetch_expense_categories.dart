import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:dartz/dartz.dart';

import '../../../data/model/response/expense/expense_category.dart';

class FetchExpenseCategories implements UseCase<List<ExpenseCategory>, NoParams>{

  FetchExpenseCategories({required this.autoManagerRepository});
  final AutoManagerRepository autoManagerRepository;
  @override
  Future<Either<Failure, List<ExpenseCategory>>> call(NoParams params) {
   return autoManagerRepository.fetchExpenseCategories();
  }
}