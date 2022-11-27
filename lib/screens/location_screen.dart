import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'city_screen.dart';
import '../services/weather.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature;
  String weather;
  String city;
  String weatherIcon;
  String text;
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();
    print("Started");
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic decodedData) {
    setState(() {
      if (decodedData == null) {
        temperature = 0;
        weather = 'Error';
        city = '';
        weatherIcon = '!';
        text = 'Unable to get weather data';
        return;
      }
      double temp = decodedData['main']['temp'];
      temperature = temp.toInt();
      weather = decodedData['weather'][0]['main'];
      city = decodedData['name'];
      int condition = decodedData['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      text = weatherModel.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Weather24x7"),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: Icon(
            FontAwesomeIcons.locationArrow,
          ),
          onPressed: () async {
            var locationData = await weatherModel.getLocationData();
            updateUI(locationData);
          },
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg.jpg"),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.dstATop),
            ),
          ),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  "$city",
                  style: GoogleFonts.cinzelDecorative(
                    textStyle: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                Text(
                  "$temperature°C",
                  style: GoogleFonts.alfaSlabOne(
                    textStyle:
                        TextStyle(fontSize: 70, color: Colors.yellowAccent),
                  ),
                ),
                SizedBox(
                  height: 180,
                ),
                Expanded(
                  child: Text(
                    "$weatherIcon",
                    style: TextStyle(
                      fontSize: 100,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "$text",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.indieFlower(
                      textStyle: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          var cityData = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CityScreen(),
                            ),
                          );
                          updateUI(cityData);
                        },
                        child: Icon(
                          FontAwesomeIcons.city,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
