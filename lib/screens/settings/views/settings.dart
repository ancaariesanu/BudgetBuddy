// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

// class Settings extends StatelessWidget {
//   const Settings({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         backgroundColor: Theme.of(context).colorScheme.surface,
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).colorScheme.surface,
//           elevation: 0,
//           title: Text(
//             "Settings",
//             style: TextStyle(
//               color: Theme.of(context).colorScheme.onSurface,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           centerTitle: true,
//           iconTheme: IconThemeData(
//             color: Theme.of(context).colorScheme.onSurface,
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(26.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Text(
//                 "Add Income",
//                 style: TextStyle(
//                   fontSize: 26,
//                   fontWeight: FontWeight.w700,
//                   color: Color.fromARGB(255, 123, 123, 123),
//                 ),
//               ),
//               const SizedBox(
//                 height: 45,
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(45),
//                 ),
//                 child: SizedBox(
//                   width: MediaQuery.of(context).size.width * 0.6,
//                   child: TextFormField(
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 38,
//                       foreground: Paint()
//                         ..shader = const LinearGradient(colors: [
//                           Color.fromARGB(255, 77, 182, 172),
//                           Color.fromARGB(255, 107, 159, 249),
//                           Color.fromARGB(255, 102, 187, 106),
//                           Color.fromARGB(255, 38, 166, 154),
//                         ], transform: GradientRotation(pi / 90))
//                             .createShader(
//                           const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
//                         ),
//                     ),
//                     textAlign: TextAlign.center,
//                     textAlignVertical: TextAlignVertical.center,
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.white,
//                       prefixIcon: Padding(
//                         padding: const EdgeInsets.only(
//                             left: 12.0, top: 12, right: 12, bottom: 12),
//                         child: Text(
//                           'RON ',
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Theme.of(context).colorScheme.outline,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       contentPadding:
//                           const EdgeInsets.symmetric(horizontal: 12.0),
//                       hintText: '0.00',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(45),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 45,
//               ),
//               Center(
//                 child: TextFormField(
//                   textAlignVertical: TextAlignVertical.center,
//                   decoration: InputDecoration(
//                       constraints: const BoxConstraints(
//                         maxWidth: 360,
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                       prefixIcon: const Icon(SFSymbols.pencil,
//                           color: Color.fromARGB(255, 72, 72, 72)),
//                       hintText: 'Income Details',
//                       hintStyle: TextStyle(
//                           color: Theme.of(context).colorScheme.outline),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide.none)),
//                 ),
//               ),
//               const SizedBox(
//                 height: 75,
//               ),
//               const Text(
//                 "Set Name",
//                 style: TextStyle(
//                   fontSize: 26,
//                   fontWeight: FontWeight.w700,
//                   color: Color.fromARGB(255, 123, 123, 123),
//                 ),
//               ),
//               const SizedBox(
//                 height: 45,
//               ),
//               Center(
//                 child: TextFormField(
//                   textAlignVertical: TextAlignVertical.center,
//                   decoration: InputDecoration(
//                       constraints: const BoxConstraints(
//                         maxWidth: 360,
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                       prefixIcon: const Icon(SFSymbols.person,
//                           color: Color.fromARGB(255, 72, 72, 72)),
//                       hintText: 'New Name',
//                       hintStyle: TextStyle(
//                           color: Theme.of(context).colorScheme.outline),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide.none)),
//                 ),
//               ),
//               const SizedBox(
//                 height: 165,
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   boxShadow: const [
//                     BoxShadow(
//                       blurRadius: 2.5,
//                       spreadRadius: 0.5,
//                       color: Color.fromARGB(255, 137, 131, 131),
//                       offset: Offset(2, 2),
//                     ),
//                   ],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: kToolbarHeight,
//                   child: DecoratedBox(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           Theme.of(context).colorScheme.primary,
//                           Theme.of(context).colorScheme.secondary,
//                           Theme.of(context).colorScheme.tertiary,
//                         ],
//                       ),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: TextButton(
//                       onPressed: () {},
//                       style: TextButton.styleFrom(
//                         padding: EdgeInsets.zero,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: const Text(
//                         'Save',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:math';

import 'package:budget_buddy/screens/settings/blocs/create_income_bloc/create_income_bloc.dart';
import 'package:budget_buddy/screens/settings/blocs/get_incomes_bloc/get_incomes_bloc.dart';
import 'package:budget_buddy/screens/settings/views/income_creation.dart';
import 'package:budget_buddy/screens/view_all_incomes/view_all_incomes.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class Settings extends StatelessWidget {
  final List<Income> incomes;
  const Settings({required this.incomes, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateIncomeBloc(
            FirebaseIncomeRepo(),
          ),
        ),
        BlocProvider(
          create: (context) => GetIncomesBloc(
            FirebaseIncomeRepo(),
          )..add(GetIncomes()),
        )
      ],
      child: BlocBuilder<GetIncomesBloc, GetIncomesState>(
        builder: (context, state) {
          if (state is GetIncomesSuccess) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                backgroundColor: Theme.of(context).colorScheme.surface,
                appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  elevation: 0,
                  title: Text(
                    "Settings",
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
                body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 105,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: kToolbarHeight,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 2.5,
                                spreadRadius: 0.5,
                                color: Color.fromARGB(255, 137, 131, 131),
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: TextButton.icon(
                            onPressed: () async {
                              final getIncomesBloc =
                                  context.read<GetIncomesBloc>();
                              await getIncomeCreation(context);
                              getIncomesBloc.add(GetIncomes());
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            icon: const Icon(
                              SFSymbols.plus_app,
                              color: Color.fromARGB(255, 72, 72, 72),
                            ),
                            label: Text(
                              'Add Income',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: kToolbarHeight,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 2.5,
                                spreadRadius: 0.5,
                                color: Color.fromARGB(255, 137, 131, 131),
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: TextButton.icon(
                            onPressed: () async {
                              //view all incomes logic!!!!
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                    ViewAllIncomes(state.incomes),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            icon: const Icon(
                              SFSymbols.tray_full,
                              color: Color.fromARGB(255, 72, 72, 72),
                            ),
                            label: Text(
                              'View All Income Details',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 350,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: kToolbarHeight,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(context).colorScheme.secondary,
                                Theme.of(context).colorScheme.tertiary,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 2.5,
                                spreadRadius: 0.5,
                                color: Color.fromARGB(255, 137, 131, 131),
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: TextButton.icon(
                            onPressed: () async {
                              //log out logic!!!!
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            icon: const Icon(
                              SFSymbols.square_arrow_left,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Log Out',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
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
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
