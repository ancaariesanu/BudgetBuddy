import 'package:budget_buddy/screens/home/blocs/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:budget_buddy/screens/home/views/home_screen.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Budget Buddy",
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
            surface: Color(0xFFF0F3F5),
            onSurface: Colors.black,
            primary: Color.fromARGB(255, 124, 208, 127),
            secondary: Color.fromARGB(255, 79, 193, 165),
            tertiary: Color.fromARGB(255, 136, 204, 213),
            outline: Colors.grey),
      ),
      home: BlocProvider(
        create: (context) => GetExpensesBloc(
          FirebaseExpenseRepo()
        )..add(GetExpenses()),
        child: const HomeScreen(),
      ),
    );
  }
}
