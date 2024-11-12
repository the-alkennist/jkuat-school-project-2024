import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapAlertScreen(),
    );
  }
}

class MapAlertScreen extends StatefulWidget {
  @override
  _MapAlertScreenState createState() => _MapAlertScreenState();
}

class _MapAlertScreenState extends State<MapAlertScreen> {
  final MapController _mapController = MapController();
  final LatLng targetCoordinates =
      LatLng(37.7749, -122.4194); // Set your target coordinates here

  void _zoomToCoordinates() {
    _mapController.move(
        targetCoordinates, 18.0); // Set to maximum zoom level directly
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pothole and Bump Detection App'),
        actions: [
          IconButton(
            icon: Icon(Icons.zoom_in),
            onPressed: _zoomToCoordinates,
          ),
        ],
      ),
      body: Row(
        children: [
          // Map Section with padding and rounded corners
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5 -
                  32, // Adjusted for padding
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: FlutterMap(
                  mapController: _mapController, // Attach the controller
                  options: const MapOptions(
                    initialCenter: LatLng(-1.231720, 36.876605),
                    initialZoom: 20.0,
                    maxZoom: 20.0, // Set the maximum zoom level here
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      userAgentPackageName: 'potbump_detection_app',
                    ),
                    const RichAttributionWidget(
                      attributions: [
                        TextSourceAttribution(
                          'OpenStreetMap contributors',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Alerts/Status Section with padding and rounded corners
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black12.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: AlertStatusDisplay(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AlertStatusDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            "50m rem",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "Pothole Ahead!!",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.yellow),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            "To your right",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
