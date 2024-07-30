import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeBannerLoader extends StatelessWidget {
  const HomeBannerLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*.22,
      child: Shimmer.fromColors(
        baseColor: Colors.pink.shade100,
        highlightColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
            ),
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
