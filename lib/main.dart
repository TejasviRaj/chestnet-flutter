import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

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
  String message="Welcome";
  File _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: getImage,
                child: Text('Choose Image'),
              ),
              SizedBox(width: 10.0),
              RaisedButton(
                onPressed: Upload,
                child: Text('Upload Image'),
              )
            ],
          ),
          (_image == null)
              ? Text('No Image Selected')
              : Text("imager"),
          Text(message),
        ],
      ),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  void Upload() async {
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
            message = value;

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


  }

}


