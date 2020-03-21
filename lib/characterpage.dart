import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class CharacterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      width: 400,
      height: 400,
      child: FlareActor(
        'assets/Bob.flr',
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: 'Wave',
      ),
    );
  }
}