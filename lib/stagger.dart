import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Stagger_List extends StatefulWidget {
  const Stagger_List({Key? key}) : super(key: key);

  @override
  State<Stagger_List> createState() => _Stagger_ListState();
}

class _Stagger_ListState extends State<Stagger_List> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 700),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(color: Colors.teal, child: ListTile()),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Stagger_Grid extends StatefulWidget {
  const Stagger_Grid({Key? key}) : super(key: key);

  @override
  State<Stagger_Grid> createState() => _Stagger_GridState();
}

class _Stagger_GridState extends State<Stagger_Grid> {
  @override
  @override
  Widget build(BuildContext context) {
    int columnCount = 3;

    return Scaffold(
      body: AnimationLimiter(
        child: GridView.count(
          crossAxisCount: columnCount,
          children: List.generate(
            100,
            (int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: columnCount,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: GridTile(
                      child: FlutterLogo(),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Stagger_Column extends StatefulWidget {
  const Stagger_Column({Key? key}) : super(key: key);

  @override
  State<Stagger_Column> createState() => _Stagger_ColumnState();
}

class _Stagger_ColumnState extends State<Stagger_Column> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: AnimationLimiter(
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
