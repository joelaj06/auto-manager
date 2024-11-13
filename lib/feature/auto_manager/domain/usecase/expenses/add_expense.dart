import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/data/model/response/expense/expense.dart';
import 'package:dartz/dartz.dart';

import '../../../data/model/request/expense/add_expense_request.dart';
import '../../repository/automanager_repository.dart';


class AddExpense implements UseCase<Expense, AddExpenseRequest>{

  AddExpense({required this.autoManagerRepository});
  final AutoManagerRepository autoManagerRepository;
  @override
  Future<Either<Failure, Expense>> call(AddExpenseRequest request) {
    return autoManagerRepository.addExpense(addExpenseRequest: request);
  }

}