import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'VmImageDetailsScreen.dart';


class ImageDetailScreen extends StatelessWidget {
  final ImageProvider image;
  final  l_VmImageDetailScreen = Get.put(VmImageDetailController());
  ImageDetailScreen({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image'),
      ),
      body: GestureDetector(
        onDoubleTap: () {
          if (l_VmImageDetailScreen.scale.value == 1.0) {
            l_VmImageDetailScreen.scale.value = 2.0;
          } else {
            l_VmImageDetailScreen.scale.value = 1.0;
          }
        },
        child: Center(
          child: GestureDetector(
            onScaleUpdate: (ScaleUpdateDetails details) {
              l_VmImageDetailScreen.scale.value = l_VmImageDetailScreen.initialScale.value * details.scale;
            },
            onScaleEnd: (ScaleEndDetails details) {
              l_VmImageDetailScreen.initialScale.value = l_VmImageDetailScreen.scale.value;
            },
            child: Hero(
              tag: image,
              child: Obx(() => Transform.scale(
                scale: l_VmImageDetailScreen.scale.value,
                child: Image(
                  image: image,
                  fit: BoxFit.contain,
                ),
              )),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
