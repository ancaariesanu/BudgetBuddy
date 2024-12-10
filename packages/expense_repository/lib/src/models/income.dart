import 'package:expense_repository/expense_repository.dart';
import 'package:expense_repository/src/entities/income_entity.dart';

class Income {
  String incomeId;
  String details;
  DateTime date;
  double amount;

  Income({
    required this.incomeId,
    required this.details,
    required this.date,
    required this.amount,
  });

  static final empty = Income(
    incomeId: '',
    details: '',
    date: DateTime.now(),
    amount: 0,
  );

  IncomeEntity toEntity() {
    return IncomeEntity(
      incomeId: incomeId,
      details: details,
      date: date,
      amount: amount,
    );
  }

  static Income fromEntity(IncomeEntity entity) {
    return Income(
      incomeId: entity.incomeId,
      details: entity.details,
      date: entity.date,
      amount: entity.amount,
    );
  }
}
