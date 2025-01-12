import 'dart:math';

import 'package:budget_buddy/screens/add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:budget_buddy/screens/add_expense/blocs/get_categories_bloc/get_categories_bloc.dart';
import 'package:budget_buddy/screens/add_expense/views/category_creation.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:budget_buddy/screens/add_expense/views/category_constants.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController receiptPhotoController = TextEditingController();

  bool isExpanded = false;

  final ScrollController _scrollController = ScrollController();

  late Expense expense;

  bool isLoading = false;

  bool isReceiptUploaded = false;

  bool isFormValid = false;
  void validateForm() {
    setState(() {
      isFormValid = expenseController.text.isNotEmpty &&
          categoryController.text.isNotEmpty &&
          detailsController.text.isNotEmpty &&
          dateController.text.isNotEmpty;
    });
  }


  @override
  void dispose() {
    // Dispose of the ScrollController to free up resources
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    expense = Expense.empty;
    expense.expenseId = const Uuid().v1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateExpenseBloc, CreateExpenseState>(
      listener: (context, state) {
        if (state is CreateExpenseSuccess) {
          Get.snackbar(
            "Success",
            "Added expense!",
            titleText: Text(
              "Success",
              style: TextStyle(
                color:  Colors.green.shade900,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: Text(
              "Added expense!",
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
            padding: const EdgeInsets.all(10.0),
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
            maxWidth: 300.0,
          );

          Navigator.pop(context, expense);
        } else if (state is CreateExpenseLoading) {
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
        } else if(state is CreateExpenseFailure) {
          Get.snackbar(
            "Error",
            "Could not add expense!",
            titleText: Text(
              "Error",
              style: TextStyle(
                color:  Colors.red.shade900,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: Text(
              "Could not add expense!",
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
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold( 
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            elevation: 0,
            title: Text(
              "Transaction",
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
          body: SingleChildScrollView(
            child: BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
              builder: (context, state) {
                if (state is GetCategoriesSuccess) {
                  return Padding(
                    padding: const EdgeInsets.all(26.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Add Expense",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 123, 123, 123),
                          ),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45),
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: TextFormField(
                              controller: expenseController,
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
                                      color:
                                          Theme.of(context).colorScheme.outline,
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
                              onChanged: (_) => validateForm(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        Center(
                          child: Column(
                            children: [
                              TextFormField(
                                controller: categoryController,
                                textAlignVertical: TextAlignVertical.center,
                                readOnly: true,
                                onTap: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                    validateForm(); 
                                  });
                                },
                                decoration: InputDecoration(
                                    constraints: const BoxConstraints(
                                      maxWidth: 360,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(SFSymbols.list_dash,
                                        color: Color.fromARGB(255, 72, 72, 72)),
                                    suffixIcon: IconButton(
                                        onPressed: () async {
                                          final getCategoriesBloc = context.read<GetCategoriesBloc>();
            
                                          await getCategoryCreation(context);
            
                                          // Use the stored reference
                                          getCategoriesBloc.add(GetCategories());
                                        },
                                        icon: const Icon(SFSymbols.plus_app,
                                            color: Color.fromARGB(
                                                255, 156, 156, 156))),
                                    hintText: 'Category',
                                    hintStyle: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline),
                                    border: OutlineInputBorder(
                                        borderRadius: isExpanded
                                            ? const BorderRadius.vertical(
                                                top: Radius.circular(10),
                                              )
                                            : BorderRadius.circular(10),
                                        borderSide: BorderSide.none)),
                                onChanged: (_) => validateForm(),
                              ),
                            ],
                          ),
                        ),
                        isExpanded
                            ? Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 360,
                                ),
                                height: 145,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Scrollbar(
                                    controller: _scrollController,
                                    thumbVisibility: true,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 12),
                                      child: ListView.builder(
                                        controller: _scrollController,
                                        itemCount: state.categories.length,
                                        itemBuilder: (context, int i) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                expense.category =
                                                    state.categories[i];
                                                categoryController.text =
                                                    expense.category.name;
                                              });
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  side: BorderSide(
                                                      width: 2,
                                                      color: expense.category ==
                                                              state.categories[i]
                                                          ? Colors.black
                                                          : Colors
                                                              .grey.shade100)),
                                              child: ListTile(
                                                leading: Icon(iconMap[state.categories[i].icon] ?? SFSymbols.question,
                                                    color: Colors.white,
                                                    size: 28),
                                                title: Text(
                                                  state.categories[i].name,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                tileColor: Color(
                                                    state.categories[i].color),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
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
                        const SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: TextFormField(
                            controller: detailsController,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                constraints: const BoxConstraints(
                                  maxWidth: 360,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: const Icon(SFSymbols.pencil,
                                    color: Color.fromARGB(255, 72, 72, 72)),
                                hintText: 'Transaction Details',
                                hintStyle: TextStyle(
                                    color: Theme.of(context).colorScheme.outline),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none)),
                            onChanged: (_) => validateForm(),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: TextFormField(
                            controller: dateController,
                            textAlignVertical: TextAlignVertical.center,
                            readOnly: true,
                            onTap: () async {
                              DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: expense.date,
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
                                  expense.date = newDate;
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
                            onChanged: (_) => validateForm(),
                          ),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: kToolbarHeight,
                          child: TextButton.icon(
                            onPressed: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickImage(
                                source: ImageSource.gallery,
                                imageQuality: 80
                              );
            
                              if (image != null && mounted) {
                                CroppedFile? croppedFile = await ImageCropper().cropImage(
                                  sourcePath: image.path,
                                  aspectRatio: const CropAspectRatio(
                                    ratioX: 4, 
                                    ratioY: 5
                                  ),
                                  uiSettings: [
                                    AndroidUiSettings(
                                      toolbarTitle: 'Crop Image',
                                      toolbarColor: Colors.grey,
                                      toolbarWidgetColor: Colors.white,
                                      initAspectRatio: CropAspectRatioPreset.original,
                                      lockAspectRatio: false
                                    ),
                                    IOSUiSettings(
                                      title: 'Crop Image',
                                    )
                                  ],
                                );
            
                                if (croppedFile != null && mounted) {
                                  setState(() {
                                    isLoading = true;
                                  });
            
                                  try {
                                    final receiptPhotoUrl = await context
                                        .read<ExpenseRepository>()
                                        .uploadReceiptPhoto(croppedFile.path);
            
                                    if (receiptPhotoUrl.isNotEmpty && mounted) {
                                      setState(() {
                                        isReceiptUploaded = true;
                                        receiptPhotoController.text = receiptPhotoUrl; 
                                      });
                                    }
            
                                  } catch (e) {
                                    if (mounted) {
                                        Get.snackbar(
                                        "Error",
                                        "Failed to upload receipt!",
                                        titleText: Text(
                                          "Error",
                                          style: TextStyle(
                                            color:  Colors.red.shade900,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        messageText: Text(
                                          "Failed to upload receipt!",
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
                                  } finally {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                  
                                }
                              }
            
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            icon: Icon(
                              isReceiptUploaded ? SFSymbols.checkmark : SFSymbols.camera,
                              color: isReceiptUploaded
                              ? Colors.green
                              : const Color.fromARGB(255, 72, 72, 72),
                            ),
                            label: Text(
                              isReceiptUploaded ? 'Uploaded' :
                              'Upload Receipt',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 2.5,
                                spreadRadius: 0.5,
                                color: Color.fromARGB(255, 137, 131, 131),
                                offset: Offset(2, 2),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: kToolbarHeight,
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
                              child: isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : TextButton(
                                      onPressed: isFormValid
                                      ? () async {
                                        setState(() {
                                          isLoading = true;
                                        });
            
                                        try {
                                          expense.amount = double.parse(expenseController.text);
                                          expense.details = detailsController.text;
                                          expense.receiptPhoto = receiptPhotoController.text;
            
                                          context.read<CreateExpenseBloc>().add(CreateExpense(expense));
                                        } catch (e) {
                                            Get.snackbar(
                                              "Error",
                                              "Failed to prepare the expense!",
                                              titleText: Text(
                                                "Error",
                                                style: TextStyle(
                                                  color:  Colors.red.shade900,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              messageText: Text(
                                                "Failed to prepare the expense!",
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
                                        } finally {
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                      }
                                      :null,
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: const Text(
                                        'Save',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
