import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String googleApikey = 'AIzaSyBShIuAwooFMeK4jZ2--APZzpCjgyKgo34';
  double latitude = 27.666994; //latitude
  double longitude = 85.309289; //longitude

  String address = '';

  @override
  void initState() {
    convertToAddress(latitude, longitude); //call convert to address
    super.initState();
  }

  Future<void> convertToAddress(double lat, double long) async {
    const String apiKey = 'AIzaSyBShIuAwooFMeK4jZ2--APZzpCjgyKgo34';
    final Dio dio = Dio(); //initilize dio package
    final String apiurl =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$apiKey';

    final Response response =
        await dio.get(apiurl); //send get request to API URL

    if (response.statusCode == 200) {
      //if connection is successful
      final Map<String, dynamic> data =
          response.data as Map<String, dynamic>; //get response data
      if (data['status'] == 'OK') {
        //if status is "OK" returned from REST API
        if ((data['results'] as List<dynamic>).isNotEmpty) {
          //if there is atleast one address
          final Map<String, dynamic> firstresult = (data['results']
              as List<Map<String, dynamic>>)[0]; //select the first address

          address =
              firstresult['formatted_address'] as String; //get the address

          //you can use the JSON data to get address in your own format

          setState(() {
            //refresh UI
          });
        }
      } else {}
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Address from Google Map API'),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Text(
              'Latitude: $latitude',
              style: const TextStyle(fontSize: 25),
            ),
            Text('Longitude: $longitude', style: const TextStyle(fontSize: 25)),
            Text(
              'Formatted Address: $address',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
