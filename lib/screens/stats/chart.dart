import 'dart:math';
import 'package:expense_repository/expense_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyChart extends StatelessWidget {
  final List<Expense> data;
  final int year;

  const MyChart({required this.data, required this.year, super.key});

  @override
  Widget build(BuildContext context) {
    // Filter expenses for the given year
    final filteredData = data.where((expense) => expense.date.year == year).toList();

    // Aggregate expenses by month
    final Map<int, double> monthData = {};
    for (final expense in filteredData) {
      final month = expense.date.month; // Extract month (1 = Jan, 12 = Dec)
      monthData[month] = (monthData[month] ?? 0) + expense.amount;
    }

    // Determine the month with the maximum total expense
    final maxExpense = monthData.values.isEmpty
        ? 0
        : monthData.values.reduce((a, b) => a > b ? a : b);

    // Generate the bar groups dynamically
    final barGroups = _generateBarGroups(context, monthData, maxExpense.toDouble());

    return BarChart(
      BarChartData(
        barGroups: barGroups,
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 38,
              getTitlesWidget: (value, meta) => _getBottomTitles(value, meta),
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 38,
              getTitlesWidget: (value, meta) => _getLeftTitles(value, meta),
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
      ),
    );
  }

  List<BarChartGroupData> _generateBarGroups(
      BuildContext context, Map<int, double> monthData, double maxExpense) {
    // Generate bar groups for all months (1 to 12), even if no data
    return List.generate(12, (index) {
      final month = index + 1; // Months are 1-based
      final expense = monthData[month] ?? 0;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: expense,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.tertiary,
              ],
              transform: const GradientRotation(pi / 25),
            ),
            width: 15,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: maxExpense, // Grey bar height based on the max monthly total
              color: Colors.grey.shade300,
            ),
          ),
        ],
      );
    });
  }

  Widget _getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 11,
    );

    // Map index to month numbers
    const monthNames = [
      // '1', '2', '3', '4', '5', '6',
      // '7', '8', '9', '10', '11', '12'
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    if (value.toInt() >= 0 && value.toInt() < monthNames.length) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 16,
        child: Text(monthNames[value.toInt()], style: style),
      );
    }
    return Container();
  }

  Widget _getLeftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 11,
    );

    if (value % 10 == 0) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 0,
        child: Text('${value.toInt()}', style: style),
      );
    }
    return Container();
  }
}
