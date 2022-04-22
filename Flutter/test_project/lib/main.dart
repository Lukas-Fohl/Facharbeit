import 'dart:js';

import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:time/time.dart';

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/my_file.txt');
}

Future<Uint8List> loadImageAsset() async {
  Uint8List data = (await rootBundle.load('assets/test.png'))
    .buffer
    .asUint8List();
  return data;
}

  String context2 = "";
Future<String> setImageBytes(imageBytes) async {
  List<int> values = imageBytes.buffer.asUint8List();
  img.Image photo;
  photo = img.decodeImage(values);
  int no1 = DateTime.now().millisecondsSinceEpoch;
  String res = "";
  for(int i=0;i<= photo.width-1;i++) {
    for (int j = 0; j <= photo.height-1; j++) {
      if(photo.getPixel(i, j).toString()=="")
      {
        res = (photo.getPixel(i, j)*5).toString();
      }
    }
  }
  int no2 = DateTime.now().millisecondsSinceEpoch;
  context2  = (no2-no1).toString();
  return abgrToArgb((photo.getPixel(1, 1))).toString();
}

int abgrToArgb(int argbColor) {
  int r = (argbColor >> 16) & 0xFF;
  int b = argbColor & 0xFF;
  return (argbColor & 0xFF00FF00) | (b << 16) | r;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Test Project Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _content = "";
  void _readFile() {
    int lower = 1;
    int upper = 200000;
    bool yes = false;
    int no1 = DateTime.now().millisecondsSinceEpoch;
    List<int> numb = [];
    int div = (upper-lower).abs();
    for(int num = 1; num< div;num++)
    {
      yes = false;
      for(int j =2; j < num; j++)
      {
        if(num%j == 0)
        {
          yes = false;
          break;
        }else
        {
          yes = true;
        }
      }
      if(yes == true)
      {
        numb.add(num);
        yes = false;
      }
    }
    int no2 = DateTime.now().millisecondsSinceEpoch;
    context2  = (no2-no1).toString();
    _show();
    //setState(() {});
  }

Future<void> _show() async
{
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("  "),
        content: SingleChildScrollView(
          child: ListBody(
            children:  <Widget>[
              Text(context2),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('ja'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

  void _readImageFile() {
//    loadImageAsset().then((Uint8List result){_content = result.toString();});
    loadImageAsset().then((Uint8List result){setImageBytes(result).then((String result1){_content =result1.toString();});});
    _show();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'File Contents:',
              ),
              Text(
                '$_content',
                style: Theme
                    .of(context)
                    .textTheme
                    .headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RaisedButton(
                  child: Text("prime"),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: _readFile,
                ),
                RaisedButton(
                  child: Text("image"),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: _readImageFile,
                )
            ]
        )
    );
  }
}
