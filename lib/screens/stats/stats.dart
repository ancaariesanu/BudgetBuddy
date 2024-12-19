import 'package:budget_buddy/screens/home/blocs/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:budget_buddy/screens/stats/chart.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class StatScreen extends StatefulWidget {
  final List<Expense> expenses;

  const StatScreen({required this.expenses, super.key});

  @override
  _StatScreenState createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  int _selectedYear = DateTime.now().year; // Default to current year
  List<int> _availableYears = []; // List of available years for dropdown
  bool isExpanded = false; // Toggle for expanding year list
  final TextEditingController yearController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeAvailableYears();
    yearController.text = 'Select Year'; // Default hint text
  }

  @override
  void dispose() {
    yearController.dispose();
    super.dispose();
  }

  void _initializeAvailableYears() {
    // Extract unique years from the provided expenses
    _availableYears = widget.expenses
        .map((expense) => expense.date.year)
        .toSet()
        .toList()
      ..sort(); // Ensure the years are sorted

    if (_availableYears.isNotEmpty && !_availableYears.contains(_selectedYear)) {
      _selectedYear = _availableYears.first; // Default to the first available year
    }

    if (_availableYears.contains(_selectedYear)) {
      yearController.text = _selectedYear.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Monthly Spending Insights',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 25),

              Center(
                child: Column(
                  children: [
                    TextFormField(
                      controller: yearController,
                      readOnly: true,
                      textAlignVertical: TextAlignVertical.center,
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded; // Toggle expand/collapse
                        });
                      },
                      decoration: InputDecoration(
                        // constraints: const BoxConstraints(
                        //   maxWidth: 360,
                        // ),
                        filled: true,
                        isDense: true,
                        fillColor: Colors.white,
                        suffixIcon: Icon(
                          isExpanded
                              ? SFSymbols.chevron_up
                              : SFSymbols.chevron_down,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        hintText: 'Select Year',
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: isExpanded
                              ? const BorderRadius.vertical(
                                  top: Radius.circular(10),
                                )
                              : BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    isExpanded
                      ? Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Scrollbar(
                              thumbVisibility: true,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: ListView.builder(
                                  itemCount: _availableYears.length,
                                  itemBuilder: (context, index) {
                                    final year = _availableYears[index];
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedYear = year;
                                          yearController.text = year.toString();
                                          isExpanded = false; // Collapse the list
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 16),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: index == _availableYears.length - 1
                                                  ? Colors.transparent
                                                  : Colors.grey.shade300,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          year.toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: _selectedYear == year
                                                ? Theme.of(context).colorScheme.secondary
                                                : Colors.black,
                                            fontWeight: _selectedYear == year
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                      )
                      : Container(),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 25, 0, 15),
                  child: BlocBuilder<GetExpensesBloc, GetExpensesState>(
                    builder: (context, state) {
                      if (state is GetExpensesLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is GetExpensesSuccess) {
                        // Filter expenses by the selected year
                        final filteredExpenses = state.expenses
                            .where((expense) => expense.date.year == _selectedYear)
                            .toList();
                        return MyChart(data: filteredExpenses, year: _selectedYear);
                      } else if (state is GetExpensesFailure) {
                        return const Center(child: Text('Error loading data.'));
                      } else {
                        return const Center(child: Text('No data available.'));
                      }
                    }
                  ),
                  //child: MyChart(),
                ),
              )
            ],
          ),
        ),
      );
    
  }
}











