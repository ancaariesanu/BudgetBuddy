import 'package:budget_buddy/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:budget_buddy/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:budget_buddy/screens/add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:budget_buddy/screens/auth/welcome_screen.dart';
import 'package:budget_buddy/screens/home/blocs/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:budget_buddy/screens/home/views/home_screen.dart';
import 'package:budget_buddy/screens/settings/blocs/get_incomes_bloc/get_incomes_bloc.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ExpenseRepository>(
          create: (_) => FirebaseExpenseRepo(),
        ),
        Provider<IncomeRepository>(
          create: (_) => FirebaseIncomeRepo(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GetExpensesBloc(
              FirebaseExpenseRepo(),
            )..add(GetExpenses()),
          ),
          BlocProvider(
            create: (context) => GetIncomesBloc(
              FirebaseIncomeRepo(),
            )..add(GetIncomes()),
          ),
          BlocProvider(
            create: (context) => CreateExpenseBloc(
              context.read<ExpenseRepository>(),
            ),
          ),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Budget Buddy",
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
              surface: Color(0xFFF0F3F5),
              onSurface: Colors.black,
              primary: Color.fromARGB(255, 124, 208, 127),
              secondary: Color.fromARGB(255, 79, 193, 165),
              tertiary: Color.fromARGB(255, 136, 204, 213),
              outline: Colors.grey,
            ),
          ),
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if(state.status == AuthenticationStatus.authenticated) {
                return BlocProvider(
                  create: (context) => SignInBloc(
                      userRepository:
                          context.read<AuthenticationBloc>().userRepository),
                  child: const HomeScreen(),
                );
              } else {
                return const WelcomeScreen();
              }
            }
          )
          ,
        ),
      ),
    );
  }
}
