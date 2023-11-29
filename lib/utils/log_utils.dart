import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';

class Log {
  static void logs(String title, String msg) {
    debugPrint('TAG:: $title :: $msg');
  }

  static void loga(String title, var msg) {
    //print('TAG:: $title :: $msg');
    // OR
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern
        .allMatches(msg)
        .forEach((match) => debugPrint('TAG:: $title :: ${match.group(0)!}'));
  }

  static void logi(String title, int msg) {
    debugPrint('TAG:: $title :: $msg');
  }

  static void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
  }

  static String printPrettyMap(Map mapData) {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');

    // display map in alphabetic order
    final sortedData =
        SplayTreeMap<String, dynamic>.from(mapData, (a, b) => a.compareTo(b));
    final String prettyPrint = encoder.convert(sortedData);

    return prettyPrint;
  }
}
