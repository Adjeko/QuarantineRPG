import 'package:flutter/material.dart';

class TutorialPopupPlayer extends StatefulWidget {

  const TutorialPopupPlayer({
    Key key,
    this.gifPath = 'assets/forward.gif',
    this.title,
    this.textHint,
    this.submitName = "Load",
    this.submitColor = Colors.blue,
    this.submit
  }) : super(key: key);

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

class TutorialPopupPlayerDialogState extends State<TutorialPopupPlayer> with TickerProviderStateMixin {

  AnimationController ac;
  Animation animation;
  double width;
  double dwidth;
  double dheight;
  double height;
  int animationAxis=0; // 0 for x 1 for y

  String gifPath;
  String title;
  String textHint;
  Function submit;
  String submitName;
  Color submitColor;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height *0.8;
    dwidth = 0.59*height;
    dheight = 0.7*height;

    var image=ClipRRect(
        child: Image.asset(gifPath,fit: BoxFit.fill,width: dwidth),
        borderRadius:BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
    );

    return GestureDetector(
      child:  Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child:Center(
          child: Container(
            width: dwidth,
            height: dheight ,
            transform: Matrix4.translationValues( animationAxis==0 ? animation.value*width:0, animationAxis==1 ?animation.value*width:0, 0),
            decoration: BoxDecoration(
              borderRadius:BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    height:0.4*dheight,
                    child: image,
                  ),

                  Text(title,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),
                  Padding(padding: EdgeInsets.only(top: 0.08*dwidth), //25
                      child: Container(
                        margin: EdgeInsets.only(left: 1),
                        height: 0.28*dheight,
                        child: TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                           border: InputBorder.none,
                           hintText: this.textHint
                          )
                        ),
                      )
                  ),

                  Container(
                    height: dheight*0.15,
                    margin: EdgeInsets.only(left: 0.075*dwidth),//20,40
                    alignment: Alignment.center,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(60.0)),
                      color: submitColor,
                      child: Text(submitName,style: TextStyle(color: Colors.white,fontSize: 15),),
                      onPressed: ()=>{
                        submit != null ? submit() : print("function is null"),
                        Navigator.of(context).pop()
                      },
                    ),
                  )


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget gMasterButton(String t,Color c,Function f){

    return Container(
      width: 0.4*dwidth,
      height: 0.15*dheight,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(60.0)),
        color: c,
        child: Text(t,style: TextStyle(color: Colors.white,fontSize: 15),),
        onPressed: ()=>{
          f != null ? f() : print("function is null"),
          Navigator.of(context).pop()
        },
      ),

    );
  }

  @override
  void initState() {

    title=widget.title;
    gifPath = widget.gifPath;
    submitColor = widget.submitColor;
    textHint = widget.textHint;
    submit = widget.submit;
    submitName = widget.submitName;

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