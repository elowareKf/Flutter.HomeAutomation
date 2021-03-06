import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_automation_app/models/Io.dart';
import 'package:home_automation_app/service/HomeServer.dart';

class MyHomePage extends StatefulWidget {
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
        title: Text('Blätterberg Automation'),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem>[
                PopupMenuItem(
                  child: FlatButton(
                    child: Text('Einstellungen'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/settings', arguments: this._ioState);
                    },
                  ),
                )
              ];
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 20,
        ),
        color: Theme.of(context).accentColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8),
            children: _ioState
                .map((io) => GridTile(
                      child: GestureDetector(
                        onTap: () => _callServer(io.id, io.value > 0 ? 0 : 1),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: io.value > 0 ? Colors.brown[500] : Colors.grey,
                          ),
                          child: Center(
                            child: Text(
                              io.name,
                              style: Theme.of(context).textTheme.title,
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList()),
      ),
    );
  }
}
