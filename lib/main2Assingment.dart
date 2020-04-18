import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Animation animation;
  AnimationController aniController;
  int _count = 0;

  @override
  void initState() {
    super.initState();
    aniController = AnimationController(
        duration: Duration(milliseconds: 3000), vsync: this);
    final CurvedAnimation curve =
        CurvedAnimation(parent: aniController, curve: Curves.easeIn);
    animation = Tween(begin: 50.0, end: 150.0).animate(curve);
    animation.addStatusListener(_listen);
  }

  void _listen(AnimationStatus status) {
    if (animation.status == AnimationStatus.completed) {
      setState(() => _count = 1);
    } else if (animation.status == AnimationStatus.dismissed) {
      setState(() => _count = 0);
    }
  }

  Widget aniBuilder(BuildContext ctx, Widget child) {
    return Center(
      child: Container(
        height: animation.value,
        width: animation.value * 2.0,
        child: RaisedButton(
          color: Colors.blue,
          child: Text(
            _count == 0 ? 'Grow' : 'Shrink',
            style: TextStyle(
              color: Colors.black38,
            ),
          ),
          onPressed: () {
            if (_count == 0) {
              setState(() => aniController.forward());
            } else {
              setState(() => aniController.reverse());
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Assignment'),
      ),
      body: Container(
          child: AnimatedBuilder(animation: animation, builder: aniBuilder)),
    );
  }
}
