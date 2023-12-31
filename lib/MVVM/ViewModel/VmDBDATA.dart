import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../DAL/DAL_APIImages.dart';
import '../Model/DbModel/ModDBIMages.dart';
import 'VmHome.dart';

class VmDBData extends GetxController {
  final VmHome l_VmHome = Get.find<VmHome>();

int? l_SelectedIndex;
  RxList<ModDBImage> l_RxListModImage = <ModDBImage>[].obs;

  Future<bool> FetchDB_DATA() async {
    List<ModDBImage> lListmoddefinecustomer = await DAL_APIImage().Fnc_Read();
    l_RxListModImage.clear(); // Clear the list before adding the fetched data
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
  FncSelectedImageValue(int l_selectedindex){
   l_SelectedIndex =  l_selectedindex;


  }

  BTNDelete_Click() async {
    l_VmHome.G_Operation=3;
    await Fnc_CUD();
  }



  Future<bool> Fnc_CUD() async {
    if (l_SelectedIndex == null) {
      return false; // or handle the error in an appropriate way
    }

    String? l_image = l_RxListModImage[l_SelectedIndex!].Pr_listImages;
    List<ModDBImage> lModDBImageList = [];

    ModDBImage selectedModel = l_VmHome.Fnc_SetModel_DATA()![l_SelectedIndex!];
    selectedModel.Pr_listImages = l_image;

    lModDBImageList.add(selectedModel);

    bool isSuccess = await DAL_APIImage().Fnc_Cud(lModDBImageList);
    return isSuccess;
  }


   FncDeleteImage(int selectedIndex) {
    // Remove the image at the selected index from the list
    if (l_RxListModImage != null && selectedIndex >= 0 && selectedIndex < l_RxListModImage.length) {
      l_RxListModImage.removeAt(selectedIndex);
    }
  }

  }




