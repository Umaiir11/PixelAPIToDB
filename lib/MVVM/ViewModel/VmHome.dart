import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_list/MVVM/Model/DbModel/ModDBIMages.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../DAL/DAL_APIImages.dart';
import '../../ServiceLayer/Sl_Images.dart';
import '../Model/ApiModel/ModImage.dart';
import 'dart:convert';


class VmHome extends GetxController {
  List<Photo>? l_listImages;
  int? G_Operation;
  RxList<String> l_Base64Images = <String>[].obs;
  RxList<MemoryImage> l_memoryImages = <MemoryImage>[].obs;



  Future<bool>  Fnc_ImagesAPICall() async {
    l_listImages = await Sl_ImagesList().Fnc_Images();
    l_Base64Images = await FncImageConversion();
    if(l_Base64Images.isNotEmpty){
      return true;
    }
    return false;
  }


  Future<RxList<String>> FncImageConversion() async {
    RxList<String> l_base64Images = <String>[].obs;

    if (l_listImages != null && l_listImages!.isNotEmpty) {
      for (Photo item in l_listImages!) {
        String? l_tinyImageUrl = item.src?.large2x;

        if (l_tinyImageUrl != null) {
          final response = await http.get(Uri.parse(l_tinyImageUrl));

          if (response.statusCode == 200) {
            final Uint8List l_decodedBytes = response.bodyBytes;
            final String l_base64Image = base64Encode(l_decodedBytes);
            final MemoryImage l_memoryImage = MemoryImage(l_decodedBytes);

            l_memoryImages.add(l_memoryImage);

            l_base64Images.add(l_base64Image);
          }
        }
      }
    }

    return l_base64Images;
  }

  List<ModDBImage>? Fnc_SetModel_DATA() {
    List<ModDBImage>? lModDBImageList = [];

    for (String image in l_Base64Images) {
      ModDBImage l_ModDBImage = ModDBImage();
      l_ModDBImage.Pr_Operation = G_Operation;
      l_ModDBImage.Pr_listImages = image;

      lModDBImageList.add(l_ModDBImage);
    }

    return lModDBImageList;
  }
  Future<bool> FncPermissions() async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;

    if (androidInfo.version.sdkInt >= 33) {
      // Add the storage permissions
      final photosStatus = await Permission.photos.request();
      if (photosStatus.isGranted) {
        return true;
      }

      if (photosStatus.isDenied || photosStatus.isRestricted) {
        // Show a pop-up to request the photos permission
        await Permission.photos.request();
      }
    }
    // Request the storage permission
    final storageStatus = await Permission.storage.request();

    if (storageStatus.isGranted) {
      return true;
    }

    if (storageStatus.isDenied || storageStatus.isRestricted) {
      // Show a pop-up to request the permission
      await Permission.storage.request();
    }

    return false;
  }


    Future<bool> Fnc_CUD() async {

     if (await Fnc_ImagesAPICall() == true ){
       List<ModDBImage>? lModDBImageList = Fnc_SetModel_DATA();
       if (await DAL_APIImage().Fnc_Cud(lModDBImageList!)== true) {
         return true;
       }
     }

      return false;
    }

  Sb_ResetForm() {
    G_Operation = 1;
  }




  BTNApiFetchImages() async {
    FncPermissions();
    await Fnc_CUD() ;
  }


}

