import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class GoogleMapScreen extends StatefulWidget {
  final lat;
  final long;
  GoogleMapScreen({
    this.lat,
    this.long
});
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController _controller;

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();

    //print(widget.lat);

  }

 // LatLng _center = LatLng(lat,long);

  @override
  Widget build(BuildContext context) {
    var lat;
    var long;
    setState(() {
       lat  = double.parse(widget.lat);
      long = double.parse(widget.long);
     // print(long);
    });
   /* print(lat);
    _controller.animateCamera(CameraUpdate.newLatLng(LatLng(lat,long)));*/
    return Container(
      height: double.infinity,
      width: double.infinity,
      child:
      GoogleMap(
        markers: {_marker(long,lat)},
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: LatLng(19.2742363,73.0523224),
          zoom: 15.0
        ),
      )
    );
  }


  _marker(double lat, double long){
    return Marker(
        markerId: MarkerId("Default"),
        position: LatLng(19.2742363,73.0523224),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
        infoWindow: InfoWindow(
            title: "Delhi"
        )
    );
  }


}
