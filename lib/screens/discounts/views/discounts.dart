// import 'dart:math';
// import 'package:budget_buddy/screens/discounts/views/discounts_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

// class Discounts extends StatelessWidget {
//   const Discounts({super.key});

//   @override
//   Widget build(BuildContext context) {
//     int totalReceiptsRequired = 80;
//     int currentReceipts = 67;

//     int remainingReceipts = totalReceiptsRequired - currentReceipts;
//     double progress = currentReceipts / totalReceiptsRequired;

//     String userName = 'Robert Negre';

//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         backgroundColor: Theme.of(context).colorScheme.surface,
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).colorScheme.surface,
//           elevation: 0,
//           title: Text(
//             "Discounts",
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
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
//             child: Column(
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.width / 2,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(25),
//                     boxShadow: const [
//                       BoxShadow(
//                         blurRadius: 2.5,
//                         spreadRadius: 0.5,
//                         color: Color.fromARGB(255, 137, 131, 131),
//                         offset: Offset(2, 2),
//                       ),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Hello, $userName!",
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.w600,
//                             color: Theme.of(context).colorScheme.primary,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: 25),
//                         Stack(
//                           clipBehavior: Clip.none,
//                           children: [
//                             Container(
//                               height: 16,
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 color: Colors.grey[300],
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             FractionallySizedBox(
//                               widthFactor: progress,
//                               child: Container(
//                                 height: 16,
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       Theme.of(context).colorScheme.tertiary,
//                                       Theme.of(context).colorScheme.secondary,
//                                       Theme.of(context).colorScheme.primary,
//                                     ],
//                                     begin: Alignment.centerLeft,
//                                     end: Alignment.centerRight,
//                                   ),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                             ),
//                             const Positioned(
//                               right:
//                                   0, //align the right side of the circle with the end of the bar
//                               top: -10,
//                               child: CircleAvatar(
//                                 radius: 18,
//                                 backgroundColor: Colors.orange,
//                                 child: Icon(
//                                   SFSymbols.lock_fill,
//                                   color: Colors.white,
//                                   size: 26,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 25),
//                         Text(
//                           "Only $remainingReceipts more receipts to go until your next voucher!",
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Theme.of(context).colorScheme.onSurface,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           "Vouchers are issued in maximum 5 minutes.",
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Theme.of(context).colorScheme.onSurface,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 25),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "My Discounts",
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Theme.of(context).colorScheme.onSurface,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 25),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: discountsData.length,
//                     itemBuilder: (context, int i) {
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 16.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Stack(
//                                       alignment: Alignment.center,
//                                       children: [
//                                         Container(
//                                           width: 50,
//                                           height: 50,
//                                           decoration: BoxDecoration(
//                                             color: discountsData[i]['color'],
//                                             shape: BoxShape.circle,
//                                           ),
//                                         ),
//                                         discountsData[i]['icon'],
//                                       ],
//                                     ),
//                                     const SizedBox(width: 12),
//                                     Text(
//                                       discountsData[i]['percent'],
//                                       style: TextStyle(
//                                         fontSize: 15,
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .onSurface,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Text(
//                                       discountsData[i]['lockStatus'],
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .outline,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'dart:math';
import 'package:budget_buddy/screens/discounts/views/discounts_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class Discounts extends StatefulWidget {
  const Discounts({super.key});

  @override
  _DiscountsState createState() => _DiscountsState();
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}

class _DiscountsState extends State<Discounts> {

  final int totalReceiptsRequired = 35;
  int currentReceipts = 25; // Update as needed
  final List<Map<String, dynamic>> discountsData = [
    {
      'icon': SFSymbols.airplane,
      'color': const Color.fromARGB(255, 79, 211, 223),
      'percent': '10% OFF',
      'requiredReceipts': 10,
    },
    {
      'icon': SFSymbols.car_fill,
      'color': const Color.fromARGB(255, 168, 78, 65),
      'percent': '15% OFF',
      'requiredReceipts': 15,
    },
    {
      'icon': SFSymbols.cart_fill,
      'color': const Color.fromARGB(255, 85, 166, 108),
      'percent': '25% OFF',
      'requiredReceipts': 25,
    },
    {
      'icon': SFSymbols.bag_fill,
      'color': const Color.fromARGB(255, 140, 85, 166),
      'percent': '30% OFF',
      'requiredReceipts': 30,
    },
    {
      'icon': SFSymbols.poultry_leg,
      'color': const Color.fromARGB(255, 235, 169, 48),
      'percent': '35% OFF',
      'requiredReceipts': 35,
    }
  ];

  //final List<String> dropdownItems = ['Option 1', 'Option 2', 'Option 3'];
  final List<List<String>> dropdownMatrix = [
  // Category 1 options
  ['Booking', 'Wizz Air', 'Sixt'],
  
  // Category 2 options
  ['Car Vertical', 'OMV', 'Michelin'],
  
  // Category 3 options
  ['Kaufland', 'Lidl', 'Mega Image'],
  
  // Category 4 options
  ['H&M', 'Zara', 'Zalando'],
  
  // Category 5 options
  ['Starbucks', 'Jacks Bistro', 'C House Milano']
];
  List<bool> isExpandedList = [];

  @override
  void initState() {
    super.initState();
    isExpandedList = List<bool>.generate(discountsData.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    
    int remainingReceipts = totalReceiptsRequired - currentReceipts;
    double progress = currentReceipts / totalReceiptsRequired;

    String userName = 'Robert Negre';

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          title: Text(
            "Discounts",
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 2.5,
                        spreadRadius: 0.5,
                        color: Color.fromARGB(255, 137, 131, 131),
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hello, $userName!",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 25),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 16,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: progress,
                              child: Container(
                                height: 16,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context).colorScheme.tertiary,
                                      Theme.of(context).colorScheme.secondary,
                                      Theme.of(context).colorScheme.primary,
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const Positioned(
                              right:
                                  0, //align the right side of the circle with the end of the bar
                              top: -10,
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.orange,
                                child: Icon(
                                  SFSymbols.lock_fill,
                                  color: Colors.white,
                                  size: 26,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Text(
                          "Only $remainingReceipts more receipts to go until your next voucher!",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Vouchers are issued in maximum 5 minutes.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "My Discounts",
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Expanded(
                  child: ListView.builder(
                    itemCount: discountsData.length,
                    itemBuilder: (context, int i) {
                      bool isUnlocked =
                        currentReceipts >= discountsData[i]['requiredReceipts'];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: isUnlocked
                                ? () {
                                    setState(() {
                                      isExpandedList[i] = !isExpandedList[i];
                                    });
                                  }
                                : null,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color: isUnlocked ? discountsData[i]['color'] : Colors.grey,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    
                                                  ),
                                                  Icon(
                                                  isUnlocked
                                                      ? discountsData[i]['icon']
                                                      : SFSymbols.lock_fill,
                                                  color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 12),
                                              Text(
                                                discountsData[i]['percent'],
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            isUnlocked ? "Unlocked" : "Locked",
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .outline,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (isUnlocked && isExpandedList[i])
                                        Container(
                                          margin: const EdgeInsets.only(top: 8),
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(25),
                                          ),
                                          child: Column(
                                            children: dropdownMatrix[i].map((item) {
                                              return GestureDetector(
                                                onTap: () {
                                                  // Handle dropdown item selection
                                                  //print("Selected: $item");
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(
                                                      vertical: 8),
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        color: item ==
                                                                dropdownMatrix.last
                                                            ? Colors.transparent
                                                            : Colors.grey.shade300,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    item,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}






