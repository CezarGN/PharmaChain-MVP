import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medchain/components/map_component.dart';
import 'package:medchain/models/product_model.dart';

class PharmacyDetails extends StatefulWidget {
  const PharmacyDetails({super.key, required this.product});
  final Product product;
  @override
  State<PharmacyDetails> createState() => _PharmacyDetailsState();
}

class _PharmacyDetailsState extends State<PharmacyDetails> {
  List<Product> products = <Product>[];
  int nrItems = 0;
  String address = '';

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Produsele au fost adaugate in cos!'),
                Text('Multumim!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Inchide'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> convertToAddress(double lat, double long) async {
    const String apiKey = 'AIzaSyBShIuAwooFMeK4jZ2--APZzpCjgyKgo34';
    final Dio dio = Dio();
    final String apiUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$apiKey';

    final Response response =
        await dio.get(apiUrl); //send get request to API URL

    if (response.statusCode == 200) {
      //if connection is successful
      final Map<String, dynamic> data = response.data as Map<String, dynamic>;
      //get response data
      if (data['status'] == 'OK') {
        //if status is "OK" returned from REST API
        if ((data['results'] as List<dynamic>).isNotEmpty) {
          //if there is atleast one address
          final Map<String, dynamic> firstResult =
              (data['results'] as List<dynamic>)[0]
                  as Map<String, dynamic>; //select the first address

          address =
              firstResult['formatted_address'] as String; //get the address

          //you can use the JSON data to get address in your own format

          setState(() {
            //refresh UI
          });
        }
      } else {}
    } else {}
  }

  @override
  void initState() {
    convertToAddress(widget.product.positionX!, widget.product.positionY!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: MapComponent(
                pos: LatLng(
                    widget.product.positionX!, widget.product.positionY!,),),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 11),
                    child: Text(
                      widget.product.name!,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '${widget.product.price} RON',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F9866),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16,),
                      color: Colors.white,
                      width: 312,
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Adresa',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            address,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF676768),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12,),
                    width: 312,
                    height: 75,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          'Program',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'L-V: 08:00 - 22:00',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF676768),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFDFE0E3)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  //color: Colors.white,
                  height: 48,
                  width: 48,
                  child: const Icon(Icons.remove, color: Color(0xFF31B77F)),
                ),
                onTap: () async {
                  //getPlace(widget.product.pharmacy.position);
                  setState(() {
                    if (nrItems > 0) {
                      nrItems -= 1;
                    }
                  });
                },
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFDFE0E3)),
                  borderRadius: BorderRadius.circular(8),
                ),

                //color: Colors.white,
                height: 48,
                width: 48,
                child: Center(
                  child: Text(
                    '$nrItems',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFDFE0E3)),
                    borderRadius: BorderRadius.circular(8),
                  ),

                  //color: Colors.white,
                  height: 48,
                  width: 48,
                  child: const Icon(Icons.add, color: Color(0xFF31B77F)),
                ),
                onTap: () {
                  setState(() {
                    nrItems += 1;
                  });
                },
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF31B77F),
                    borderRadius: BorderRadius.circular(8),
                  ),

                  //color: Colors.white,
                  height: 48,
                  width: 139,
                  child: const Center(
                    child: Text(
                      'Adauga in cos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  if (nrItems > 0) {
                    _showMyDialog();
                  }
                  setState(() {
                    nrItems = 0;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 29),
        ],
      ),
    );
  }
}
