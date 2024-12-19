import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:get/get.dart';

void successSnackBar() {
  Get.snackbar(
    "Success",
    "Income Added Successfully!",
    titleText: Text(
      "Success",
      style: TextStyle(
        color:  Colors.green.shade900,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    messageText: Text(
      "Income added successfully!",
      style: TextStyle(
        color: Colors.green.shade900,
        fontSize: 14.0,
        fontWeight: FontWeight.w500
      ),
    ),
    colorText: Colors.green.shade900,
    duration: const Duration(seconds: 100),
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
}

void errorSnackBar() {
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

void warningSnackBar() {
  Get.snackbar(
    "Warning",
    "Something went wrong!",
    titleText: Text(
      "Warning",
      style: TextStyle(
        color:  Colors.yellow.shade900,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    messageText: Text(
      "Something went wrong!",
      style: TextStyle(
        color: Colors.yellow.shade900,
        fontSize: 14.0,
        fontWeight: FontWeight.w500
      ),
    ),
    colorText: Colors.yellow.shade900,
    duration: const Duration(seconds: 100),
    instantInit: true,
    snackPosition: SnackPosition.TOP,
    icon: Icon(SFSymbols.exclamationmark_triangle, color:  Colors.yellow.shade900, size: 35.0),
    padding: const EdgeInsets.all(10.0),
    margin: const EdgeInsets.all(10.0),
    borderRadius: 8,
    borderColor: Colors.yellow.shade600,
    borderWidth: 0.9,
    backgroundColor: Colors.yellow.shade50,
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

void loadingSnackBar() {
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
    duration: const Duration(seconds: 100),
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
}
