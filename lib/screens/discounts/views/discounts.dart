import 'package:budget_buddy/screens/discounts/views/discounts_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class Discounts extends StatefulWidget {
  const Discounts({super.key});

  @override
  _DiscountsState createState() => _DiscountsState();
}

class _DiscountsState extends State<Discounts> {

  final List<int> targets = [10, 15, 25, 30, 35];
  int currentReceipts = 17; 

  List<bool> isExpandedList = [];

  @override
  void initState() {
    super.initState();
    isExpandedList = List<bool>.generate(discountsData.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    
    // Find the next target
    int nextTarget = targets.firstWhere((target) => currentReceipts < target, orElse: () => targets.last);
    int receiptsToNextTarget = nextTarget - currentReceipts;

    // Calculate progress based on the next target
    int previousTarget = targets.indexOf(nextTarget) > 0 ? targets[targets.indexOf(nextTarget) - 1] : 0;
    double progress = (currentReceipts - previousTarget) / (nextTarget - previousTarget);

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
                          currentReceipts == 35 
                          ? "Congratulations! You have reached the maximum target of 35 receipts!"
                          : "Only $receiptsToNextTarget more receipt(s) to go until your next set of vouchers!",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          currentReceipts == 35
                          ? "Please wait until limits reset next month."
                          : "Vouchers are issued in maximum 5 minutes.",
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
                                  color: isUnlocked ? Colors.white : Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: const Color.fromARGB(100, 137, 131, 131),
                                    width: 0.5),
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
                                                      color: isUnlocked ? discountsData[i]['color'] : const Color.fromARGB(255, 109, 106, 106),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    
                                                  ),
                                                  Icon(
                                                  isUnlocked
                                                      ? discountsData[i]['icon']
                                                      : SFSymbols.lock_fill,
                                                  color: isUnlocked
                                                      ? Colors.white
                                                      : Colors.grey.shade300,
                                                  size: isUnlocked ? 24 : 30,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 12),
                                              Text(
                                                discountsData[i]['percent'],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: isUnlocked ? Theme.of(context).colorScheme.onSurface : Colors.grey.shade700,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                isUnlocked
                                                    ? SFSymbols.lock_open_fill
                                                    : SFSymbols.lock_fill,
                                                color: isUnlocked
                                                    ? Colors.green
                                                    : Colors.grey,
                                                size: isUnlocked ? 16 : 16,
                                              ),
                                              const SizedBox(width: 2),
                                              Text(
                                                isUnlocked ? "AVAILABLE" : "LOCKED",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: isUnlocked ? Colors.green : Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      if (isUnlocked && isExpandedList[i])
                                        Container(
                                          margin: const EdgeInsets.only(top: 8),
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(0),
                                          ),
                                          child: Column(
                                            children: partnersData[i].map((store) {
                                              return Container(
                                                margin: const EdgeInsets.symmetric(vertical: 8),
                                                padding: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[50],
                                                  borderRadius: BorderRadius.circular(25),
                                                  border: Border.all(
                                                    color: const Color.fromARGB(100, 137, 131, 131),
                                                    width: 0.5,
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.grey[300],
                                                        image: DecorationImage(
                                                          image: AssetImage(store['photoPath']),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 12),
                                                    Expanded(
                                                       child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            store['name'],
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w500,
                                                              color: Theme.of(context).colorScheme.onSurface,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Code: ${store['code']}",
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight: FontWeight.w700,
                                                              color: Colors.grey.shade600,
                                                            ),
                                                          ),
                                                        ],
                                                       ),
                                                    )
                                                  ]
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










