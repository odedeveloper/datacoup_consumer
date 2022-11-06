import 'package:datacoup/presentation/utils/constants/responsive.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBox extends StatelessWidget {
  final double? height, width, radius;
  const ShimmerBox({
    Key? key,
    this.height,
    this.width,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      enabled: true,
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300.withOpacity(0.5),
          borderRadius: BorderRadius.circular(radius ?? kBorderRadius),
        ),
        height: height,
        width: width,
      ),
    );
  }
}
