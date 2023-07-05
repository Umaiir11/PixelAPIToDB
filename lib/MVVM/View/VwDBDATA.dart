import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_list/MVVM/ViewModel/VmDBDATA.dart';
import 'VwImageDetailScreen.dart';

class VwDBData extends StatelessWidget {
  final VmDBData l_VmDBData = Get.put(VmDBData());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image List'),
      ),
      body: Obx(() => GridView.builder(
        shrinkWrap: true,
        itemCount: l_VmDBData.l_RxListModImage!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, lListindex) {
          MemoryImage lMemoryImage = l_VmDBData.FncConvertImage(lListindex);
          return GestureDetector(
            onTap: () {
              List<MemoryImage> l_ConvertedImagesList = l_VmDBData.FncConvertImages();
              Get.to(() => VwImageDetailScreen(
                image: lMemoryImage,
                l_imagesList: l_ConvertedImagesList,
                initialIndex: lListindex,
              ));
            },
            onLongPress: () {
              l_VmDBData.FncSelectedImageValue(lListindex);
              _WidgetshowDeleteConfirmationDialog(context);
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
                child: Hero(
                  tag: lMemoryImage, // Unique tag for each image
                  child: Image(
                    image: lMemoryImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      )),
    );
  }

  void _WidgetshowDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Image'),
          content: Text('Are you sure you want to delete this image?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                // Perform delete operation here
                l_VmDBData.BTNDelete_Click();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
