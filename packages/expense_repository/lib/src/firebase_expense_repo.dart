import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseExpenseRepo implements ExpenseRepository{
  final categoryCollection = FirebaseFirestore.instance.collection('categories');
  final expenseCollection = FirebaseFirestore.instance.collection('expenses');
  final storageRef = FirebaseStorage.instance.ref();

  @override
  Future<void> createCategory(Category category) async {
    try {
      await categoryCollection
        .doc(category.categoryId)
        .set(category.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Category>> getCategory() async {
    try {
      return await categoryCollection
        .get()
        .then((value) => value.docs.map((e) => 
          Category.fromEntity(CategoryEntity.fromDocument(e.data()))
        ).toList()) ;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> createExpense(Expense expense) async {
    try {
      final categoryRef = categoryCollection.doc(expense.category.categoryId);

      // Run a transaction to update the category's totalExpenses and the related expenses
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        // Fetch the category document
        final categorySnapshot = await transaction.get(categoryRef);

        if (!categorySnapshot.exists) return;

        // Retrieve current totalExpenses and calculate the new total
        final currentTotal = categorySnapshot.data()?['totalExpenses'] ?? 0.0;
        final updatedTotalExpenses = currentTotal + expense.amount;

        // Update totalExpenses in the categories collection
        transaction.update(categoryRef, {
          'totalExpenses': updatedTotalExpenses,
        });

        // Prepare the updated category data
        final updatedCategoryMap = {
          'categoryId': categorySnapshot.data()?['categoryId'],
          'name': categorySnapshot.data()?['name'],
          'icon': categorySnapshot.data()?['icon'],
          'color': categorySnapshot.data()?['color'],
          'totalExpenses': updatedTotalExpenses, // Include the updated totalExpenses
        };

        // Add the new expense document with the updated category field
        transaction.set(
          expenseCollection.doc(expense.expenseId),
          {
            ...expense.toEntity().toDocument(), // Serialize the expense data
            'category': updatedCategoryMap,     // Override the category field
          },
        );

        // Fetch all expenses related to the category and update their category field
        final relatedExpensesSnapshot = await expenseCollection
            .where('category.categoryId', isEqualTo: expense.category.categoryId)
            .get();

        for (final doc in relatedExpensesSnapshot.docs) {
          transaction.update(doc.reference, {
            'category': updatedCategoryMap, // Update the category field with new totalExpenses
          });
        }
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Expense>> getExpenses() async {
    try {
      return await expenseCollection
        .get()
        .then((value) => value.docs.map((e) => 
          Expense.fromEntity(ExpenseEntity.fromDocument(e.data()))
        ).toList()) ;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Expense>> getExpensesByMonth(int year, int month) async {
    try {
      // Query Firestore for expenses matching the given year and month
      final snapshot = await expenseCollection
          .where('year', isEqualTo: year)
          .where('month', isEqualTo: month)
          .get();

      // Convert Firestore documents to Expense objects
      return snapshot.docs
          .map((doc) => Expense.fromEntity(
                ExpenseEntity.fromDocument(doc.data()),
              ))
          .toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
  
  @override
  Future<String> uploadReceiptPhoto(String path) async {
    try {
      // Generate a unique file name for the photo
      String fileName = 'receipts/${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Get a reference to the Firebase Storage location
      final receiptRef = storageRef.child(fileName);

      // Upload the file to Firebase Storage
      final uploadTask = receiptRef.putFile(File(path));

      // Wait for the upload to complete
      final snapshot = await uploadTask;

      // Get the download URL of the uploaded file
      final downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  
}