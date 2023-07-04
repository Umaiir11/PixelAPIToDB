import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import '../MVVM/Model/DbModel/ModDBIMages.dart';
import '../MVVM/Model/ModImages.dart';
import '../QueryGen/QueryGenAPIIMage.dart';
import '../QueryGen/QueryGenImage.dart';
import '../cmModule/DbHelper/DbHelperClass.dart';

class DAL_APIImage extends GetxController {
  Future<bool> Fnc_Cud(List<ModDBImage> lModDBImageList) async {
    try {
      Database? lDatabase = await DBHelper().FncGetDatabaseIns();
      List<String> l_Query = await QueryGenImageApi().FncApiImageQueryGen(lModDBImageList);
      final batch = lDatabase!.batch();


      for (String query in l_Query) {
        batch.execute(query);
      }


      await batch.commit();
      return true; // Queries executed successfully
    } catch (e) {
      print('Error executing queries: $e');
      return false; // Queries failed to execute
    }
  }


  Future<List<ModDBImage>> Fnc_Read() async {
    try {
      Database? lDatabase = await DBHelper().FncGetDatabaseIns();

      String lQuery = "SELECT DISTINCT Image FROM VW_TBU_ApiImage";

      List<Map<String, dynamic>> lFetchedData = await lDatabase!.rawQuery(lQuery);

      List<ModDBImage> lTest = [];
      for (var map in lFetchedData) {
        String image = map['Image'];

        // Check if the image already exists in the list
        bool isDuplicate = lTest.any((item) => item.Pr_listImages == image);

        if (!isDuplicate) {
          ModDBImage lModDBImage = ModDBImage(Pr_listImages: image);
          lTest.add(lModDBImage);
        }
      }

      return lTest;
    } catch (e) {
      // Throw an exception
      throw Exception('An error occurred while reading data: $e');
    }
  }


}
