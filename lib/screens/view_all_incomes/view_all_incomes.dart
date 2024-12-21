import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:intl/intl.dart';

class ViewAllIncomes extends StatelessWidget {
  final List<Income> incomes;

  const ViewAllIncomes(this.incomes, {super.key});

  @override
  Widget build(BuildContext context) {

    final allIncomes = incomes.toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    final dailyTotals = <String, double>{};
    for (final income in allIncomes) {
      final dateKey = DateFormat('dd/MM/yyyy').format(income.date);
      dailyTotals[dateKey] = (dailyTotals[dateKey] ?? 0) + income.amount;
    }

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
            itemCount: allIncomes.length,
            itemBuilder: (context, index) {
              final income = allIncomes[index];
              final currentDate = income.date;
              final previousDate = index > 0 ? allIncomes[index - 1].date : null;
              final showDateHeader = (index == 0) ||
                  (previousDate != null && !_isSameDay(currentDate, previousDate));

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
                          _formatDateHeader(currentDate),
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

                        Text(
                           '+ ${numberFormat.format(dailyTotals[DateFormat('dd/MM/yyyy').format(currentDate)] ?? 0)} RON',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                  ),
                    Padding(
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
                    )
                ],
              );

    
            }
          ),
          
        ),
      ),
    );
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  String _formatDateHeader(DateTime date) {
    final todayString = DateFormat('dd/MM/yyyy').format(DateTime.now());
    final dateString = DateFormat('dd/MM/yyyy').format(date);
    return (todayString == dateString) ? "Today" : dateString;
  }
}

