import 'dart:math';

import 'package:budget_buddy/screens/add_expense/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:budget_buddy/screens/settings/blocs/create_income_bloc/create_income_bloc.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:budget_buddy/screens/add_expense/views/category_constants.dart';

Future getIncomeCreation(BuildContext context) {
  
  return showDialog(
      context: context,
      builder: (ctx) {
        bool isLoading = false;

        TextEditingController incomeAmountController = TextEditingController();
        TextEditingController incomeDetailsController = TextEditingController();
        TextEditingController dateController = TextEditingController();
        
        Income income = Income.empty;

        return BlocProvider.value(
          value: context.read<CreateIncomeBloc>(),
          child: StatefulBuilder(
            builder: (ctx, setState) {
              return BlocListener<CreateIncomeBloc, CreateIncomeState>(
                listener: (context, state) {
                  if (state is CreateIncomeSuccess) {
                    Get.snackbar(
                      "SUCCESS",
                      "Category created successfully!",
                      titleText: const Text(
                        "SUCCESS",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      messageText: const Text(
                        "Income added successfully!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      colorText: Colors.white,
                      duration: const Duration(seconds: 8),
                      //instantInit: true,
                      snackPosition: SnackPosition.TOP,
                      icon: const Icon(SFSymbols.checkmark_square_fill, color: Colors.white, size: 35.0),
                      padding: const EdgeInsets.all(20.0),
                      margin: const EdgeInsets.all(10.0),
                      borderRadius: 25,
                      borderColor: Colors.grey.shade700,
                      borderWidth: 2.0,
                      backgroundColor: Colors.green.shade700,
                      isDismissible: true,
                      //showProgressIndicator: true,
                      snackStyle: SnackStyle.FLOATING,
                      forwardAnimationCurve: Curves.easeOutBack,
                      reverseAnimationCurve: Curves.easeInBack,
                      animationDuration: const Duration(milliseconds: 800),
                      backgroundGradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                          Theme.of(context).colorScheme.tertiary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      maxWidth: 350.0,
                    );
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
                        ////aiciiiiiii
                        TextFormField(
                          controller: dateController,
                          textAlignVertical: TextAlignVertical.center,
                          readOnly: true,
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: income.date,
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                              helpText: 'Select A Date',
                              cancelText: 'Cancel',
                              confirmText: 'Done',
                            );
                            if (newDate != null) {
                              setState(() {
                                dateController.text =
                                    DateFormat('dd/MM/yyyy').format(newDate);
                                income.date = newDate;
                              });
                            }
                          },
                          decoration: InputDecoration(
                            constraints: const BoxConstraints(
                              maxWidth: 360,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(
                              SFSymbols.calendar_badge_plus,
                              color: Color.fromARGB(255, 72, 72, 72)),
                            hintText: 'Date',
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
