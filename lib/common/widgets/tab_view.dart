import 'package:flutter/material.dart';

class ReadOnlyTabBar extends StatelessWidget implements PreferredSizeWidget {
  const ReadOnlyTabBar({Key? key, required this.child}) : super(key: key);
  final TabBar child;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(child: child);
  }

  @override
  Size get preferredSize => child.preferredSize;
}
