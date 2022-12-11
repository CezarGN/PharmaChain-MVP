import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapComponent extends StatefulWidget {
  const MapComponent({super.key, required this.pos});

  final LatLng pos;

  @override
  State<MapComponent> createState() => _MapComponentState();
}

class _MapComponentState extends State<MapComponent> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: <Widget>[
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: widget.pos,
            zoom: 17,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 7, left: 7),
          child: FloatingActionButton.extended(
            backgroundColor: const Color(0xFF31B77F),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            icon: const Icon(Icons.map),
            label: const Text('Deschide hartă'),
            onPressed: () {
              _launchURLBrowser(widget.pos);
            },
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 7),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_outlined,
                  size: 30, color: Color(0xFF666666)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }
}

Future<void> _launchURLBrowser(LatLng position) async {
  final String url =
      'https://www.google.com/maps/search/?api=1&query=${position.latitude}%2C${position.longitude}';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}
