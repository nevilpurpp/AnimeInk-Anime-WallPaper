import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget loadingShimmer() => Shimmer.fromColors(
   enabled: true,
    
          baseColor: Colors.black54,
          highlightColor: Colors.black87,
          child: Card()

);