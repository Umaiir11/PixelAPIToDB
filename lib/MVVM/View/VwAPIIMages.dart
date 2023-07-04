import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../ViewModel/VmHome.dart';

class VwApiImages extends StatelessWidget {
  final VmHome controller = Get.put(VmHome());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image List'),
      ),
         body: Obx(
        () {
      if (controller.l_memoryImages == null) {
        // Show loading indicator if l_memoryImages is null
        return Center(child: CircularProgressIndicator());
      } else if (controller.l_memoryImages!.isEmpty) {
        // Show empty state if l_memoryImages is empty
        return Center(child:CircularProgressIndicator());
      } else {
        // Display GridView when l_memoryImages has images
        return GridView.builder(
          shrinkWrap: true,
          itemCount: controller.l_memoryImages!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, lListindex) {
            final image = controller.l_memoryImages![lListindex];

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image(
                  image: image,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }
    },
    ),



    );
  }
}
