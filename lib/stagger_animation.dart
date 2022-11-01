import 'package:flutter/material.dart';

class StaggerDemo extends StatefulWidget {
  @override
  _StaggerDemoState createState() => _StaggerDemoState();
}

class _StaggerDemoState extends State<StaggerDemo>
    with TickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> width;
  late Animation<double> height;
  late Animation<EdgeInsets> padding;
  late Animation<BorderRadius?> borderRadius;
  late Animation<Color?> color;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    width = Tween<double>(
      begin: 50.0,
      end: 150.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          0.250,
          curve: Curves.ease,
        ),
      ),
    );
    height = Tween<double>(begin: 50.0, end: 150.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.250,
          0.375,
          curve: Curves.ease,
        ),
      ),
    );
    padding = EdgeInsetsTween(
      begin: const EdgeInsets.only(bottom: 16.0),
      end: const EdgeInsets.only(bottom: 72.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.250,
          0.500,
          curve: Curves.ease,
        ),
      ),
    );
    borderRadius = BorderRadiusTween(
      begin: BorderRadius.circular(4.0),
      end: BorderRadius.circular(75.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.500,
          0.750,
          curve: Curves.ease,
        ),
      ),
    );
    color = ColorTween(
      begin: Colors.red,
      end: Colors.pink,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.750,
          1,
          curve: Curves.ease,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staggered Animation'),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (controller.status == AnimationStatus.dismissed) {
            controller.forward();
          } else if (controller.status == AnimationStatus.completed) {
            controller.reverse();
          }
        },
        child: Center(
          child: Container(
            child: AnimatedBuilder(
              animation: controller,
              builder: _buildAnimation,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Container(
      padding: padding.value,
      alignment: Alignment.bottomCenter,
      child: Container(
        width: width.value,
        height: height.value,
        decoration: BoxDecoration(
          color: color.value,
          border: Border.all(
            color: color.value!,
            width: 3.0,
          ),
          borderRadius: borderRadius.value,
        ),
      ),
    );
  }
}
