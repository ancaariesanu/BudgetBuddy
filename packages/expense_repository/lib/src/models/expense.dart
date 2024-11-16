import 'package:expense_repository/expense_repository.dart';

class Expense {
  String expenseId;
  Category category;
  String details;
  DateTime date;
  double amount;
  String receiptPhoto;

  Expense({
    required this.expenseId,
    required this.category,
    required this.details,
    required this.date,
    required this.amount,
    required this.receiptPhoto
  });

  static final empty = Expense(
    expenseId: '', 
    category: Category.empty, 
    details: '', 
    date : DateTime.now(),
    amount: 0, 
    receiptPhoto: ''
  );

  ExpenseEntity toEntity() {
    return ExpenseEntity(
      expenseId: expenseId,
      category: category,
      details: details,
      date: date,
      amount: amount,
      receiptPhoto: receiptPhoto
    );
  }

  static Expense fromEntity(ExpenseEntity entity) {
    return Expense(
      expenseId: entity.expenseId,
      category: entity.category,
      details: entity.details,
      date: entity.date,
      amount: entity.amount,
      receiptPhoto: entity.receiptPhoto
    );
  }
}
