import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class MapPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      width: 400,
      height: 400,
      child: FlareActor(
        'assets/House1.flr',
        alignment: Alignment.topCenter,
        fit: BoxFit.contain,
      ),
    );
  }
}