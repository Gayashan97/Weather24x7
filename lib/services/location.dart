import 'package:geolocator/geolocator.dart';

class Location{

  double _latitude;
  double _longitude;

  void getLocation() async{

    Position position;

    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
    }catch(e){
      print("Cannot get location");
    }

    print(position);
    _latitude = position.latitude;
    _longitude = position.longitude;

  }

  double getLatitude(){
    return _latitude;
  }

  double getLongitude(){
    return _longitude;
  }

}

