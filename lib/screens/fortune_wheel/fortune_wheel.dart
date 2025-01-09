import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class FortuneWheelPage extends StatefulWidget {
  const FortuneWheelPage({super.key});

  @override
  _FortuneWheelState createState() => _FortuneWheelState();
}

class _FortuneWheelState extends State<FortuneWheelPage> {
  final StreamController<int> _selectedController = StreamController<int>();
  final Map<String, String> _wheelItems = {
    "Free Coffee":
        "You just got a free coffee from 5ToGo. Please use code: BUD5TG",
    "No Reward": "Unfortunately, you didn't win anything this time.",
    "Gift Card":
        "You just got a 70 RON gift card from Zara Home. Please use code: BUD70ZR",
    "Try Again": "Unfortunately, you didn't win anything this time.",
    "Free Donut":
        "You just got a free donut from Starbucks. Please use code: BUDDON",
    "Unlucky Spin": "Unfortunately, you didn't win anything this time.",
    "Movie Ticket":
        "Enjoy a free movie ticket from Cinema City. Please use code: BUDMOV",
    "Unrewarded": "Unfortunately, you didn't win anything this time.",
    "Spa Day":
        "Relax with a free spa session at Bliss Spa. Please use code: BUDSPA"
  };

  final List<Color> _wheelColors = [
    Color.fromARGB(255, 124, 208, 127),
    Color.fromARGB(255, 79, 193, 165),
    Color.fromARGB(255, 136, 204, 213),
    Color.fromARGB(255, 124, 208, 127),
    Color.fromARGB(255, 79, 193, 165),
    Color.fromARGB(255, 136, 204, 213),
    Color.fromARGB(255, 124, 208, 127),
    Color.fromARGB(255, 79, 193, 165),
    Color.fromARGB(255, 136, 204, 213)
  ];

  @override
  void dispose() {
    _selectedController.close();
    super.dispose();
  }

  void _spinWheel() {
    int selectedIndex =
        (DateTime.now().millisecondsSinceEpoch % _wheelItems.length);
    _selectedController.add(selectedIndex);

    Future.delayed(const Duration(seconds: 4), () {
      String selectedItemKey = _wheelItems.keys.toList()[selectedIndex];
      String selectedItemValue = _wheelItems[selectedItemKey]!;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
            title: Column(
              children: [
                Text(
                  selectedItemKey,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
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
                ),
                Text(
                  selectedItemValue,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            content: SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                          onPressed: () => Navigator.pop(context),
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
                      ))
                ],
              ),
            )),
      );
    });
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
          title: const Text(
            "Fortune Wheel",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              SizedBox(
                height: 400,
                child: FortuneWheel(
                  selected: _selectedController.stream,
                  physics: CircularPanPhysics(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeOut,
                  ),
                  items: _wheelItems.entries.map((entry) {
                    String itemKey = entry.key;
                    int index = _wheelItems.keys.toList().indexOf(itemKey);
                    return FortuneItem(
                      child: Text(
                        itemKey,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      style: FortuneItemStyle(
                        color: _wheelColors[index % _wheelColors.length],
                        borderColor: Colors.white,
                        borderWidth: 3,
                      ),
                    );
                  }).toList(),
                  indicators: const [
                    FortuneIndicator(
                      alignment: Alignment.topCenter,
                      child: TriangleIndicator(color: Colors.orange),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                        width: double.infinity,
                        height: 70,
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
                              onPressed: _spinWheel,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Spin the Wheel',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '(You only have 2 trials each day)',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
