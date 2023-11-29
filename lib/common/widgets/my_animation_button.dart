import 'package:flutter/material.dart';

class CLBounceWidget extends StatefulWidget {
  const CLBounceWidget({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);
  final Function onPressed;
  final Widget child;

  @override
  CLBounceWidgetState createState() => CLBounceWidgetState();
}

class CLBounceWidgetState extends State<CLBounceWidget>
    with SingleTickerProviderStateMixin {
  late double _scale;
  final Duration duration = const Duration(milliseconds: 800);
  late AnimationController _animationController;

  //Getting onPressed Calback
  Function get onPressed => widget.onPressed;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: duration,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _animationController.value;
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: Transform.scale(scale: _scale, child: widget.child),
    );
  }

  // Triggering the onPressed callback with a check
  void _onTapTrigger() {
    onPressed();
  }

  //Start the animation
  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  // We revise the animation and notify the user of the event
  void _onTapUp(TapUpDetails details) {
    Future.delayed(const Duration(milliseconds: 50), () {
      _animationController.reverse();
    });

    //Finally calling the callback function
    _onTapTrigger();
  }
}
