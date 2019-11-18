import 'package:flutter/material.dart';
import 'package:home_automation_app/service/HomeServer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Io> _ioState = List<Io>();

  @override
  void initState() {
    super.initState();
    HomeServer().getState().then((ioState) {
      setState(() {
        _ioState = ioState;
      });
    });
  }

  void _callServer(int io, int value) async {
    try {
      var result = await HomeServer().sendIoCommand(io, value);
      setState(() {
        _ioState = result;
      });
    } on Exception catch (exce) {
      print('Error occured...');
      print(exce);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
          children: _ioState
              .map((io) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(io.name),
                      RaisedButton(
                        child: Text(io.value > 0 ? 'An' : 'Aus'),
                        onPressed: () {
                          _callServer(io.id, io.value > 0 ? 0 : 255);
                        },
                      )
                    ],
                  ))
              .toList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _callServer(0, 100),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
