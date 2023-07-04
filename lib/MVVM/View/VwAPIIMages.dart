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
      body:  Obx(() => ListView.builder(
        shrinkWrap: true,
        itemCount: controller.l_memoryImages!.length,
        itemBuilder: (context, lListindex) {
          final item = controller.l_memoryImages![lListindex];




          return    Container(
            width: 190,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,

            ),
          );
        },
      ))
    );
  }
}
