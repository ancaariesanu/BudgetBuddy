import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:expense_repository/src/entities/income_entity.dart';
import 'package:expense_repository/src/income_repo.dart';

class FirebaseIncomeRepo implements IncomeRepository {
  final incomeCollection = FirebaseFirestore.instance.collection('incomes');

  @override
  Future<void> createIncome(Income income) async {
    try {
      await incomeCollection.doc(income.incomeId).set(income.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Income>> getIncomes() async {
    try {
      return await incomeCollection.get().then((value) =>
          value.docs.map((e) => Income.fromEntity(IncomeEntity.fromDocument(e.data()))).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Income>> getIncomesByMonth(int year, int month) async {
    try {
      final snapshot = await incomeCollection
          .where('year', isEqualTo: year)
          .where('month', isEqualTo: month)
          .get();

      return snapshot.docs
          .map((doc) => Income.fromEntity(IncomeEntity.fromDocument(doc.data())))
          .toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}