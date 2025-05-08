import 'package:flutter/material.dart';

Widget safeNetworkImage(String url, {double? width, double? height}) {
  return Image.network(
    url,
    width: width,
    height: height,
    fit: BoxFit.cover,
    errorBuilder:
        (_, __, ___) => Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          alignment: Alignment.center,
          child: Icon(Icons.broken_image, color: Colors.grey),
        ),
  );
}
