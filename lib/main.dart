import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'components.dart';

final String phpEndPoint = 'http://192.168.100.97:8000/second/';
final String nodeEndPoint = 'http://192.168.43.171:3000/image';

void main() => runApp(MyApp());

//
//Future<http.Response> createPost() async{
//  file = await ImagePicker.pickImage(source: ImageSource.camera);
//
//  final response = await http.post('http://192.168.100.97:8000/second/',
//      headers: {
//        HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
//        HttpHeaders.cookieHeader:'csrftoken=N0qEi9dl46oWBjTWTKwItlojIKxJoA5bK8y9rQT5qlB0PDdgNMP2p9MNlD20QPWC; csrftoken=N0qEi9dl46oWBjTWTKwItlojIKxJoA5bK8y9rQT5qlB0PDdgNMP2p9MNlD20QPWC'
//      },
//      body: "csrfmiddlewaretoken="+ "u4J5T43M6LNTJ92qpjn5MVqN0urVu1SvrcRA2LJws00XXtmKjlGpIJOhDnWcWgJW"+ "&val="+base64Encode(file.readAsBytesSync())
//  );
//  return response;
//}

class MyApp extends StatelessWidget {
  File file;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String message="Please select a chest\n x-ray image for diagnosis.";
  File _image;
  String data="";
  int textSize=27;

  @override
  Widget build(BuildContext context) {
    final double adjusted_height = MediaQuery.of(context).size.height/640;
    final double adjusted_width = MediaQuery.of(context).size.width/360;
    return Scaffold(
      //appBar: AppBar(),
      body: new Column (
          children:<Widget>[
        //    Positioned(
            //  width:adjusted_width*350.0,
             // top:MediaQuery.of(context).size.height/12 ,
      //        Column(


        //        children: <Widget>[

                  mycenteredimage(path: 'assets/logo.jpg'),  //the image
                  SizedBox(height: adjusted_height*10.0),
                  mytitletext(title: 'CHESTNET'), //COLLINS GRE
                //  SizedBox(height: adjusted_height*5.0),
                  mysubtext(),  //A Complete GRE Preparation
                  SizedBox(height:adjusted_height*15.0),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      learnedwordsbutton(w: this,action: 0),
                      SizedBox(width:adjusted_width*30.0),


                      learnedwordsbutton(w: this,action:1),
                  //    SizedBox(width:adjusted_width*25.0),

                    ],
                  ),

                  logoutbutton(w:this),

                  Container(


                    height: adjusted_height*150,
                    width: adjusted_width*300,
                    child: Center(
                      child: buildCard(context),
                    ),
                  ),


                ],
              ),
           // ),
    //      ]
  //    ),




    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
      data="";
      textSize=26;
      message="Now you can upload the selected x-ray image or choose another image.";
    });
  }

  Future getImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      data="";
      textSize=26;
      _image = image;
      message="Now you can upload the selected x-ray image or choose another image.";

    });
  }

  void Upload() async {

    if (_image== null)
      {
        setState(() {
          data="";
          textSize=27;
          message="Please select an image before uploading";
        });

        return;


      }

    setState(() {
      message="Processing...";
    });



    print("hellp");
    //File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    File imageFile=_image;

    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse("http://192.168.100.97:8000/mult/");

    uri.replace(port: 8000);

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));
    request.headers.putIfAbsent('Cookie', ()=> 'csrftoken=N0qEi9dl46oWBjTWTKwItlojIKxJoA5bK8y9rQT5qlB0PDdgNMP2p9MNlD20QPWC; csrftoken=N0qEi9dl46oWBjTWTKwItlojIKxJoA5bK8y9rQT5qlB0PDdgNMP2p9MNlD20QPWC' );
    request.files.add(multipartFile);
    request.fields['csrfmiddlewaretoken'] = 'u4J5T43M6LNTJ92qpjn5MVqN0urVu1SvrcRA2LJws00XXtmKjlGpIJOhDnWcWgJW';
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      setState(() {
        if (response.statusCode==200)
          {
            data = value;
            textSize=15;
            message="You may upload another image if you like";

          }
          else if (response.statusCode==403)
            {
              message="Permission Error";
            }

            else if (response.statusCode==404)
              {
                message="Not found";
              }
      });

    });
    _image=null;

  }

  Widget buildCard(BuildContext context)
  {
    double adjusted_height = MediaQuery
        .of(context)
        .size
        .height / 640;
    double adjusted_width = MediaQuery
        .of(context)
        .size
        .width / 360;
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: adjusted_height*10,),


          Text(

            message,
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.normal,
              fontSize: adjusted_height *textSize,
            ),
            textAlign: TextAlign.center,
          ),

          Text(

            data,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.normal,
              fontSize: adjusted_height * 30.0,
            ),
            textAlign: TextAlign.center,
          ),

        ],
      )
    );
  }



}


class learnedwordsbutton extends StatelessWidget {

  learnedwordsbutton({this.w,this.action})
  {
    if (action==0)
      name="Take a picture";
    else
      name="Choose from Gallery";
  }

  final _MyHomePageState w;
  int action;
  String name;
  @override
  Widget build(BuildContext context) { final double adjusted_height = MediaQuery.of(context).size.height/640;  final double adjusted_width = MediaQuery.of(context).size.width/360;



  return Center(
    child:Container(
      height:adjusted_height*50.0,
      width:adjusted_width*160.0,
      margin: EdgeInsets.only(top: adjusted_height*0.0, bottom:adjusted_height*20.0),


      child:GestureDetector(
        onTap:() {
          if (action==0)
          w.getImage();
          else
            w.getImageGallery();
        },
        child: Material(
          borderRadius: BorderRadius.circular(adjusted_height*20.0),
          shadowColor: Colors.blueGrey,
          color: Colors.blueGrey,
          elevation: 7.0,

          child:Center(
            child: Text(
              name,
              style:TextStyle(color: Colors.white,fontFamily:'Montserrat',
              ),
            ),
          ),
        ),
      ),

    ),
  ) ;
  }
}

class logoutbutton extends StatelessWidget {

  logoutbutton({this.w});

  _MyHomePageState w;
  @override
  Widget build(BuildContext context) {

    final double adjusted_height = MediaQuery.of(context).size.height/640;
    final double adjusted_width = MediaQuery.of(context).size.width/360;



    return Center(
      child:Container(
        height:adjusted_height*40.0,
        width:adjusted_width*120.0,
        margin: EdgeInsets.only(left: adjusted_width*27.0, right:adjusted_width*20.0),

        child:GestureDetector(
          onTap:() {
            // Navigator.pushNamed(context, this.path);
            w.Upload();
          },
          child: Material(
            borderRadius: BorderRadius.circular(adjusted_height*20.0),
            shadowColor: Colors.blueAccent,
            color: Colors.blueAccent,
            elevation: 7.0,

            child:Center(
              child: Text(
                "Upload",
                style:TextStyle(color: Colors.white,fontFamily:'Montserrat',
                ),
              ),
            ),
          ),
        ),

      ),
    ) ;
  }
}
