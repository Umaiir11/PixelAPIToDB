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


class VmImage extends GetxController {

  int? G_Operation;
  RxString Pb_ImageString = RxString('');
  Rx<File?> G_compressedImage = Rx<File?>(null);
  RxInt G_compressedSize = 0.obs;
  RxString Pr_imageName = RxString('');
  RxList<Modimamge> l_RxListModImage = <Modimamge>[].obs;


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

  Future<bool> FncUserImage() async {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File compressedImage = await FlutterNativeImage.compressImage(
        pickedFile.path,
        quality: 70,
        targetHeight: 500,
        targetWidth: 500,
      );

      int compressedSize = await compressedImage.length();
      G_compressedSize.value = compressedSize;
      //print('Compressed size: ${compressedSize ~/ 1024} KB');

      Pr_imageName.value = pickedFile.path
          .split('/')
          .last;
      G_compressedImage.value = compressedImage;

      //ImageExtention
      String imageExtension = path.extension(pickedFile.path);
      print('File extension: $imageExtension');


      // Convert compressed image to a base64 string
      List<int> bytes = await compressedImage.readAsBytes();
      Pb_ImageString.value = base64Encode(bytes);
      // print('Base64 image: $base64Image');

      return true;
    }

    return false;
  }


  Modimamge Fnc_SetModel_DATA() {
    Modimamge l_Modimamge = Modimamge();
    l_Modimamge.Pr_Operation = G_Operation;
    l_Modimamge.Pr_Image = Pb_ImageString.value;

    return l_Modimamge;
  }

  Sb_ResetForm() {
    G_Operation = 1;
  }

  Future<bool> Fnc_CUD() async {
    Modimamge l_Modimamge = Fnc_SetModel_DATA();
    if (await DAL_Image().Fnc_Cud(l_Modimamge) == true) {
      return true;
    }
    return false;
  }

  Future<void> BTNUploadd() async {
    bool hasPermissions = await FncPermissions();

    if (hasPermissions) {
      bool hasUserImage = await FncUserImage();

      if (hasUserImage) {
        await Fnc_CUD();

        Get.snackbar("Alert", "Image Saved On DB");
      } else {
        Get.snackbar("Alert", "Upload image");
      }
    } else {
      Get.snackbar("Alert", "Permission denied");
    }
  }

  Future<void> BTNFetch() async {
    await FetchDB_DATA();
  }


  Future<bool> FetchDB_DATA() async {
    List<Modimamge> lListmoddefinecustomer = await DAL_Image().Fnc_Read();
    l_RxListModImage.addAll(lListmoddefinecustomer);
    return true;
  }


  Future<void> Fnc_ImagesAPICall() async {
    List<Photo>? l_listImages =
    new List<Photo>.empty(growable: true);
    l_listImages = await Sl_ImagesList().Fnc_Images();
    print(l_listImages);
    print(l_listImages);
  }
}
