import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class TutorialPopupAdmin extends StatefulWidget {
  const TutorialPopupAdmin(
      {Key key,
      this.gifPath = 'assets/forward.gif',
      this.title,
      this.desc,
      this.createName = "Create",
      this.createColor = Colors.blue,
      this.create})
      : super(key: key);

  final String gifPath;
  final String title;
  final String desc;
  final Function create;
  final String createName;
  final Color createColor;

  @override
  TutorialPopupPlayerDialogState createState() {
    return TutorialPopupPlayerDialogState();
  }
}

class TutorialPopupPlayerDialogState extends State<TutorialPopupAdmin>
    with TickerProviderStateMixin {
  AnimationController ac;
  Animation animation;
  double width;
  double dwidth;
  double dheight;
  double height;
  int animationAxis = 0; // 0 for x 1 for y

  String gifPath;
  String title;
  String desc;
  Function create;
  String createName;
  Color createColor;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height * 0.8;
    dwidth = 0.59 * height;
    dheight = 0.7 * height;

    var image = ClipRRect(
        child: Image.asset(gifPath, fit: BoxFit.fill, width: dwidth),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)));

    return Dialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: SingleChildScrollView(
          child: Container(
            width: dwidth,
            height: dheight,
            transform: Matrix4.translationValues(
                animationAxis == 0 ? animation.value * width : 0,
                animationAxis == 1 ? animation.value * width : 0,
                0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                //Bild
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  height: 0.5 * dheight,
                  child: image,
                ),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(title,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center)),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(desc,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center)
                ),

                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(60.0)
                    ),
                    height: 0.15*dheight,
                    minWidth: 0.4*dwidth,
                    color: createColor,
                    child: Text(
                      createName,
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    onPressed: () => {
                      Navigator.of(context).pop(),
                      //TODO: create new playground and save to server + generate id
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void initState() {
    title = widget.title;
    gifPath = widget.gifPath;
    createColor = widget.createColor;
    desc = widget.desc;
    create = widget.create;
    createName = widget.createName;

    double start = -1.0;

    animationAxis = 1;
    ac =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    animation = Tween(begin: start, end: 0.0)
        .animate(CurvedAnimation(parent: ac, curve: Curves.easeIn));
    animation.addListener(() {
      setState(() {});
    });

    ac.forward();
    super.initState();
  }

  Widget createButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 0.4 * dwidth,
            height: 0.15 * dheight,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(60.0)),
              color: createColor,
              child: Text(
                createName,
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
              onPressed: () => {
                Navigator.of(context).pop(),
                showDialog(
                    context: context,
                    builder: (BuildContext context) => TutorialPopupAdmin(
                          title: "Spielerstellung",
                          desc: "Erstelle einen neuen Raum",
                          create: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            var rng = new Random();
                            String roomName = "room${rng.nextInt(100)}";
                            await prefs.setString("game", roomName);

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: new Text("Der Raum wurde erstellt"),
                                  content: new Text("Der Raum heißt ${roomName}"),
                                  actions: <Widget>[
                                    // usually buttons at the bottom of the dialog
                                    new FlatButton(
                                      child: new Text("Schließen"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              }
                            );
                          },
                        ))
              },
            ),
          )
        ],
      ),
    );
  }
}
