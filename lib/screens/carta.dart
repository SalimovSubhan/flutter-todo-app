import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Carta extends StatefulWidget {
  final Lat;
  final Lng;
  const Carta({required this.Lat, required this.Lng});

  @override
  State<Carta> createState() => _CartaState();
}

class _CartaState extends State<Carta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Адрес ползовател",
              style: TextStyle(fontSize: 14),
            ),
            Text(
              "если не паказывает адреса\nзначит адреса не сушест вует",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
      body: FlutterMap(
          options: MapOptions(
              initialCenter:
                  LatLng(double.parse(widget.Lat), double.parse(widget.Lng)),
              initialZoom: 11,
              interactionOptions:
                  InteractionOptions(flags: ~InteractiveFlag.doubleTapZoom)),
          children: [
            openStreetMapTileLater,
            MarkerLayer(markers: [
              Marker(
                  point: LatLng(
                      double.parse(widget.Lat), double.parse(widget.Lng)),
                  child: Icon(
                    Icons.location_on_sharp,
                    color: Colors.red,
                    size: 40,
                  ))
            ])
          ]),
    );
  }
}

TileLayer get openStreetMapTileLater => TileLayer(
      urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
      userAgentPackageName: "dev.fleaflet.flutter_map.exmple",
    );
