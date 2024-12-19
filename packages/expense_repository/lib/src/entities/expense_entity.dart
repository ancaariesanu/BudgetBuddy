import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';

class ExpenseEntity {
  String expenseId;
  Category category;
  String details;
  DateTime date;
  double amount;
  String receiptPhoto;

  ExpenseEntity({
    required this.expenseId,
    required this.category,
    required this.details,
    required this.date,
    required this.amount,
    required this.receiptPhoto
  });

  Map<String, Object?> toDocument() {
    return {
      'expenseId': expenseId, 
      'category': category.toEntity().toDocument(), 
      'details': details, 
      'date': date, 
      'year': date.year, 
      'month': date.month, 
      'amount': amount,
      'receiptPhoto': receiptPhoto
    };
  }

  static ExpenseEntity fromDocument(Map<String, dynamic> doc) {
    return ExpenseEntity(
      expenseId: doc['expenseId'], 
      category: Category.fromEntity(CategoryEntity.fromDocument(doc['category'])), 
      details: doc['details'], 
      date: (doc['date'] as Timestamp).toDate(), 
      amount: doc['amount'],
      receiptPhoto: doc['receiptPhoto']
    );
  }

}