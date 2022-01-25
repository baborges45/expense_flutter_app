import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: Container(
    //     height: 25,
    //     width: 25,
    //     child: CircularProgressIndicator(),
    //   ),
    // );
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey.shade500,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Column(
          children: [
            ListTile(
              title: Container(
                width: 100,
                height: 30,
                color: Colors.white,
              ),
              subtitle: Container(
                width: double.infinity,
                height: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
