import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_list/MVVM/ViewModel/VmDBDATA.dart';

import '../ViewModel/VmHome.dart';
import 'VwImageDetailScreen.dart';

class VwDBData extends StatelessWidget {
  final VmHome l_VmDBData = Get.put(VmHome());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Image List'),
        ),
        body:  Obx(() => GridView.builder(
          shrinkWrap: true,
          itemCount: l_VmDBData.l_RxListModImage!.length,



          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, lListindex) {
            final item = l_VmDBData.l_RxListModImage[lListindex];
            String l_ListImage = item.Pr_listImages!;
            Uint8List l_DecodedBytes = base64Decode(l_ListImage);
            MemoryImage lMemoryIMage = MemoryImage(l_DecodedBytes);

            return GestureDetector(
              onTap: () {
                // Handle the tap event here
                Get.to(() => ImageDetailScreen(image: lMemoryIMage));

              },

              child: Container(
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
                    image: lMemoryIMage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ))
    );
  }
}
