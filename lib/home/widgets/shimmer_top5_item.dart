import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class ShimmerTop5Item extends StatelessWidget {
  const ShimmerTop5Item({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          // Shimmer Placeholder for Photo Image
          SizedBox(
            width: 300.0,
            height: 260.0,
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade200,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Shimmer Placeholder for title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // // Shimmer for Photo Title
                // Shimmer.fromColors(
                //   baseColor: Colors.grey.shade300,
                //   highlightColor: Colors.grey.shade200,
                //   child: Container(
                //     height: 20,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(12.0),
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 20,
                ),
                // Shimmer for Description
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade200,
                  child: Container(
                    height: 20,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.white,
                    ),
                  ),
                ),
                // const SizedBox(
                //   height: 8,
                // ),
                // Shimmer for Another Description
                // Shimmer.fromColors(
                //   baseColor: Colors.grey.shade300,
                //   highlightColor: Colors.grey.shade200,
                //   child: Container(
                //     height: 20,
                //     width: 50,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(12.0),
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
