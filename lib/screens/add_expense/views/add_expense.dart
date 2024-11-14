import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:intl/intl.dart';

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
  DateTime selectDate = DateTime.now();

  List<String> myCategoriesIcons = [
    'airplane', 'archivebox.fill', 'bag.fill', 'bed.double.fill', 'bicycle', 'bolt.fill', 'book.closed.fill', 'book.fill', 'briefcase.fill', 'car.fill', 'cart', 'chart.pie', 'creditcard.fill', 'cross.case.fill', 'cup.and.saucer.fill', 'drop.fill', 'duffle.bag.fill', 'exclamationmark.triangle.fill', 'eyebrow', 'figure.dance', 'figure.gymnastics', 'figure.run', 'figure.stand', 'figure.walk', 'film', 'flame.fill', 'fork.knife', 'gamecontroller.fill', 'gift.fill', 'graduationcap.fill', 'hand.tap', 'heart.fill', 'house.fill', 'lamp.desk.fill', 'leaf.fill', 'lock.fill', 'macbook', 'music.note.list', 'p.circle.fill', 'paintbrush.pointed.fill', 'pawprint.fill', 'pencil.and.outline', 'phone.fill', 'play.fill', 'play.tv', 'popcorn', 'scissors', 'shield.fill', 'sparkles', 'stethoscope', 'text.document', 'ticket.fill', 'tram.fill', 'tshirt.fill', 'tv.fill', 'washer.fill', 'wrench.and.screwdriver.fill'
  ];

  @override
  void initState() {
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
        body: Padding(
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
                  // boxShadow: const [
                  //   BoxShadow(
                  //     blurRadius: 1,
                  //     spreadRadius: 0.2,
                  //     color: Color.fromARGB(255, 137, 131, 131),
                  //     offset: Offset(1, 1),
                  //   ),
                  // ],
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
                          // Theme.of(context).colorScheme.primary,
                          // Theme.of(context).colorScheme.secondary,
                          // Theme.of(context).colorScheme.tertiary
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
                      hintText: '0,00',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              Center(
                child: TextFormField(
                  controller: categoryController,
                  textAlignVertical: TextAlignVertical.center,
                  readOnly: true,
                  onTap: () {
                    
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
                        onPressed: () {
                          showDialog(
                            context: context, 
                            builder: (ctx) {
                              bool isExpanded = false;
                              String iconSelected = '';
                              Color categoryColor = Colors.white;

                              return StatefulBuilder(
                                builder: (context, setState) {
                                return AlertDialog(
                                  title: const Text(
                                        'Create New Category',
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
                                        TextFormField(
                                          //controller: dateController,
                                          textAlignVertical: TextAlignVertical.center,
                                          decoration: InputDecoration(
                                              constraints: const BoxConstraints(
                                                maxWidth: 360,
                                              ),
                                              isDense: true,
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: 'Name',
                                              hintStyle: TextStyle(
                                                  color: Theme.of(context).colorScheme.outline),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                  borderSide: BorderSide.none)),
                                        ),
                                        const SizedBox(height: 25,),
                                        TextFormField(
                                          //controller: dateController,
                                          onTap: () {
                                            setState(() {
                                              isExpanded = !isExpanded;
                                            });
                                          },
                                          textAlignVertical: TextAlignVertical.center,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                              constraints: const BoxConstraints(
                                                maxWidth: 360,
                                              ),
                                              isDense: true,
                                              filled: true,
                                              suffixIcon: const Icon(SFSymbols.chevron_down, color: Color.fromARGB(255, 156, 156, 156)),
                                              fillColor: Colors.white,
                                              hintText: 'Icon',
                                              hintStyle: TextStyle(
                                                  color: Theme.of(context).colorScheme.outline),
                                              border: OutlineInputBorder(
                                                  borderRadius: isExpanded
                                                  ? const BorderRadius.vertical(
                                                    top: Radius.circular(10)
                                                  )
                                                  : BorderRadius.circular(10),
                                                  borderSide: BorderSide.none)),
                                        ),
                                        isExpanded
                                          ? Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: 200,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.vertical(
                                                bottom: Radius.circular(10)
                                              )
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Scrollbar(
                                                thumbVisibility: true,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 12),
                                                  child: GridView.builder(
                                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 4,
                                                      mainAxisSpacing: 5,
                                                      crossAxisSpacing: 5
                                                    ),
                                                    itemCount: myCategoriesIcons.length,
                                                    itemBuilder: (context, int i) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            iconSelected = myCategoriesIcons[i];
                                                          },);
                                                        },
                                                        child: Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                              width: 2,
                                                              color: iconSelected == myCategoriesIcons[i]
                                                              ? Colors.green
                                                              : Colors.grey.shade300
                                                            ),
                                                            borderRadius: BorderRadius.circular(10),
                                                            image: DecorationImage(
                                                              image: AssetImage(
                                                                'assets/${myCategoriesIcons[i]}.png'
                                                              )
                                                            )
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                        const SizedBox(height: 25,),
                                        TextFormField(
                                          //controller: dateController,
                                          onTap: () {
                                            showDialog(
                                              context: context, 
                                              builder: (ctx2) {
                                                return AlertDialog(
                                                  content: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      ColorPicker(
                                                        pickerColor: Colors.white,
                                                        onColorChanged: (value) {
                                                          setState(() {
                                                            categoryColor = value;
                                                          },);
                                                        },
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
                                                          child: TextButton(
                                                            onPressed: () {
                                                              print(categoryColor);
                                                              Navigator.pop(ctx2);
                                                            },
                                                            style: TextButton.styleFrom(
                                                              padding: EdgeInsets.zero,
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(10),
                                                              ),
                                                            ),
                                                            child: const Text(
                                                              'Done',
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
                                                );
                                              }
                                            );
                                          },
                                          textAlignVertical: TextAlignVertical.center,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                              constraints: const BoxConstraints(
                                                maxWidth: 360,
                                              ),
                                              isDense: true,
                                              filled: true,
                                              fillColor: categoryColor,
                                              hintText: 'Colour',
                                              hintStyle: TextStyle(
                                                  color: Theme.of(context).colorScheme.outline),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                  borderSide: BorderSide.none)),
                                        ),
                                        const SizedBox(height: 25,),
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
                                            child: TextButton(
                                              onPressed: () {
                                                // create category object and pop!!!
                                                Navigator.pop(context);
                                              },
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: const Text(
                                                'Create',
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
                                );
                                }
                              );
                            }
                          );
                        } ,
                        icon: const Icon(SFSymbols.plus_app,
                        color: Color.fromARGB(255, 156, 156, 156))
                      ),
                      hintText: 'Category',
                      hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.outline),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none)),
                ),
              ),
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
                      initialDate: selectDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100), //DateTime.now().add(const Duration(days: 365)));
                      helpText: 'Select A Date',
                      cancelText: 'Cancel',
                      confirmText: 'Done',
                    );
                    if (newDate != null) {
                      setState(() {
                        dateController.text = DateFormat('dd/MM/yyyy').format(newDate);
                        selectDate = newDate;
                      });
                    }
                  },
                  decoration: InputDecoration(
                      constraints: const BoxConstraints(
                        maxWidth: 360,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(SFSymbols.calendar_badge_plus,
                          color: Color.fromARGB(255, 72, 72, 72)),
                      hintText: 'Date',
                      hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.outline),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none)),
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: kToolbarHeight,
                child: TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(
                    SFSymbols.camera,
                    color: Color.fromARGB(255, 72, 72, 72),
                  ),
                  label: Text(
                    'Upload Receipt',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 115,
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
                    child: TextButton(
                      onPressed: () {},
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
        ),
      ),
    );
  }
}
