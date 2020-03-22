import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class CharacterPage extends StatefulWidget {
  @override
  CharacterPageState createState() => CharacterPageState();
}

class CharacterPageState extends State<CharacterPage> {
  List items = [];

  String animation = "10 - Jump";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double dwidth = 0.59 * size.height;
    double dheight = 0.7 * size.height;
    //TODO: layout selber machen für charackter page?

    double boxSize = 100;
    double xPadding = 20;
    double yPadding = 10;
    double xSpace = 200;
    double ySpace = 140;

    double sizeImage = 350;

    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Container(
              color: Color.fromRGBO(207, 234, 255, 1)
            ),
          ),

          createBox(boxSize, 0 + yPadding, boxSize, xPadding, "d1"),
          createBox(boxSize, 0 + yPadding, boxSize, constraints.maxWidth-boxSize-xPadding, "d2"),
          createBox(boxSize, 0 + yPadding+ySpace, boxSize, 0 + xPadding, "d3"),
          createBox(boxSize, 0 + yPadding+ySpace, boxSize, constraints.maxWidth-boxSize-xPadding, "d4"),

          Positioned(
            top: 10,
            left: (constraints.maxWidth -sizeImage)/2,
            child: Container(
              alignment: Alignment.center,
              width: sizeImage,
              height: sizeImage,
              child: FlareActor(
                'assets/Boy1.flr',
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: animation,
                callback: (string) {
                  setState(() {
                    if(string=="2 - Hi") {
                      animation = "10 - Jump";
                    } else if (string=="10 - Jump"){
                      animation = "2 - Hi";
                    }
                  });
                }
              ),
            ),
          ),

          Positioned(
              top: 30,
              left: (constraints.maxWidth - constraints.maxWidth/3)/2,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(60.0)
                ),

                height: 50,
                minWidth: constraints.maxWidth/3,
                color: Color.fromRGBO(21, 154, 149, 1),
                child: Text(
                  "Skillbaum",
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
                onPressed: () => {
                  //Navigator.of(context).pop(),
                  //TODO: skkillaum page laden
                },
              )
          ),

          Positioned(
              width: constraints.maxWidth - 2 * xPadding,
              height: constraints.maxHeight/2 - 2 * yPadding,
              top: constraints.maxHeight /2 + 5,
              left: xPadding,
              child: Column(
                children: <Widget>[
                  Row (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Inventory",
                          style: TextStyle(color: Colors.black, fontSize: 20, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "XP",
                          style: TextStyle(color: Colors.black, fontSize: 20, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    //TODO: create custom liestview
                   child: ListView(
                     children: <Widget>[
                       ListTile(
                         leading: Icon(Icons.wb_sunny),
                         title: Text('Sun'),
                       ),
                       ListTile(
                         leading: Icon(Icons.brightness_3),
                         title: Text('Moon'),
                       ),
                       ListTile(
                         leading: Icon(Icons.star),
                         title: Text('Star'),
                       ),
                       ListTile(
                         leading: Icon(Icons.wb_sunny),
                         title: Text('Sun'),
                       ),
                       ListTile(
                         leading: Icon(Icons.brightness_3),
                         title: Text('Moon'),
                       ),
                       ListTile(
                         leading: Icon(Icons.star),
                         title: Text('Star'),
                       ),
                     ],
                   ),
                  )
                ],
              ),
          ),

        ],
      ),
    );
  }

  Widget createBox(double xSize, double xPosition, double ySize,
      double yPosition, String text) {
    return Positioned(
        width: xSize,
        height: ySize,
        top: xPosition,
        left: yPosition,
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: DottedBorder(
              color: Colors.black,
              //strokeWidth: 1,
              child: Container(
                child: Card(
                  color: Color.fromRGBO(21, 154, 149, 1),
                  //shape: RoundedRectangleBorder(
                  //borderRadius: BorderRadius.circular(5)
                  //),
                  child: Center(
                    child: Icon(Icons.add, size: 40,)
                  ),
                ),
              ),
            )));
  }
}
