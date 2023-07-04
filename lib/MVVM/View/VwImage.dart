import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../ViewModel/VmImage.dart';

class VwImage extends StatefulWidget {
  const VwImage({super.key});

  @override
  State<VwImage> createState() => _VwImageState();
}

class _VwImageState extends State<VwImage> {
  @override
  final  l_VmImage = Get.put(VmImage());
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    l_VmImage.  Sb_ResetForm();

   }

  Widget build(BuildContext context) {
    Widget _WidgetportraitMode(double PrHeight, PrWidth) {
      return Scaffold(
          body: Column(
               children: [

                 Padding(
                   padding: EdgeInsets.only(
                     top: PrHeight * 0.10,
                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: [
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Center(
                             child: InkWell(
                               onTap: () async {
                               await l_VmImage.  BTNUploadd();
                               },
                               child: Obx(
                                     () =>
                                 l_VmImage.G_compressedImage.value != null
                                     ? Container(
                                   width: 120,
                                   height: 120,
                                   decoration: BoxDecoration(
                                     shape: BoxShape.circle,
                                     image: DecorationImage(
                                       image: FileImage(File(l_VmImage.G_compressedImage.value!.path)),
                                       fit: BoxFit.cover,
                                     ),
                                   ),
                                 )
                                     : SizedBox(
                                   width: 140,
                                   height: 120,
                                   child: Lottie.asset(
                                     'assets/upload.json',
                                     fit: BoxFit.cover,
                                   ),
                                 ),
                               ),
                             ),
                           ),
                           Center(
                             child: Obx(() => Text(l_VmImage.Pr_imageName.value)),
                           ),
                         ],
                       )

                     ],

                   ),
                 ),
                 Padding(
                   padding: EdgeInsets.only(
                     top: PrHeight * 0.10,
                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: [

                       ElevatedButton(
                           onPressed: () async {
                             l_VmImage.BTNFetch();
                           },
                           child: const FittedBox(
                             fit: BoxFit.scaleDown,
                             child: Text(
                               'Fetch Image from DB',
                               style: TextStyle(fontSize: 15),
                             ),
                           )),
                     ],

                   ),
                 ),
                SizedBox(height:  PrHeight*0.10,),
      Expanded(
      child: Obx(() => ListView.builder(
         shrinkWrap: true,
         itemCount: l_VmImage.l_RxListModImage.length,
          itemBuilder: (context, lListindex) {
           final item = l_VmImage.l_RxListModImage[lListindex];
           String l_ListImage = item.Pr_Image!;
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
                       )),
                          )

      ],



 ),

      );


    }
    return GestureDetector(
      onTap: () {
        //when tap anywhere on screen keyboard dismiss
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              //Get device's screen height and width.
              double height = constraints.maxHeight;
              double width = constraints.maxWidth;

              if (width >= 300 && width < 500) {
                return _WidgetportraitMode(height, width);
              } else {
                return _WidgetportraitMode(height, width);
              }
            },
          );
        },
      ),
    );
  }
}
