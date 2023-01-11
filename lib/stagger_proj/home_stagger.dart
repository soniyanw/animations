import 'package:flutter/material.dart';
import 'package:rive_animation/stagger_proj/ball.dart';
import 'package:rive_animation/stagger_proj/level1_box.dart';
import 'package:rive_animation/stagger_proj/level2_box.dart';
import 'package:rive_animation/stagger_proj/pin.dart';

class HomeStagger extends StatefulWidget {
  const HomeStagger({Key? key}) : super(key: key);

  @override
  State<HomeStagger> createState() => _HomeStaggerState();
}

class _HomeStaggerState extends State<HomeStagger>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _animationController2;
  late Animation<Offset> lev1;
  late Animation<Offset> lev2;
  late Animation<Offset> ball;
  late Animation<Offset> pin;
  String play = "Play";
  String level = "Level 1";
  late Animation<double> opacity;

  bool animation_status(AnimationController a) {
    if (a.status == AnimationStatus.dismissed) {
      return true;
    } else if (a.status == AnimationStatus.completed) {
      return false;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animationController2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    lev1 =
        Tween<Offset>(begin: const Offset(150, 20), end: const Offset(-400, 20))
            .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 0.6, curve: Curves.easeIn),
      ),
    );
    lev2 =
        Tween<Offset>(begin: const Offset(400, 20), end: const Offset(150, 20))
            .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 1, curve: Curves.easeIn),
      ),
    );
    ball =
        Tween<Offset>(begin: const Offset(150, 80), end: const Offset(150, 400))
            .animate(
      CurvedAnimation(
        parent: _animationController2,
        curve: const Interval(0, 0.6, curve: Curves.easeIn),
      ),
    );
    pin = Tween<Offset>(
            begin: const Offset(150, 410), end: const Offset(150, 900))
        .animate(
      CurvedAnimation(
        parent: _animationController2,
        curve: const Interval(0.6, 1, curve: Curves.easeIn),
      ),
    );
    opacity = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController2,
        curve: Interval(
          0.6,
          1,
          curve: Curves.easeIn,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        elevation: 50,
        backgroundColor: Colors.black,
        title: Text("Bowling Alley"),
      ),
      body: Stack(
        children: [
          Level1(listenable: lev1),
          Level2(listenable: lev2),
          Ball(listenable: ball),
          Opacity(
            opacity: opacity.value,
            child: Pin(
              listenable: pin,
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: double.infinity,
        color: Colors.grey,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              onPressed: () {
                if (animation_status(_animationController2)) {
                  _animationController2.forward();
                  play = "Play Again";
                } else {
                  _animationController2.reset();
                  play = "Play";
                }
                setState(() {});
              },
              elevation: 30,
              child: Text(
                play,
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
            ),
            MaterialButton(
              onPressed: () {
                if (animation_status(_animationController)) {
                  _animationController.forward();
                  level = "Level 1";
                  _animationController2.reset();
                  play = "Play";
                } else {
                  _animationController.reverse();
                  level = "Level 2";
                  _animationController2.reset();
                  play = "Play";
                }
                setState(() {});
              },
              elevation: 30,
              child: Text(
                level,
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
