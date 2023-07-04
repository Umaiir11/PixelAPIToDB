import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../ServiceLayer/Sl_Images.dart';
import '../Model/ApiModel/ModImage.dart';

class VmHome extends GetxController {
  List<Photo>? l_listImages;
  RxList<MemoryImage> l_memoryImages = <MemoryImage>[].obs;


  Fnc_ImagesAPICall() async {
    l_listImages = await Sl_ImagesList().Fnc_Images();
    FncImageConversion();
  }

  FncImageConversion() async {
    if (l_listImages != null && l_listImages!.isNotEmpty) {

      for (Photo item in l_listImages!) {
        String? l_tinyImageUrl = item.src?.tiny;

        if (l_tinyImageUrl != null) {
          final response = await http.get(Uri.parse(l_tinyImageUrl));

          if (response.statusCode == 200) {
            final Uint8List l_decodedBytes = response.bodyBytes;
            final MemoryImage l_memoryImage = MemoryImage(l_decodedBytes);

            l_memoryImages?.add(l_memoryImage);
          }
        }
      }
    }
  }
}

