import 'package:flutter/material.dart';
import 'package:quarantinerpg/tutorial_player.dart';

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

                  Text(title,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                  Padding(padding: EdgeInsets.only(top: 0.08*dwidth), //25
                      child: Container(
                        margin: EdgeInsets.only(left: 1),
                        height: 0.28*dheight,
                        child: Text(desc,
                          style:TextStyle(color: Colors.grey[600],fontSize: 15),
                          textAlign: TextAlign.center,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                  ),

                  Container(
                    height: dheight*0.15,
                    margin: EdgeInsets.only(left: 0.075*dwidth),//20,40
                    child: Row(
                      children: <Widget>[
                        gMasterButton(cancel, cancelColor, cancelFun),
                        Padding(padding: EdgeInsets.only(left: 0.07*dwidth),
                            child: playerButton(ok, okColor, okFun)
                        )
                      ],
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

  Widget playerButton(String t,Color c,Function f){

    return Container(
      width: 0.4*dwidth,
      height: 0.15*dheight,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(60.0)),
        color: c,
        child: Text(t,style: TextStyle(color: Colors.white,fontSize: 15),),
        onPressed: ()=>
        {
          Navigator.of(context).pop(),
          {
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    TutorialPopupPlayer(
                      title: "Ist Okay.",
                      desc: "This is descreption for fancy gif.",
                      //'./assets/walp.png',
                      okFun: () => {print("it's working :)")},

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