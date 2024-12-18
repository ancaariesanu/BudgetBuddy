// import 'dart:math';

// import 'package:budget_buddy/screens/settings/blocs/create_income_bloc/create_income_bloc.dart';
// import 'package:budget_buddy/screens/settings/blocs/get_incomes_bloc/get_incomes_bloc.dart';
// import 'package:budget_buddy/screens/settings/views/income_creation.dart';
// import 'package:budget_buddy/screens/view_all_incomes/view_all_incomes.dart';
// import 'package:expense_repository/expense_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

// class Settings extends StatelessWidget {
//   final List<Income> incomes;
//   const Settings({required this.incomes, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => CreateIncomeBloc(
//             FirebaseIncomeRepo(),
//           ),
//         ),
//         BlocProvider(
//           create: (context) => GetIncomesBloc(
//             FirebaseIncomeRepo(),
//           )..add(GetIncomes()),
//         )
//       ],
//       child: BlocBuilder<GetIncomesBloc, GetIncomesState>(
//         builder: (context, state) {
//           if (state is GetIncomesSuccess) {
//             return GestureDetector(
//               onTap: () => FocusScope.of(context).unfocus(),
//               child: Scaffold(
//                 backgroundColor: Theme.of(context).colorScheme.surface,
//                 appBar: AppBar(
//                   backgroundColor: Theme.of(context).colorScheme.surface,
//                   elevation: 0,
//                   title: Text(
//                     "Settings",
//                     style: TextStyle(
//                       color: Theme.of(context).colorScheme.onSurface,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   centerTitle: true,
//                   iconTheme: IconThemeData(
//                     color: Theme.of(context).colorScheme.onSurface,
//                   ),
//                 ),
//                 body: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
//                   child: Center(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const SizedBox(
//                           height: 25,
//                         ),
//                         Container(
//                           width: MediaQuery.of(context).size.width,
//                           height: MediaQuery.of(context).size.width / 2,
//                           decoration: BoxDecoration(
//                               // gradient: LinearGradient(
//                               //   colors: [
//                               //     Theme.of(context).colorScheme.primary.withOpacity(0.4),
//                               //     Theme.of(context).colorScheme.secondary.withOpacity(0.4),
//                               //     Theme.of(context).colorScheme.tertiary.withOpacity(0.4)
//                               //   ],
//                               // ),
//                               color: const Color.fromARGB(255, 91, 91, 91),
//                               borderRadius: BorderRadius.circular(25),
//                               boxShadow: const [
//                                 BoxShadow(
//                                     blurRadius: 2.5,
//                                     spreadRadius: 0.5,
//                                     color: Color.fromARGB(255, 203, 203, 203),
//                                     offset: Offset(2, 2))
//                               ]
//                             ),
//                           child: const Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 25.0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   "Account Details",
//                                   style: TextStyle(
//                                       fontSize: 24,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w800),
//                                 ),
//                                 SizedBox(
//                                   height: 40,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       "Displayed Name: ",
//                                       style: TextStyle(
//                                           fontSize: 18,
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.w700),
//                                     ),
//                                     Text(
//                                       "Robert Negre",
//                                       style: TextStyle(
//                                           fontSize: 18,
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.w400),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       "Email: ",
//                                       style: TextStyle(
//                                           fontSize: 18,
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.w700),
//                                     ),
//                                     Text(
//                                       "robertnegre16@gmail.com",
//                                       style: TextStyle(
//                                           fontSize: 18,
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.w400),
//                                     ),
//                                   ],
//                                 ),

//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 45,
//                         ),
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           height: kToolbarHeight,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: const [
//                                 BoxShadow(
//                                   blurRadius: 2.5,
//                                   spreadRadius: 0.5,
//                                   color: Color.fromARGB(255, 137, 131, 131),
//                                   offset: Offset(2, 2),
//                                 ),
//                               ],
//                             ),
//                             child: TextButton.icon(
//                               onPressed: () async {
//                                 final getIncomesBloc =
//                                     context.read<GetIncomesBloc>();
//                                 await getIncomeCreation(context);
//                                 getIncomesBloc.add(GetIncomes());
//                               },
//                               style: TextButton.styleFrom(
//                                 backgroundColor: Colors.transparent,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                               icon: const Icon(
//                                 SFSymbols.plus_app,
//                                 color: Color.fromARGB(255, 72, 72, 72),
//                               ),
//                               label: Text(
//                                 'Add Income',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Theme.of(context).colorScheme.outline,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 45,
//                         ),
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           height: kToolbarHeight,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: const [
//                                 BoxShadow(
//                                   blurRadius: 2.5,
//                                   spreadRadius: 0.5,
//                                   color: Color.fromARGB(255, 137, 131, 131),
//                                   offset: Offset(2, 2),
//                                 ),
//                               ],
//                             ),
//                             child: TextButton.icon(
//                               onPressed: () async {
//                                 //view all incomes logic!!!!
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute<void>(
//                                     builder: (BuildContext context) =>
//                                       ViewAllIncomes(state.incomes),
//                                   ),
//                                 );
//                               },
//                               style: TextButton.styleFrom(
//                                 backgroundColor: Colors.transparent,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                               icon: const Icon(
//                                 SFSymbols.tray_full,
//                                 color: Color.fromARGB(255, 72, 72, 72),
//                               ),
//                               label: Text(
//                                 'View All Income Details',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Theme.of(context).colorScheme.outline,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 200,
//                         ),
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width * 0.4,
//                           height: kToolbarHeight,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 colors: [
//                                   Theme.of(context).colorScheme.primary,
//                                   Theme.of(context).colorScheme.secondary,
//                                   Theme.of(context).colorScheme.tertiary,
//                                 ],
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: const [
//                                 BoxShadow(
//                                   blurRadius: 2.5,
//                                   spreadRadius: 0.5,
//                                   color: Color.fromARGB(255, 137, 131, 131),
//                                   offset: Offset(2, 2),
//                                 ),
//                               ],
//                             ),
//                             child: TextButton.icon(
//                               onPressed: () async {
//                                 //log out logic!!!!
//                               },
//                               style: TextButton.styleFrom(
//                                 backgroundColor: Colors.transparent,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                               icon: const Icon(
//                                 SFSymbols.square_arrow_left,
//                                 color: Colors.white,
//                               ),
//                               label: const Text(
//                                 'Log Out',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
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
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetIncomesBloc, GetIncomesState>(
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
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                            // gradient: LinearGradient(
                            //   colors: [
                            //     Theme.of(context).colorScheme.primary.withOpacity(0.4),
                            //     Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                            //     Theme.of(context).colorScheme.tertiary.withOpacity(0.4)
                            //   ],
                            // ),
                            color: const Color.fromARGB(255, 160, 104, 20),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 2.5,
                                  spreadRadius: 0.5,
                                  color: Color.fromARGB(255, 203, 203, 203),
                                  offset: Offset(2, 2))
                            ]),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Account Details",
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Displayed Name: ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "Robert Negre",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Email: ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "robertnegre16@gmail.com",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
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
                          child: BlocProvider(
                            create: (context) => CreateIncomeBloc(FirebaseIncomeRepo()),
                            child: Builder(
                              builder: (localContext) => TextButton.icon(
                                onPressed: () async {
                                  await getIncomeCreation(localContext);
                                  context.read<GetIncomesBloc>().add(GetIncomes());
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
                        height: 200,
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
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
