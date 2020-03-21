import 'package:flutter/material.dart';

class TutorialPopupAdmin extends StatefulWidget {
  const TutorialPopupAdmin(
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
  Function submit;
  String submitName;
  Color submitColor;

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
        child: Column(
          children: <Widget>[
            //Bild
            Container(
              height: 0.32 * dheight,
              child: image,
            ),

            // Textcontainer
            Container(
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.only(
                    bottomLeft: const Radius.circular(15.0),
                    bottomRight: const Radius.circular(15.0)),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(title,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold))),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    child: Text(desc,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w300)),
                  ),
                  createButton(),
                ],
              ),
            )
          ],
        ));
  }

  @override
  void initState() {
    title = widget.title;
    gifPath = widget.gifPath;
    submitColor = widget.submitColor;
    desc = widget.textHint;
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

  createButton() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 0.2 * dwidth,
            height: 0.12 * dheight,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(60.0)),
              color: submitColor,
              child: Text(
                submitName,
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
              onPressed: () => {
                submit != null ? submit() : print("function is null"),
                Navigator.of(context).pop()
              },
            ),
          ),
        ],
      ),
    );
  }
}
