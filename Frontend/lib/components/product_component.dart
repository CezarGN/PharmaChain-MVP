import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medchain/models/product_model.dart';

import 'package:medchain/screens/pharmacy_details.dart';

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double p = 0.017453292519943295;
  final double a = 0.5 -
      cos((lat2 - lat1) * p) / 2 +
      cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
  final num mod = pow(10.0, 1);
  final double value = 12742 * asin(sqrt(a));
  return (value * mod).round().toDouble() / mod;
}

class ProductComponent extends StatelessWidget {
  const ProductComponent(
      {super.key, required this.product, this.currentPosition});
  final Product product;
  final Position? currentPosition;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, SlideRightRoute(page: PharmacyDetails(product: product)));
      },
      child: Container(
        height: 106,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4),
              child: Image.network(
                  'https://www.prolex.ro/wp-content/uploads/2019/02/catena-logo.png',
                  height: 60,
                  width: 60),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.name!,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        '${product.price} RON',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(0xFF14AD6D)),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.circle, size: 6),
                      ),
                      const Text('Farmacie'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.location_on_outlined, size: 13),
                      const SizedBox(width: 10),
                      if (currentPosition != null)
                        Text(
                          '${calculateDistance(currentPosition!.latitude, currentPosition!.longitude, product.positionX!, product.positionY!)} km',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SlideRightRoute extends PageRouteBuilder {
  SlideRightRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(3, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
  final Widget page;
}
