import 'package:flutter/material.dart';
class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> with TickerProviderStateMixin {
  Animation?   _containerRadiusAnimation, _containerSizeAnimation, _containerColorAnimation;
   AnimationController?  _containerAnimationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _containerAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 5000));

    _containerRadiusAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(100.0),
      end: BorderRadius.circular(0.0)
    ).animate(CurvedAnimation(parent: _containerAnimationController!, curve: Curves.ease));

    _containerSizeAnimation = Tween(begin: 0.0, end: 2.0).animate(CurvedAnimation(parent: _containerAnimationController!, curve: Curves.ease));

    _containerColorAnimation = ColorTween(begin: Colors.black,end: Colors.white).animate(CurvedAnimation(parent: _containerAnimationController!, curve: Curves.ease));

    _containerAnimationController?.forward();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _containerAnimationController!.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width  = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Animation')),
      body: Center(
        child: AnimatedBuilder(
          animation: _containerAnimationController!,
          builder: (context, child) {
            return Container(
              transform: Matrix4.translationValues(0.0,0.0,0.0),
              width: _containerSizeAnimation?.value * width,
              height: _containerSizeAnimation?.value * height,
              decoration: BoxDecoration(
                borderRadius: _containerRadiusAnimation?.value,
                color: _containerColorAnimation?.value,
              ),
            );
          },
        ),
      )
    );
  }
}