import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class loading extends StatefulWidget {
  const loading({super.key});

  @override
  State<loading> createState() {
    return _loading();
  }
}

class _loading extends State<loading> with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding:
              EdgeInsets.only(top: 300, bottom: 300, right: 150, left: 150),
          margin: EdgeInsets.all(16),
          child: Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedBuilder(
                animation: _controller,
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    color: Colors.amberAccent,
                  ),
                  child: Icon(
                    Icons.refresh_sharp,
                    color: Colors.black,
                    size: 45,
                  ),
                ),
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: _controller.value * 8.0 * math.pi,
                    child: child,
                  );
                },
              ),
              Text("loading....".tr),
            ],
          ),
        ),
      ),
    );
  }
}
