import 'package:flutter/material.dart';
import 'package:qulip/common/colors.dart';
import 'package:qulip/common/strings.dart';

class MyBottomNavgation extends StatelessWidget {
  const MyBottomNavgation({
    Key? key,
    required this.tabindexValue,
    required this.onTap,
  }) : super(key: key);

  final int tabindexValue;
  final Function(int?) onTap;

  List<BottomNavigationBarItem> _items() {
    return const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: WordStrings.bottomHome,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: WordStrings.bottomFav,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.history),
        label: WordStrings.bottomFav,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        label: WordStrings.bottomProfile,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: tabindexValue,
      showUnselectedLabels: true,
      onTap: onTap,
      selectedFontSize: 15,
      unselectedItemColor: stdgrey,
      unselectedLabelStyle: const TextStyle(
        color: stdgrey,
      ),
      selectedIconTheme: const IconThemeData(color: yasRed, size: 30),
      selectedItemColor: yasRed,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      items: _items(),
    );
  }
}
