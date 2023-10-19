import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget loadingShimmer() {
  return Shimmer.fromColors(
    baseColor: const Color(0xFFC4C6CF),
    highlightColor: const Color(0xFF74777F),
    child: Card(
      child: SizedBox(
        //color: Colors.white, // Background color of your widget
        width: 100, // Adjust the width and height as needed
        height: 100,
      ),
    ),
  );
}