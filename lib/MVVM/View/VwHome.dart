import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_list/MVVM/ViewModel/VmDBDATA.dart';
import 'package:image_list/MVVM/ViewModel/VmHome.dart';
import 'package:image_list/cmModule/DbHelper/DbHelperClass.dart';

import '../../Routing/AppRoutes.dart';

class VwHome extends StatefulWidget {
  const VwHome({super.key});

  @override
  State<VwHome> createState() => _VwHomeState();
}

class _VwHomeState extends State<VwHome> {
  @override
  final  l_VmHome = Get.put(VmHome());
  final l_VmDBData =   Get.put(VmDBData());

  void initState() {
    // TODO: implement initState
    super.initState();
    DBHelper().FncCreateDataBase();
    l_VmHome.Sb_ResetForm();

  }
  Widget build(BuildContext context) {

    Widget _WidgetportraitMode(double PrHeight, PrWidth) {
      return Scaffold(
        body: Container(
          height: PrHeight,
          width: PrWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/bk.png"), fit: BoxFit.cover),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
              ],
              stops: [0.1, 0.5, 0.7, 0.9],
            ),
          ),
          child: Column(
            children: [

              SizedBox(height: PrHeight*0.40 ,),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.VwImage);
                    },
                    child: const Text("Upload Image!")),
              ),
              SizedBox(height: PrHeight*0.02 ,),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      l_VmHome.BTNApiFetchImages();
                      Get.toNamed(AppRoutes.VwApiImage);
                      l_VmHome.l_memoryImages.clear();
                    },
                    child: const Text("Ftech Images!")),
              ),
              SizedBox(height: PrHeight*0.02 ,),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                     l_VmDBData.BTNFetch();

                      Get.toNamed(AppRoutes.VwDBData);
                    },
                    child: const Text("DB Images!")),
              ),

            ],
          ),
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
