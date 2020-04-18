import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var mapController = MapController();
  Map<String, LatLng> coords = {};
  List<Marker> markers = [];
  @override
  void initState() {
    super.initState();
    coords.putIfAbsent('Tamale', () => LatLng(9.4329, -0.8484));
    coords.putIfAbsent('Accra', () => LatLng(5.5560, -0.1969));
    coords.putIfAbsent('Kumasi', () => LatLng(6.6884, -1.6244));
    for (int i = 0; i < coords.length; i++) {
      markers.add(Marker(
        width: 80.0,
        height: 80.0,
        point: coords.values.elementAt(i),
        builder: (ctx) => Icon(Icons.pin_drop, color: Colors.blue),
      ));
    }
  }

  void _showCoords(int index) {
    mapController.move(coords.values.elementAt(index), 10.0);
  }

  List<Widget> _makeButtons() {
    List<Widget> buttons = [];
    for (int i = 0; i < coords.length; i++) {
      buttons.add(RaisedButton(
        child: Text(coords.keys.elementAt(i)),
        onPressed: () => _showCoords(i),
      ));
    }
    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chapter 3'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _makeButtons(),
              ),
              Flexible(
                child: FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    center: LatLng(6.5182, -0.2702),
                    zoom: 5.0,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayerOptions(markers: markers),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
