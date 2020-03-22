import 'package:flutter/material.dart';
import 'package:quarantinerpg/tutorial_admin.dart';
import 'package:quarantinerpg/tutorial_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class TutorialPopup extends StatefulWidget {

  const TutorialPopup({
    Key key,
    this.title,
    this.desc,
    this.okFun,
    this.cancelFun,
    this.gifPath = 'assets/forward.gif',
    this.cancelColor = Colors.blue,
    this.okColor = Colors.pink,
    this.ok = " Spieler",
    this.cancel = "Admin",
  }) : super(key: key);

  final String title;
  final String desc;
  final Function okFun;
  final Function cancelFun;
  final String gifPath;
  final Color okColor;
  final Color cancelColor;
  final String ok;
  final String cancel;

  @override
  TutorialPopupDialogState createState() {
    return TutorialPopupDialogState();
  }

}

class TutorialPopupDialogState extends State<TutorialPopup> with TickerProviderStateMixin {

  AnimationController ac;
  Animation animation;
  double width;
  double dwidth;
  double dheight;
  double height;
  int animationAxis=0; // 0 for x 1 for y

  String title;
  String desc;
  Function okFun;
  Function cancelFun;
  String gifPath;
  Color okColor;
  Color cancelColor;
  String ok;
  String cancel;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery
        .of(context)
        .size
        .width;
    height = MediaQuery
        .of(context)
        .size
        .height;
    dwidth = height;
    dheight = height;

    var image = ClipRRect(
        child: Image.asset(gifPath, fit: BoxFit.fill, width: dwidth),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15))
    );

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Column(
        children: <Widget>[
          //Bild
          Container(
            height:0.32*dheight,
            child: image,
          ),

          // Textcontainer
          Container(
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.only(
                  bottomLeft:  const  Radius.circular(15.0),
                  bottomRight: const  Radius.circular(15.0)
              ),
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                      title,
                      style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center
                  )
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    child: Text(
                        desc,
                        style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w300),
                        textAlign: TextAlign.center
                    ),
                ),

                createButtons(),
              ],
            ),
          )
        ],

      )


    );
  }

  Widget createButtons() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          gMasterButton(cancel, cancelColor, cancelFun),
          playerButton(ok, okColor, okFun)
        ],
      ),
    );
  }


  Widget gMasterButton(String t,Color c,Function f){
    return Container(
      width: 0.2*dwidth,
      height: 0.12*dheight,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(60.0)),
        color: c,
        child: Text(t,style: TextStyle(color: Colors.white,fontSize: 13),),
        onPressed: ()=>
        {
          Navigator.of(context).pop(),
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  TutorialPopupAdmin(
                    title: "Spielerstellung",
                    desc: "Erstelle einen neuen Raum",
                    create: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      var rng = new Random();
                      String roomName = "room${rng.nextInt(1000)}";
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
                  )
          )
        },
      ),

    );
  }

  Widget playerButton(String t,Color c,Function f){
    return Container(
      width: 0.2*dwidth,
      height: 0.12*dheight,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(60.0)),
        color: c,
        child: Text(t,style: TextStyle(color: Colors.white,fontSize: 13),),
        onPressed: ()=>
        {
          Navigator.of(context).pop(),
          {
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    TutorialPopupPlayer(
                      title: "Session ID",
                      textHint: "Enter ID ...",
                      submit: () => {print("it's working :)")},
                      //TODO
                    )
            )
          },
        },
      ),

    );
  }

  @override
  void initState() {

    title=widget.title;
    desc=widget.desc;
    okFun=widget.okFun;
    cancelFun=widget.cancelFun;
    okColor=widget.okColor;
    cancelColor=widget.cancelColor;
    gifPath= widget.gifPath;
    ok=widget.ok;
    cancel=widget.cancel;
    gifPath = 'assets/forward.gif';

    double start = -1.0;

    animationAxis=1;
    ac=AnimationController(vsync: this,duration: Duration(milliseconds: 400));
    animation=Tween(begin:start,end:0.0).animate(
        CurvedAnimation(parent: ac,curve: Curves.easeIn)
    );
    animation.addListener((){
      setState(() {});
    });

    ac.forward();
    super.initState();
  }

}