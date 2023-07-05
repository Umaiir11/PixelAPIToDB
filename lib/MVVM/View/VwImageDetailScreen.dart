import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ViewModel/VmImageDetailsScreen.dart';


class VwImageDetailScreen extends StatelessWidget {
  final ImageProvider image;

  //Constructor that accept these things
  VwImageDetailScreen({required this.image});
  @override
  Widget build(BuildContext context) {
    final l_VmImageDetailController = Get.put(VmImageDetail());



    return Scaffold(
      appBar: AppBar(
        title: Text('Image'),
      ),
      body: GestureDetector(
        onDoubleTap: () {
          if (l_VmImageDetailController.scale.value == 1.0) {
            l_VmImageDetailController.scale.value = 2.0;
          } else {
            l_VmImageDetailController.scale.value = 1.0;
          }
        },
        child: Center(
          child: GestureDetector(
            onScaleUpdate: (ScaleUpdateDetails details) {
              l_VmImageDetailController.scale.value = l_VmImageDetailController.initialScale.value * details.scale;
            },
            onScaleEnd: (ScaleEndDetails details) {
              l_VmImageDetailController.initialScale.value = l_VmImageDetailController.scale.value;
            },
            child: Hero(
              tag: image,
              child: Obx(() => Transform.scale(
                scale: l_VmImageDetailController.scale.value,
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
