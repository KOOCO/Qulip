import 'package:flutter/material.dart';

String getCurrency(String? price) {
  double currency = 0.00;
  String str = '';
  double currencyLast = 0.00;
  String strLast = '';
  if ((price?.contains('-') ?? false)) {
    try {
      final String money = price?.split('-').first ?? '';
      final String moneyLast = price?.split('-').last ?? '';

      if (money.length > 7) {
        str = 'Cr';
        currency = int.parse(money) / 10000000;
      } else if (money.length > 5) {
        str = 'Lac';
        currency = int.parse(money) / 100000;
      } else if (money.length > 3) {
        str = 'K';
        currency = int.parse(money) / 1000;
      }

      if (moneyLast.length > 7) {
        strLast = 'Cr';
        currencyLast = int.parse(moneyLast) / 10000000;
      } else if (moneyLast.length > 5) {
        strLast = 'Lac';
        currencyLast = int.parse(moneyLast) / 100000;
      } else if (moneyLast.length > 3) {
        strLast = 'K';
        currencyLast = int.parse(moneyLast) / 1000;
      }

      return '₹ ${currency.toStringAsFixed(2)} $str - ₹ ${currencyLast.toStringAsFixed(2)} $strLast';
    } on Exception catch (e) {
      debugPrint(e.toString());
      return price.toString();
    }
  } else {
    try {
      final String money = price ?? '';

      if (money.length > 7) {
        str = 'Cr Onwards';
        currency = int.parse(money) / 10000000;
      } else if (money.length > 5) {
        str = 'Lac Onwards';
        currency = int.parse(money) / 100000;
      } else if (money.length > 3) {
        str = 'K Onwards';
        currency = int.parse(money) / 1000;
      }
      return '₹ ${currency.toStringAsFixed(2)} $str';
    } on Exception catch (e) {
      debugPrint(e.toString());
      return price.toString();
    }
  }
}
