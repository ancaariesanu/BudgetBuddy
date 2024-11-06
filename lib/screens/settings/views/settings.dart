import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Add Income",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 72, 70, 70),
                ),
              ),
              const SizedBox(
                height: 55,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: TextFormField(
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
              const SizedBox(
                height: 45,
              ),
              Center(
                child: TextFormField(
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
              ),
              const SizedBox(
                height: 75,
              ),
              const Text(
                "Change Name",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 72, 70, 70),
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              Center(
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      constraints: const BoxConstraints(
                        maxWidth: 360,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(SFSymbols.person,
                          color: Color.fromARGB(255, 72, 72, 72)),
                      hintText: 'New Name',
                      hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.outline),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none)),
                ),
              ),
              const SizedBox(
                height: 165,
              ),
              SizedBox(
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
            ],
          ),
        ),
      ),
    );
  }
}
