import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../DAL/DAL_APIImages.dart';
import '../Model/DbModel/ModDBIMages.dart';

class VmDBData{

  RxList<ModDBImage> l_RxListModImage = <ModDBImage>[].obs;

  Future<bool> FetchDB_DATA() async {
    List<ModDBImage> lListmoddefinecustomer = await DAL_APIImage().Fnc_Read();
    l_RxListModImage.addAll(lListmoddefinecustomer);
    return true;
  }

  Future<void> BTNFetch() async {
    await FetchDB_DATA();
  }

  MemoryImage FncConvertImage(int index) {
    final l_image = l_RxListModImage[index];
    String l_ListImage = l_image.Pr_listImages!;
    Uint8List l_DecodedBytes = base64Decode(l_ListImage);
    return MemoryImage(l_DecodedBytes);
  }

  List<MemoryImage> FncConvertImages() {
    List<MemoryImage> images = [];
    for (int index = 0; index < l_RxListModImage!.length; index++) {
      final item = l_RxListModImage[index];
      String l_ListImage = item.Pr_listImages!;
      Uint8List l_DecodedBytes = base64Decode(l_ListImage);
      MemoryImage lMemoryImage = MemoryImage(l_DecodedBytes);
      images.add(lMemoryImage);
    }
    return images;
  }

}