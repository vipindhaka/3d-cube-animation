import 'dart:math';

import 'package:flutter/material.dart';

import 'package:vector_math/vector_math_64.dart' show Vector3;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;

  late Tween<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _xController =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
    _yController =
        AnimationController(vsync: this, duration: Duration(seconds: 30));
    _zController =
        AnimationController(vsync: this, duration: Duration(seconds: 40));

    _animation = Tween<double>(begin: 0, end: pi * 2);
  }

  @override
  Widget build(BuildContext context) {
    _xController
      ..reset()
      ..forward();
    _yController
      ..reset()
      ..forward();
    _zController
      ..reset()
      ..forward();
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: double.infinity,
            ),
            AnimatedBuilder(
              animation: Listenable.merge([
                _xController,
                _yController,
                _zController,
              ]),
              builder: (context, child) {
                return Transform(
                  transform: Matrix4.identity()
                    ..rotateX(_animation.evaluate(_xController))
                    ..rotateY(_animation.evaluate(_yController))
                    ..rotateZ(_animation.evaluate(_zController)),
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      //back
                      Transform(
                        transform: Matrix4.identity()
                          ..translate(Vector3(0, 0, -100)),
                        alignment: Alignment.center,
                        child: Container(
                          height: 100,
                          width: 100,
                          color: Colors.red,
                        ),
                      ),
                      // left
                      Transform(
                        transform: Matrix4.identity()..rotateY(pi / 2),
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 100,
                          width: 100,
                          color: Colors.green,
                        ),
                      ),
                      // //right
                      Transform(
                        transform: Matrix4.identity()..rotateY(-(pi / 2)),
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 100,
                          width: 100,
                          color: Colors.yellow,
                        ),
                      ),
                      // //top
                      Transform(
                        transform: Matrix4.identity()..rotateX(-(pi / 2)),
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 100,
                          width: 100,
                          color: Colors.orange,
                        ),
                      ),
                      // //bottom
                      Transform(
                        transform: Matrix4.identity()..rotateX(pi / 2),
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 100,
                          width: 100,
                          color: Colors.pink,
                        ),
                      ),
                      //front
                      Container(
                        height: 100,
                        width: 100,
                        color: Colors.white,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
