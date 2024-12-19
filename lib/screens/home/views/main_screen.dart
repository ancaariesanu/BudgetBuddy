import 'package:budget_buddy/screens/discounts/views/discounts.dart';
import 'package:budget_buddy/screens/settings/views/settings.dart';
import 'package:budget_buddy/screens/view_all_expenses/view_all_expenses.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:budget_buddy/screens/add_expense/views/category_constants.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatelessWidget {
  final List<Expense> expenses;
  final List<Income> incomes;
  
  const MainScreen(this.expenses, this.incomes, {super.key});

  @override
  Widget build(BuildContext context) {

    // Group expenses by categories and calculate totals
    final Map<String, Map<String, dynamic>> groupedCategories = {};

    for (var expense in expenses) {
      final categoryName = expense.category.name;
      if (!groupedCategories.containsKey(categoryName)) {
        groupedCategories[categoryName] = {
          'total': 0.0,
          'latestDate': expense.date,
          'color': expense.category.color,
          'icon': expense.category.icon,
        };
      }

      groupedCategories[categoryName]!['total'] += expense.amount;
      if (expense.date.isAfter(groupedCategories[categoryName]!['latestDate'])) {
        groupedCategories[categoryName]!['latestDate'] = expense.date;
      }
    }

    // Calculate total expenses
    final totalExpenses = expenses.fold<double>(
      0.0,
      (sum, expense) => sum + expense.amount,
    );

    // Calculate total incomes
    final totalIncomes = incomes.fold<double>(
      0.0,
      (sum, expense) => sum + expense.amount,
    );

    // Convert map to a sorted list based on latestDate
    final sortedCategories = groupedCategories.entries.toList()
      ..sort((a, b) => b.value['latestDate'].compareTo(a.value['latestDate']));

    // Sort incomes by date to get the latest income
    final latestIncome = incomes.isNotEmpty
      ? incomes.reduce((a, b) => a.date.isAfter(b.date) ? a : b)
      : null;

    final latestIncomeAmount = latestIncome?.amount ?? 0.0;

    final numberFormat = NumberFormat.currency(locale: 'en_US', symbol: '');
    
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
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
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[400]),
                        ),
                        const Icon(
                          SFSymbols.person_fill,
                          size: 30,
                          color: Colors.black,
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome back!",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.outline),
                        ),
                        Text(
                          "Robert Negre",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const Discounts(),
                          ),
                        );
                      },
                      icon: const Icon(SFSymbols.gift_fill, size: 30),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                //Settings(incomes: incomes),
                                const Settings(),
                          ),
                        );
                      },
                      icon: const Icon(SFSymbols.gear_alt_fill, size: 30),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.tertiary
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 2.5,
                        spreadRadius: 0.5,
                        color: Color.fromARGB(255, 137, 131, 131),
                        offset: Offset(2, 2))
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Total Balance",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    //"RON  ${totalIncomes.toStringAsFixed(2)}",
                    "RON  ${numberFormat.format(totalIncomes)}",
                    style: const TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              child: const Center(
                                  child: Icon(
                                SFSymbols.arrow_down_circle,
                                size: 35,
                                color: Color.fromARGB(255, 11, 131, 15),
                              )),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Last Income",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  //"60.000,0",
                                  numberFormat.format(latestIncomeAmount),
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              child: const Center(
                                  child: Icon(
                                SFSymbols.arrow_up_circle,
                                size: 35,
                                color: Color.fromARGB(255, 140, 18, 10),
                              )),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "All Expenses",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  //totalExpenses.toStringAsFixed(2),
                                  numberFormat.format(totalExpenses),
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Your Categories",
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w700),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            ViewAllExpenses(expenses),
                      ),
                    );
                  },
                  child: Text(
                    "View All Transactions",
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.outline,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: sortedCategories.length,
                  itemBuilder: (context, int i) {
                    final category = sortedCategories[i];
                    final categoryName = category.key;
                    final totalAmount = category.value['total'];
                    final lastUpdatedDate = category.value['latestDate'];
                    final isToday = DateTime.now().difference(lastUpdatedDate).inDays == 0;

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
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Color(
                                                category.value['color']),
                                            shape: BoxShape.circle),
                                      ),
                                      Icon(
                                        iconMap[category.value['icon']] ??
                                            SFSymbols.question,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    categoryName,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    //"- ${totalAmount.toStringAsFixed(2)} RON",
                                    "- ${numberFormat.format(totalAmount)} RON",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    isToday ? "Today" :
                                    DateFormat('dd/MM/yyyy').format(lastUpdatedDate),
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}