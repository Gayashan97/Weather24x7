import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../services/weather.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String city = '';
  WeatherModel weatherModel = WeatherModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Weather24x7",
          ),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg3.jpg"),
              fit: BoxFit.fill,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.srcOver),
            ),
          ),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  icon: Icon(
                    FontAwesomeIcons.city,
                    color: Colors.white,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Enter City Name",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(
                  color: Colors.black,
                ),
                onChanged: (value) {
                  city = value;
                },
              ),
              SizedBox(
                height: 50,
              ),
              TextButton(
                child: Text(
                  "Check Weather!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                onPressed: () async {
                  if (city.trim().isEmpty) {
                  } else {
                    var cityData = await weatherModel.getCityData(city);
                    if (cityData['cod'] != 200) {
                      Alert(
                        context: context,
                        title: "Error",
                        desc: "Enter a city",
                        style: AlertStyle(
                          backgroundColor: Colors.white,
                        ),
                      ).show();
                    } else {
                      Navigator.pop(context, cityData);
                    }
                  }
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.pinkAccent,
                  shadowColor: Colors.grey,
                  padding: EdgeInsets.all(10),
                  fixedSize: Size(200, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
