import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';

import '../models/models.dart';

class IncomeEntity {
  String incomeId;
  String details;
  DateTime date;
  double amount;

  IncomeEntity({
    required this.incomeId,
    required this.details,
    required this.date,
    required this.amount,
  });

  Map<String, Object?> toDocument() {
    return {
      'incomeId': incomeId, 
      'details': details, 
      'date': date, 
      'year': date.year, 
      'month': date.month, 
      'amount': amount
    };
  }

  static IncomeEntity fromDocument(Map<String, dynamic> doc) {
    return IncomeEntity(
      incomeId: doc['incomeId'], 
      details: doc['details'], 
      date: (doc['date'] as Timestamp).toDate(), 
      amount: doc['amount']
    );
  }

}