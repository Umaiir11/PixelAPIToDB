import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_list/MVVM/ViewModel/VmDBDATA.dart';

import '../ViewModel/VmHome.dart';

class VwDBData extends StatelessWidget {
  final VmHome l_VmDBData = Get.put(VmHome());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Image List'),
        ),
        body:  Obx(() => ListView.builder(
          shrinkWrap: true,
          itemCount: l_VmDBData.l_RxListModImage!.length,
          itemBuilder: (context, lListindex) {
            final item = l_VmDBData.l_RxListModImage[lListindex];
            String l_ListImage = item.Pr_listImages!;
            Uint8List l_DecodedBytes = base64Decode(l_ListImage);
            MemoryImage lMemoryIMage = MemoryImage(l_DecodedBytes);




            return    Container(
              width: 190,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: lMemoryIMage,
                ),
              ),
            );
          },
        ))
    );
  }
}
