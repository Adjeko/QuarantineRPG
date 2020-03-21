import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class Map extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      width: 400,
      height: 400,
      child: FlareActor(
        'assets/Loading.flr',
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: 'Alarm',
      ),
    );
  }
}