import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

final List<int> targets = [10, 15, 25, 30, 35];

final List<Map<String, dynamic>> discountsData = [
  {
    'icon': SFSymbols.airplane,
    'color': const Color.fromARGB(255, 79, 211, 223),
    'percent': '10% Off',
    'requiredReceipts': targets[0],
  },
  {
    'icon': SFSymbols.car_fill,
    'color': const Color.fromARGB(255, 168, 78, 65),
    'percent': '15% Off',
    'requiredReceipts': targets[1],
  },
  {
    'icon': SFSymbols.cart_fill,
    'color': const Color.fromARGB(255, 85, 166, 108),
    'percent': '25% Off',
    'requiredReceipts': targets[2],
  },
  {
    'icon': SFSymbols.bag_fill,
    'color': const Color.fromARGB(255, 140, 85, 166),
    'percent': '30% Off',
    'requiredReceipts': targets[3],
  },
  {
    'icon': SFSymbols.poultry_leg,
    'color': const Color.fromARGB(255, 235, 169, 48),
    'percent': '35% Off',
    'requiredReceipts': targets[4],
  }
];

final List<List<Map<String, dynamic>>> partnersData = [
  [
    {
      'name': 'Booking',
      'photoPath': 'assets/images/booking.png',
      'code': 'BK10BUDDY'
    },
    {
      'name': 'AirBnb',
      'photoPath': 'assets/images/airbnb.png',
      'code': 'AB10BUDDY'
    },
    {
      'name': 'Ryanair',
      'photoPath': 'assets/images/ryanair.png',
      'code': 'RY10BUDDY'
    },
    {
      'name': 'Wizz Air',
      'photoPath': 'assets/images/wizzair.png',
      'code': 'WZ10BUDDY'
    },
    {
      'name': 'Lufthansa',
      'photoPath': 'assets/images/lufthansa.png',
      'code': 'LH10BUDDY'
    },
  ],
  [
    {
      'name': 'Car Vertical',
      'photoPath': 'assets/images/car_vertical.png',
      'code': 'CV15BUDDY'
    },
    {'name': 'OMV', 'photoPath': 'assets/images/omv.png', 'code': 'OMV15BUDDY'},
    {
      'name': 'Michelin',
      'photoPath': 'assets/images/michelin.png',
      'code': 'MC15BUDDY'
    },
    {
      'name': 'Sixt',
      'photoPath': 'assets/images/sixt.png',
      'code': 'SX15BUDDY'
    },
  ],
  [
    {
      'name': 'Kaufland',
      'photoPath': 'assets/images/kaufland.png',
      'code': 'KF25BUDDY'
    },
    {
      'name': 'Lidl',
      'photoPath': 'assets/images/lidl.png',
      'code': 'LD25BUDDY'
    },
    {
      'name': 'Mega Image',
      'photoPath': 'assets/images/mega_image.png',
      'code': 'MI25BUDDY'
    },
    {
      'name': 'Carrefour',
      'photoPath': 'assets/images/carrefour.png',
      'code': 'CF25BUDDY'
    },
  ],
  [
    {'name': 'H&M', 'photoPath': 'assets/images/hm.png', 'code': 'HM30BUDDY'},
    {
      'name': 'Zara',
      'photoPath': 'assets/images/zara.png',
      'code': 'ZR30BUDDY'
    },
    {
      'name': 'Zalando',
      'photoPath': 'assets/images/zalando.png',
      'code': 'ZD30BUDDY'
    },
    {
      'name': 'Adidas',
      'photoPath': 'assets/images/adidas.png',
      'code': 'AD30BUDDY'
    },
    {
      'name': 'Nike',
      'photoPath': 'assets/images/nike.png',
      'code': 'NK30BUDDY'
    },
    {
      'name': 'Puma',
      'photoPath': 'assets/images/puma.png',
      'code': 'PM30BUDDY'
    },
  ],
  [
    {
      'name': 'Starbucks',
      'photoPath': 'assets/images/starbucks.png',
      'code': 'SB35BUDDY'
    },
    {
      'name': 'McDonalds',
      'photoPath': 'assets/images/mcdonalds.png',
      'code': 'MC35BUDDY'
    },
    {'name': 'KFC', 'photoPath': 'assets/images/kfc.png', 'code': 'KF35BUDDY'},
    {
      'name': 'Pizza Hut',
      'photoPath': 'assets/images/pizzahut.png',
      'code': 'PH35BUDDY'
    },
    {
      'name': 'Subway',
      'photoPath': 'assets/images/subway.png',
      'code': 'SW35BUDDY'
    },
    {
      'name': 'Burger King',
      'photoPath': 'assets/images/burgerking.png',
      'code': 'BK35BUDDY'
    },
  ],
];
