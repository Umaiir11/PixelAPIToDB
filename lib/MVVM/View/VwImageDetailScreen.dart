import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ViewModel/VmImageDetailsScreen.dart';


class VwImageDetailScreen extends StatelessWidget {
  final List<ImageProvider> l_imagesList;
  final int initialIndex;

  VwImageDetailScreen({required this.l_imagesList, required this.initialIndex, required MemoryImage image});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VmImageDetailController());

    final PageController pageController = PageController(initialPage: initialIndex);
    int currentIndex = initialIndex;

    return Scaffold(
      appBar: AppBar(
        title: Text('Image'),
      ),
      body: GestureDetector(
        onDoubleTap: () {
          if (controller.scale.value == 1.0) {
            controller.scale.value = 2.0;
          } else {
            controller.scale.value = 1.0;
          }
        },
        child: Center(
          child: GestureDetector(
            onScaleUpdate: (ScaleUpdateDetails details) {
              controller.scale.value = controller.initialScale.value * details.scale;
            },
            onScaleEnd: (ScaleEndDetails details) {
              controller.initialScale.value = controller.scale.value;
            },
            child: Hero(
              tag: l_imagesList[currentIndex],
              child: PageView.builder(
                controller: pageController,
                itemCount: l_imagesList.length,
                onPageChanged: (index) {
                  currentIndex = index;
                },
                itemBuilder: (context, index) {
                  return Obx(() => Transform.scale(
                    scale: controller.scale.value,
                    child: Image(
                      image: l_imagesList[index],
                      fit: BoxFit.contain,
                    ),
                  ));
                },
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
