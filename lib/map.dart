import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './model/ev.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:convert';
import './evDetail.dart';
import 'package:clustering_google_maps/clustering_google_maps.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  ClusteringHelper clusteringHelper;
  Dialogs dialogs = new Dialogs();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId selectedMarker;
  int _markerIdCounter = 1;

  void addMarker(String lat, String lng,String location,String provider ,String type,String parkingNo) {
    double latitude = double.parse(lat);
    double longitude = double.parse(lng);
    print(latitude);
    print(longitude);
    final int markerCount = markers.length;
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = new Marker(
      markerId: markerId,
      position: LatLng(latitude, longitude),
      onTap: () {
        
        dialogs.information(context, location,lat,lng,provider,type,parkingNo);
      },
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  Future<String> _loadEVAsset() async {
    return await rootBundle.loadString('assets/data/EV.json');
  }

  Future loadEV() async {
    String jsonPhotos = await _loadEVAsset();
    final jsonResponse = json.decode(jsonPhotos);
    EVList evList = EVList.fromJson(jsonResponse);
    for (int i = 0; i < evList.evStations.length; i++) {
      addMarker(evList.evStations[i].lat, evList.evStations[i].lng,evList.evStations[i].location,evList.evStations[i].provider,evList.evStations[i].type,evList.evStations[i].parkingNo);

      print("location " +
          evList.evStations[i].location +
          evList.evStations[i].lat +
          " " +
          evList.evStations[i].lng);
    }
  }


  @override
  void initState() {
    loadEV();
  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.352734, 114.1277),
    zoom: 10,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);        
          clusteringHelper.updateMap();
        },
        markers: Set<Marker>.of(markers.values),
      ),
    );
  }


  
}
