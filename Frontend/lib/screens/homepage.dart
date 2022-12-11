import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:medchain/components/product_component.dart';
import 'package:medchain/models/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late FlutterGifController gifController;
  final TextEditingController _myController = TextEditingController();
  List<Product> products = <Product>[];
  Position? currentPosition;
  bool _isLoading = true;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Location services are disabled. Please enable the services',
          ),
        ),
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Location permissions are permanently denied, we cannot request permissions.',
          ),
        ),
      );
      return false;
    }
    return true;
  }

  Future<void> _getProducts(String name) async {
    final String upperName = name.toUpperCase();
    final String url =
        'https://ab1e-109-166-139-211.eu.ngrok.io/medicines/$upperName';

    ///change the url linking hte backend with the frontend(server ngrok)
    final Response response = await get(Uri.parse(url));
    setState(() {
      _isLoading = false;
    });
    final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
    for (final dynamic item in jsonList) {
      final Product product = Product.fromJson(item as Map<String, dynamic>);
      products.add(product);
    }
  }

  Future<void> _getCurrentPosition() async {
    final bool hasPermission = await _handleLocationPermission();

    if (!hasPermission) {
      return;
    }
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => currentPosition = position);
    }).catchError((e) {
      debugPrint(e as String);
    });
    _isLoading = false;
    return;
  }

  @override
  void initState() {
    _getCurrentPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const SafeArea(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 42, left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    cursorColor: const Color(0xFF39C7A6),
                    controller: _myController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                            products = <Product>[];
                          });
                          await _getProducts(_myController.text);
                        },
                      ),
                      hintText: 'Cauta un produs',
                    ),
                    onSubmitted: (String str) async {
                      setState(() {
                        _isLoading = true;
                        products = <Product>[];
                      });
                      await _getProducts(_myController.text);
                    },
                  ),
                  if (products.isEmpty && _myController.text.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 150),
                      child: Center(
                        child: Text(
                          'Nu am gasit acest produs.',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.separated(
                        itemCount: products.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductComponent(
                              product: products[index],
                              currentPosition: currentPosition);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 12);
                        },
                      ),
                    )
                ],
              ),
            ),
    );
  }
}
