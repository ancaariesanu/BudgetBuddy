import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:budget_buddy/screens/add_expense/views/category_constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ViewAllExpenses extends StatefulWidget {
  final List<Expense> expenses;

  const ViewAllExpenses(this.expenses, {super.key});

  @override
  _ViewAllExpensesState createState() => _ViewAllExpensesState();
}

class _ViewAllExpensesState extends State<ViewAllExpenses> {
  late List<bool> isExpandedList;
  final numberFormat = NumberFormat.currency(locale: 'en_US', symbol: '');

  @override
  void initState() {
    super.initState();
    isExpandedList = List.filled(widget.expenses.length, false);
  }

  @override
  void didUpdateWidget(covariant ViewAllExpenses oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expenses.length != isExpandedList.length) {
      isExpandedList = List.filled(widget.expenses.length, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final allExpenses = widget.expenses.toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    if (isExpandedList.length != allExpenses.length) {
      isExpandedList = List.filled(allExpenses.length, false);
    }

    final Map<String, double> dailyTotals = {};
    for (final exp in allExpenses) {
      final dateKey = DateFormat('dd/MM/yyyy').format(exp.date);
      dailyTotals[dateKey] = (dailyTotals[dateKey] ?? 0) + exp.amount;
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), 
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          title: Text(
            'All Your Expenses',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(26),
          itemCount: allExpenses.length,
          itemBuilder: (context, index) {
            final expense = allExpenses[index];
            final expanded = isExpandedList[index];
            final currDate = expense.date;
            final prevDate = index > 0 ? allExpenses[index - 1].date : null;
            final showDateHeader = (index == 0) ||
                (prevDate != null && !isSameDay(currDate, prevDate));

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showDateHeader)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDateHeader(currDate),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..shader = const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 77, 182, 172),
                                  Color.fromARGB(255, 107, 159, 249),
                                  Color.fromARGB(255, 102, 187, 106),
                                  Color.fromARGB(255, 38, 166, 154),
                                ],
                                transform: GradientRotation(pi / 90),
                              ).createShader(
                                const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                              ),
                          ),
                        ),

                        Text(
                           '- ${numberFormat.format(dailyTotals[DateFormat('dd/MM/yyyy').format(currDate)] ?? 0)} RON',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                  ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpandedList[index] = !expanded;
                    });
                  },
                  child: _buildExpenseCard(expense, expanded),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  bool isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  String _formatDateHeader(DateTime date) {
    final todayString = DateFormat('dd/MM/yyyy').format(DateTime.now());
    final expenseString = DateFormat('dd/MM/yyyy').format(date);
    return (todayString == expenseString) ? 'Today' : expenseString;
  }

  Widget _buildExpenseCard(Expense expense, bool expanded) {
    final category = expense.category;

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: const Color.fromARGB(100, 137, 131, 131),
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Color(category.color),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Icon(
                          iconMap[category.icon] ?? SFSymbols.question,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Text(
                      expense.details,
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '- ${numberFormat.format(expense.amount)} RON',
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy').format(expense.date),
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.outline,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (expanded) ...[
              Container(
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: const Color.fromARGB(100, 137, 131, 131),
                    width: 0.5,
                  ),
                ),
                child: (expense.receiptPhoto != null &&
                        expense.receiptPhoto!.isNotEmpty &&
                        expense.receiptPhoto!.isURL)
                    ? AspectRatio(
                        aspectRatio: 4 / 5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: InteractiveViewer(
                            clipBehavior: Clip.hardEdge,
                            minScale: 1.0,
                            maxScale: 4.0,
                            child: Image.network(
                              expense.receiptPhoto!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : AspectRatio(
                        aspectRatio: 4 / 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Center(
                            child: Text(
                              'No receipt image available.',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
