import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';

class FirebaseExpenseRepo implements ExpenseRepository{
  final categoryCollection = FirebaseFirestore.instance.collection('categories');
  final expenseCollection = FirebaseFirestore.instance.collection('expenses');

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

  // @override
  // Future<void> createExpense(Expense expense) async {
  //   try {
  //     await expenseCollection
  //       .doc(expense.expenseId)
  //       .set(expense.toEntity().toDocument());
      
  //     final categoryRef = categoryCollection.doc(expense.category.categoryId);

  //     await FirebaseFirestore.instance.runTransaction((transaction) async {
  //       final categorySnapshot = await transaction.get(categoryRef);

  //       if (!categorySnapshot.exists) return;

  //       // Retrieve current totalExpenses
  //       final currentTotal = categorySnapshot.data()?['totalExpenses'] ?? 0.0;

  //       // Update totalExpenses
  //       transaction.update(categoryRef, {
  //         'totalExpenses': currentTotal + expense.amount,
  //       });
  //     });
  //   } catch (e) {
  //     log(e.toString());
  //     rethrow;
  //   }
  // }

  // @override
  // Future<void> createExpense(Expense expense) async {
  //   try {
  //     final categoryRef = categoryCollection.doc(expense.category.categoryId);

  //     // Run a transaction to update both the category's totalExpenses and the expense's category field
  //     await FirebaseFirestore.instance.runTransaction((transaction) async {
  //       // Fetch the category document
  //       final categorySnapshot = await transaction.get(categoryRef);

  //       if (!categorySnapshot.exists) return;

  //       // Retrieve current totalExpenses and calculate the new total
  //       final currentTotal = categorySnapshot.data()?['totalExpenses'] ?? 0.0;
  //       final updatedTotalExpenses = currentTotal + expense.amount;

  //       // Update totalExpenses in the categories collection
  //       transaction.update(categoryRef, {
  //         'totalExpenses': updatedTotalExpenses,
  //       });

  //       // Prepare the updated category field for the expense document
  //       final updatedCategoryMap = {
  //         'categoryId': categorySnapshot.data()?['categoryId'],
  //         'name': categorySnapshot.data()?['name'],
  //         'icon': categorySnapshot.data()?['icon'],
  //         'color': categorySnapshot.data()?['color'],
  //         'totalExpenses': updatedTotalExpenses, // Include the updated totalExpenses
  //       };

  //       // Add the expense document with the updated category field
  //       transaction.set(
  //         expenseCollection.doc(expense.expenseId),
  //         {
  //           ...expense.toEntity().toDocument(), // Use existing serialization
  //           'category': updatedCategoryMap,     // Override the category field
  //         },
  //       );
  //     });
  //   } catch (e) {
  //     log(e.toString());
  //     rethrow;
  //   }
  // }

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
  
}