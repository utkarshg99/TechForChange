import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class BookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Book Appointment"),
      ),
      body: MapWidget(),
    );
  }
}

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
  _controller.complete(controller);
  }

  void _add(){
    MarkerId markerId = MarkerId('1');

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(10.0, 10.0),
      infoWindow: InfoWindow(title: markerId.toString(), snippet: '*'),
      onTap: () {
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child : WebviewScaffold(
        url : 'https://www.google.com/maps/search/hospitals+near+me',
      ),
    );
  }
}

// GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target: _center,
//           zoom : 11,
//         ),
//         myLocationEnabled: true,
//         compassEnabled: true,
//         markers: Set<Marker>.of(markers.values),
//       ),