import 'dart:math';

import 'package:flutter/material.dart';
import 'package:heart/second.dart';
import 'package:heart/third.dart';

class HeartAnimation extends StatefulWidget {
  const HeartAnimation({super.key});

  @override
  State<HeartAnimation> createState() => _HeartAnimationState();
}

class _HeartAnimationState extends State<HeartAnimation> with TickerProviderStateMixin {

   Animation?  _heartAnimation;
   AnimationController?  _heartAnimationController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _arrowAnimationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 300));
    // _arrowAnimation = Tween(begin: 0.0, end: pi).animate(_arrowAnimationController!);

    _heartAnimationController  = AnimationController(vsync: this,duration: const Duration(milliseconds: 1200));
    _heartAnimation = Tween(begin: 150.0,end: 170.0).animate(CurvedAnimation(parent: _heartAnimationController! , curve: Curves.bounceOut));

    _heartAnimationController?.addStatusListener((AnimationStatus status) {
      if(status == AnimationStatus.completed){
        _heartAnimationController?.repeat();
      }
    });

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _heartAnimationController?.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Example Animation')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //firstChild(),
          const SizedBox(height: 50.0,),
          secondChild(),
          ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const SecondPage(),));}, child: const Text('Second')),
          ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const ThirdPageAnimation(),));}, child: const Text('Third Animation'))
          //thirdChild()
        ],
      ),
    );
  }

  Widget secondChild(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: AnimatedBuilder(
            animation: _heartAnimationController!,
            builder: (context, child) {
              return Center(
                child: Container(
                  child: Center(
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: _heartAnimation?.value,
                    ),
                  ),
                ),
              );
            },
          )
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: OutlinedButton(
              
              onPressed: (){
                _heartAnimationController?.forward();
              }, 
              
              child: Text('Start beating herat animation')
            ),
          )
        )
      ],
    );
  }

}