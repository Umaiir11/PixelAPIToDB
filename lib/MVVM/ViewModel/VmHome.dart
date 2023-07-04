import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_list/MVVM/Model/ApiModel/ModImage.dart';
import 'package:image_list/ServiceLayer/Sl_Images.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import '../../DAL/DAL_Image.dart';
import '../Model/ModImages.dart';


class VmHome extends GetxController {

  Future<void> Fnc_ImagesAPICall() async {
    List<Photo>? l_listImages =
    new List<Photo>.empty(growable: true);
    l_listImages = await Sl_ImagesList().Fnc_Images();
    print(l_listImages);
    print(l_listImages);
  }
}
