import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'backend.dart';

// final double adjusted_height = MediaQuery.of(context).size.height/640;
// final double adjusted_width = MediaQuery.of(context).size.width/360;

class getClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    var path=new Path();
    path.lineTo(0.0, size.height/3);
    path.lineTo(size.width+125, 0.0);
    path.close();
    return path;



  }

  bool shouldReclip(CustomClipper<Path> oldClipper){
    return true;
  }
}



class myclippath extends StatelessWidget {

  @override
  Widget build(BuildContext context) { final double adjusted_height = MediaQuery.of(context).size.height/640;  final double adjusted_width = MediaQuery.of(context).size.width/360;

  return ClipPath(
    child: Container(color:Colors.black.withOpacity(0.8)),
    clipper: getClipper(),
  );
  }

}


class mycenteredimage extends StatelessWidget {

  mycenteredimage ({this.path});
  final String path;
  @override
  Widget build(BuildContext context) { final double adjusted_height = MediaQuery.of(context).size.height/640;  final double adjusted_width = MediaQuery.of(context).size.width/360;

  return Container(
      width:adjusted_width*360.0,
      height:adjusted_height*220.0,
    //  margin: EdgeInsets.only(left: adjusted_width*27.0, right:adjusted_width*20.0),

      decoration: BoxDecoration(
        color:Colors.red,
        image:DecorationImage(
          image:AssetImage(this.path
          ),
          fit:BoxFit.cover,
        ),
//        borderRadius: BorderRadius.all(Radius.circular(adjusted_width*75.0)
//        ),
        boxShadow: [
          BoxShadow(blurRadius: adjusted_width*7.0,color: Colors.black),
        ],
      ),
    );
 // );
  }

}


class mytitletext extends StatelessWidget {
  mytitletext({this.title});
  final String title;
  @override
  Widget build(BuildContext context) { final double adjusted_height = MediaQuery.of(context).size.height/640;  final double adjusted_width = MediaQuery.of(context).size.width/360;

  return Container(
    margin: EdgeInsets.only(left: adjusted_width*27.0, right:adjusted_width*20.0),

    child:
    Text(
      this.title,
      style: TextStyle(
        fontSize: adjusted_height*adjusted_height*30.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'MontSerrat',
      ),
    ),
  );
  }

}


class mysubtext extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final double adjusted_height = MediaQuery.of(context).size.height/640;
    final double adjusted_width = MediaQuery.of(context).size.width/360;

    return Container(
      margin: EdgeInsets.only(left: adjusted_width*27.0, right:adjusted_width*20.0),

      child:Text(
        'Chest Disease Classification Using Convolutional Neural Network',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: adjusted_height*15.0,
          fontStyle: FontStyle.italic,
          fontFamily: 'MontSerrat',
        ),
      ),
    ) ;
  }

}






class verysexytext extends StatelessWidget {

  verysexytext ({this.name,this.number});
  final String name;
  final int number;
  @override
  Widget build(BuildContext context) { final double adjusted_height = MediaQuery.of(context).size.height/640;  final double adjusted_width = MediaQuery.of(context).size.width/360;

  return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          this.number.toString(),
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: adjusted_height*5.0),
        Text(
          this.name,
          style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.grey),
        )
      ]
  );
  }

}

class wordtext extends StatelessWidget {

  wordtext ({this.name});
  final String name;
  @override
  Widget build(BuildContext context) { final double adjusted_height = MediaQuery.of(context).size.height/640;  final double adjusted_width = MediaQuery.of(context).size.width/360;

  return Container(
    margin: EdgeInsets.only(left: adjusted_width*27.0, right:adjusted_width*20.0),

    child:Text(
      this.name,
      style: TextStyle(
        fontSize: adjusted_height*30.0,
        fontStyle: FontStyle.normal,
        fontFamily: 'MontSerrat',
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
        decorationStyle: TextDecorationStyle.solid,

      ),
    ),
  ) ;
  }

}

class meaningtext extends StatelessWidget {

  meaningtext ({this.name});
  final String name;
  @override
  Widget build(BuildContext context) { final double adjusted_height = MediaQuery.of(context).size.height/640;  final double adjusted_width = MediaQuery.of(context).size.width/360;

  return Container(
    margin: EdgeInsets.only(left: adjusted_width*27.0, right:adjusted_width*20.0),

    child:Text(
      this.name,
      style: TextStyle(
        fontSize: adjusted_height*20.0,
        fontStyle: FontStyle.italic,
        fontFamily: 'MontSerrat',
        //   decoration: TextDecoration.,
        // decorationColor: Colors.black,

      ),
    ),
  ) ;
  }

}

class exampletext extends StatelessWidget {

  exampletext ({this.name});
  final String name;
  @override
  Widget build(BuildContext context) { final double adjusted_height = MediaQuery.of(context).size.height/640;  final double adjusted_width = MediaQuery.of(context).size.width/360;

  return Container(
    margin: EdgeInsets.only(left: adjusted_width*27.0, right:adjusted_width*20.0),

    child:Text(
      this.name,
      style: TextStyle(
        fontSize: adjusted_height*30.0,
        fontStyle: FontStyle.normal,
        fontFamily: 'MontSerrat',
        fontWeight: FontWeight.bold,

      ),
    ),
  ) ;
  }

}

class learnedwordstitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) { final double adjusted_height = MediaQuery.of(context).size.height/640;  final double adjusted_width = MediaQuery.of(context).size.width/360;

  return Container(
    margin: EdgeInsets.only(left: adjusted_width*27.0, right:adjusted_width*20.0),

    child:
    Text(
      'LEARNED WORDS',
      style: TextStyle(
        fontSize: adjusted_height*32.0,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
        fontFamily: 'MontSerrat',
      ),
    ),
  );
  }

}

class display_a_word extends StatelessWidget {
  display_a_word({this.word, this.left, this.top});

  // Fields in a Widget subclass are always marked "final".

  final String word;
  final double left,top;

  @override
  Widget build(BuildContext context) { final double adjusted_height = MediaQuery.of(context).size.height/640;  final double adjusted_width = MediaQuery.of(context).size.width/360;

  return Container(
    padding: EdgeInsets.fromLTRB(left, top, 0.0, 0.0),
    child: Text(word,
        style: TextStyle(
            fontSize: adjusted_height*80.0, fontWeight: FontWeight.bold)),
  );
  }
}


class myTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) { final double adjusted_height = MediaQuery.of(context).size.height/640;  final double adjusted_width = MediaQuery.of(context).size.width/360;

  return Container(
    child: Stack(
      children: <Widget>[

        display_a_word(word:'Collins', left:adjusted_width*15.0, top: adjusted_height*70),
        display_a_word(word:'GRE', left:adjusted_width*16.0, top: adjusted_height*135),

      ],
    ),
  );
  }
}



