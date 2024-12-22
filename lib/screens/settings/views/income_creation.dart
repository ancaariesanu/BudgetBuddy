import 'dart:math';
import 'package:budget_buddy/screens/settings/blocs/create_income_bloc/create_income_bloc.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

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
                      "Success",
                      "Added income!",
                      titleText: Text(
                        "Success",
                        style: TextStyle(
                          color:  Colors.green.shade900,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      messageText: Text(
                        "Added income!",
                        style: TextStyle(
                          color: Colors.green.shade900,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      colorText: Colors.green.shade900,
                      duration: const Duration(seconds: 10),
                      instantInit: true,
                      snackPosition: SnackPosition.TOP,
                      icon: Icon(SFSymbols.checkmark, color:  Colors.green.shade900, size: 35.0),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10.0),
                      borderRadius: 8,
                      borderColor: Colors.green.shade600,
                      borderWidth: 0.9,
                      backgroundColor: Colors.green.shade50,
                      isDismissible: true,
                      mainButton: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Icon(SFSymbols.xmark, color: Colors.grey.shade600, size: 20,),
                      ),
                      snackStyle: SnackStyle.FLOATING,
                      forwardAnimationCurve: Curves.easeOutBack,
                      reverseAnimationCurve: Curves.easeInBack,
                      animationDuration: const Duration(milliseconds: 800),
                      maxWidth: 350.0,
                    );

                    Navigator.pop(ctx, income);
                  } else if (state is CreateIncomeLoading) {
                    setState(() {
                      Get.snackbar(
                        "Loading",
                        "Please wait!",
                        titleText: Text(
                          "Loading",
                          style: TextStyle(
                            color:  Colors.blue.shade900,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        messageText: Text(
                          "Please wait!",
                          style: TextStyle(
                            color: Colors.blue.shade900,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        colorText: Colors.blue.shade900,
                        duration: const Duration(seconds: 1),
                        instantInit: true,
                        snackPosition: SnackPosition.TOP,
                        icon: Icon(SFSymbols.hourglass, color:  Colors.blue.shade900, size: 35.0),
                        padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.all(10.0),
                        borderRadius: 8,
                        borderColor: Colors.blue.shade600,
                        borderWidth: 0.9,
                        backgroundColor: Colors.blue.shade50,
                        isDismissible: true,
                        mainButton: TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Icon(SFSymbols.xmark, color: Colors.grey.shade600, size: 20,),
                        ),
                        snackStyle: SnackStyle.FLOATING,
                        forwardAnimationCurve: Curves.easeOutBack,
                        reverseAnimationCurve: Curves.easeInBack,
                        animationDuration: const Duration(milliseconds: 800),
                        maxWidth: 300.0,
                      );
                      isLoading = true;
                    });
                  } else if(state is CreateIncomeFailure) {
                    Get.snackbar(
                      "Error",
                      "Could not add income!",
                      titleText: Text(
                        "Error",
                        style: TextStyle(
                          color:  Colors.red.shade900,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      messageText: Text(
                        "Could not add income!",
                        style: TextStyle(
                          color: Colors.red.shade900,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      colorText: Colors.red.shade900,
                      duration: const Duration(seconds: 100),
                      instantInit: true,
                      snackPosition: SnackPosition.TOP,
                      icon: Icon(SFSymbols.xmark, color:  Colors.red.shade900, size: 35.0),
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.all(10.0),
                      borderRadius: 8,
                      borderColor: Colors.red.shade600,
                      borderWidth: 0.9,
                      backgroundColor: Colors.red.shade50,
                      isDismissible: true,
                      mainButton: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Icon(SFSymbols.xmark, color: Colors.grey.shade600, size: 20,),
                      ),
                      snackStyle: SnackStyle.FLOATING,
                      forwardAnimationCurve: Curves.easeOutBack,
                      reverseAnimationCurve: Curves.easeInBack,
                      animationDuration: const Duration(milliseconds: 800),
                      maxWidth: 300.0,
                    );
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
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$')),
                              ],
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
