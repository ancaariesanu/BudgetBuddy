import 'package:expense_repository/expense_repository.dart';

abstract class IncomeRepository {
  Future<void> createIncome(Income income);

  Future<List<Income>> getIncomes();

  Future<List<Income>> getIncomesByMonth(int year, int month);
}