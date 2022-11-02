import 'package:flutter/material.dart';

class Level1 extends AnimatedWidget {
  const Level1({Key? key, required Animation<Offset> listenable})
      : super(key: key, listenable: listenable);

  Animation<Offset> get _animation => listenable as Animation<Offset>;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Transform.translate(
        offset: _animation.value,
        child: Container(
          height: 50,
          width: 80,
          child: Center(
            child: Text(
              "Level 1",
              style: TextStyle(color: Colors.white),
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(20)),
        ),
      );
    });
  }
}
