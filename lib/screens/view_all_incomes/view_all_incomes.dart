import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:budget_buddy/screens/add_expense/views/category_constants.dart';
import 'package:intl/intl.dart';

class ViewAllIncomes extends StatelessWidget {
  final List<Income> incomes;

  const ViewAllIncomes(this.incomes, {super.key});

  @override
  Widget build(BuildContext context) {

    // Group incomes by date
    final Map<String, List<Income>> groupedIncomes = {};

    for (var income in incomes) {
      final dateKey = DateFormat('dd/MM/yyyy').format(income.date);
      groupedIncomes.putIfAbsent(dateKey, () => []).add(income);
    }

    // Sort dates in descending order
    final sortedDates = groupedIncomes.keys.toList()
      ..sort((a, b) {
        final dateA = DateFormat('dd/MM/yyyy').parse(a);
        final dateB = DateFormat('dd/MM/yyyy').parse(b);
        return dateB.compareTo(dateA); // Descending order
      });

    final numberFormat = NumberFormat.currency(locale: 'en_US', symbol: '');

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          title: Text(
            "All Your Incomes",
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
        body: Padding(
          padding: const EdgeInsets.all(26.0),
          child: ListView.builder(
            itemCount: sortedDates.length,
            itemBuilder: (context, index) {
              final dateKey = sortedDates[index];
              final incomesForDate = groupedIncomes[dateKey]!;

              // Sort incomes for the current date by time in descending order
              incomesForDate.sort((a, b) => b.date.compareTo(a.date));

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      dateKey == DateFormat('dd/MM/yyyy').format(DateTime.now())
                          ? "Today"
                          : dateKey,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                        ..shader = const LinearGradient(colors: [
                          Color.fromARGB(255, 77, 182, 172),
                          Color.fromARGB(255, 107, 159, 249),
                          Color.fromARGB(255, 102, 187, 106),
                          Color.fromARGB(255, 38, 166, 154),
                        ], transform: GradientRotation(pi / 90))
                            .createShader(
                          const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                        ),
                      ),
                    ),
                  ),
                  ...incomesForDate.map((income) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                                color: const Color.fromARGB(100, 137, 131, 131),
                                width: 0.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
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
                                          color: Colors.grey.shade300,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const Icon(
                                        SFSymbols.arrow_down,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    income.details,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    //"+ ${income.amount.toStringAsFixed(2)} RON",
                                    "+ ${numberFormat.format(income.amount)} RON",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    DateFormat('dd/MM/yyyy').format(income.date),
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              );

    
            }
          ),
          
        ),
      ),
    );
  }
}

