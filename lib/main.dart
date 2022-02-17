import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  String _img =
      'https://pub.dev/static/img/pub-dev-logo-2x.png?hash=umitaheu8hl7gd3mineshk2koqfngugi';

  Future<void> _incrementCounter() async {
    var anow = DateTime.now();
    var url = Uri.https(
        'us-central1-dashatar-dev.cloudfunctions.net', '/createDashatar', {
      'agility': '3',
      'wisdom': '4',
      'strength': '3',
      'charisma': '2',
      'role': 'developer'
    });
    print('111');
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    print('222');
    if (response.statusCode == 200) {
      print('333');
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      print('444');
      var itemCount = jsonResponse['url'];
      print('555');
      setState(() {
        _img = itemCount;
        var bnow = DateTime.now();
        print('시간: ${anow.difference(bnow).inMilliseconds}');
      });
      print('Number of books about http: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
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
            Image.network(_img),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
