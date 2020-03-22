import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TutorialPopupPlayer extends StatefulWidget {
  const TutorialPopupPlayer(
      {Key key,
      this.gifPath = 'assets/forward.gif',
      this.title,
      this.textHint,
      this.submitName = "Load",
      this.submitColor = Colors.blue,
      this.submit})
      : super(key: key);

  final String gifPath;
  final String title;
  final String textHint;
  final Function submit;
  final String submitName;
  final Color submitColor;

  @override
  TutorialPopupPlayerDialogState createState() {
    return TutorialPopupPlayerDialogState();
  }
}

class TutorialPopupPlayerDialogState extends State<TutorialPopupPlayer>
    with TickerProviderStateMixin {
  AnimationController ac;
  Animation animation;
  double width;
  double dwidth;
  double dheight;
  double height;
  int animationAxis = 0; // 0 for x 1 for y

  final textController = TextEditingController();

  String gifPath;
  String title;
  String textHint;
  Function submit;
  String submitName;
  Color submitColor;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }


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
                    child: TextFormField(
                      controller: textController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: title,
                            hintText: textHint,
                            icon: Icon(Icons.phone_iphone)))),

                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(60.0)),
                      height: 0.15 * dheight,
                      minWidth: 0.4 * dwidth,
                      color: submitColor,
                      child: Text(
                        submitName,
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      onPressed: () async
                        {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setString("game", textController.text);
                          Navigator.of(context).pop();
                        }
                    ))
              ],
            ),
          ),
        ));
  }

  @override
  void initState() {
    title = widget.title;
    gifPath = widget.gifPath;
    submitColor = widget.submitColor;
    textHint = widget.textHint;
    submit = widget.submit;
    submitName = widget.submitName;

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
}
