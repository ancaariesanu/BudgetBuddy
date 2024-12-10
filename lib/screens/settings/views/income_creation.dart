import 'dart:math';

import 'package:budget_buddy/screens/add_expense/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:budget_buddy/screens/settings/blocs/create_income_bloc/create_income_bloc.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:uuid/uuid.dart';
import 'package:budget_buddy/screens/add_expense/views/category_constants.dart';

Future getIncomeCreation(BuildContext context) {
  
  return showDialog(
      context: context,
      builder: (ctx) {
        bool isLoading = false;

        TextEditingController incomeAmountController = TextEditingController();
        TextEditingController incomeDetailsController = TextEditingController();
        
        Income income = Income.empty;

        return BlocProvider.value(
          value: context.read<CreateIncomeBloc>(),
          child: StatefulBuilder(
            builder: (ctx, setState) {
              return BlocListener<CreateIncomeBloc, CreateIncomeState>(
                listener: (context, state) {
                  if (state is CreateIncomeSuccess) {
                    Navigator.pop(ctx, income);
                  } else if (state is CreateIncomeLoading) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                },
                child: AlertDialog(
                  title: const Text(
                    'Set An Income',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45),
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: TextFormField(
                              controller: incomeAmountController,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 38,
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
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, top: 12, right: 12, bottom: 12),
                                  child: Text(
                                    'RON ',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Theme.of(context).colorScheme.outline,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 12.0),
                                hintText: '0.00',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(45),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: incomeDetailsController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              constraints: const BoxConstraints(
                                maxWidth: 360,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: const Icon(SFSymbols.pencil,
                                  color: Color.fromARGB(255, 72, 72, 72)),
                              hintText: 'Income Details',
                              hintStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.outline),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none)),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).colorScheme.primary,
                                  Theme.of(context).colorScheme.secondary,
                                  Theme.of(context).colorScheme.tertiary,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: isLoading == true
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : TextButton(
                                    onPressed: () {
                                      setState(() {
                                        income.incomeId = const Uuid().v1();
                                        income.details =
                                            incomeDetailsController.text;
                                        income.amount =
                                            double.parse(incomeAmountController.text);
                                      });
                                      context
                                          .read<CreateIncomeBloc>()
                                          .add(CreateIncome(income));
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text(
                                      'Add',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      });
}
