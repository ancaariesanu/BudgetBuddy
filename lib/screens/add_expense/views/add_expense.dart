import 'dart:math';

import 'package:budget_buddy/screens/add_expense/blocs/get_categories_bloc/get_categories_bloc.dart';
import 'package:budget_buddy/screens/add_expense/views/category_creation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  bool isExpanded = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    // Dispose of the ScrollController to free up resources
    _scrollController.dispose();
    super.dispose();
  }

  List<String> myCategoriesIcons = [
    'airplane',
    'archivebox.fill',
    'bag.fill',
    'bed.double.fill',
    'bolt.fill',
    'book.fill',
    'briefcase.fill',
    'car.fill',
    'cart',
    'chart.pie',
    'creditcard.fill',
    'drop.fill',
    'exclamationmark.triangle.fill',
    'film',
    'flame.fill',
    'gamecontroller.fill',
    'gift.fill',
    'hand.tap',
    'heart.fill',
    'house.fill',
    'lock.fill',
    'macbook',
    'music.note.list',
    'paintbrush.pointed.fill',
    'phone.fill',
    'play.fill',
    'scissors',
    'shield.fill',
    'sparkles',
    'ticket.fill',
    'tram.fill',
    'tv.fill',
    'wrench.and.screwdriver.fill'
  ];

  final Map<String, IconData> iconMap = {
  'airplane': SFSymbols.airplane,
  'archivebox.fill': SFSymbols.archivebox_fill,
  'bag.fill': SFSymbols.bag_fill,
  'bed.double.fill': SFSymbols.bed_double_fill,
  'bolt.fill': SFSymbols.bolt_fill,
  'book.fill': SFSymbols.book_fill,
  'briefcase.fill': SFSymbols.briefcase_fill,
  'car.fill': SFSymbols.car_fill,
  'cart': SFSymbols.cart_fill,
  'chart.pie': SFSymbols.chart_pie_fill,
  'creditcard.fill': SFSymbols.creditcard_fill,
  'drop.fill': SFSymbols.drop_fill,
  'exclamationmark.triangle.fill': SFSymbols.exclamationmark_triangle_fill,
  'film': SFSymbols.film_fill,
  'flame.fill': SFSymbols.flame_fill,
  'gamecontroller.fill': SFSymbols.gamecontroller_fill,
  'gift.fill': SFSymbols.gift_fill,
  'hand.tap': SFSymbols.hand_draw,
  'heart.fill': SFSymbols.heart_fill,
  'house.fill': SFSymbols.house_fill,
  'lock.fill': SFSymbols.lock_fill,
  'macbook': SFSymbols.macwindow,
  'music.note.list': SFSymbols.music_note_list,
  'paintbrush.pointed.fill': SFSymbols.paintbrush_fill,
  'phone.fill': SFSymbols.phone_fill,
  'play.fill': SFSymbols.play_fill,
  'scissors': SFSymbols.scissors,
  'shield.fill': SFSymbols.shield_fill,
  'sparkles': SFSymbols.sparkles,
  'ticket.fill': SFSymbols.ticket_fill,
  'tram.fill': SFSymbols.tram_fill,
  'tv.fill': SFSymbols.tv_fill,
  'wrench.and.screwdriver.fill': SFSymbols.wrench_fill
};

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
                child: Column(
                  children: [
                    TextFormField(
                      controller: categoryController,
                      textAlignVertical: TextAlignVertical.center,
                      readOnly: true,
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
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
                              onPressed: () {
                                getCategoryCreation(context);
                              },
                              icon: const Icon(SFSymbols.plus_app,
                                  color: Color.fromARGB(255, 156, 156, 156))),
                          hintText: 'Category',
                          hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.outline),
                          border: OutlineInputBorder(
                              borderRadius: isExpanded
                                  ? const BorderRadius.vertical(
                                      top: Radius.circular(10),
                                    )
                                  : BorderRadius.circular(10),
                              borderSide: BorderSide.none)),
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
                        child: BlocBuilder<GetCategoriesBloc,
                            GetCategoriesState>(
                          builder: (context, state) {
                            if (state is GetCategoriesSuccess) {
                              return Scrollbar(
                                controller: _scrollController,
                                thumbVisibility: true,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: ListView.builder(
                                    controller: _scrollController,
                                    itemCount: state.categories.length,
                                    itemBuilder: (context, int i) {
                                      return Card(
                                        child: ListTile(
                                          leading: Icon(
                                              iconMap[myCategoriesIcons[i]] ?? SFSymbols.question,
                                              color: Colors.white,
                                              size: 28),
                                          title: Text(
                                            state.categories[i].name,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          tileColor: Color(state.categories[i].color),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      );
                                    },
                                  ),
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
                      lastDate: DateTime(
                          2100), //DateTime.now().add(const Duration(days: 365)));
                      helpText: 'Select A Date',
                      cancelText: 'Cancel',
                      confirmText: 'Done',
                    );
                    if (newDate != null) {
                      setState(() {
                        dateController.text =
                            DateFormat('dd/MM/yyyy').format(newDate);
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

