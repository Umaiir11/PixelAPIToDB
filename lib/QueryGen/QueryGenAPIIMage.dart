
import 'package:image_list/MVVM/Model/DbModel/ModDBIMages.dart';

import '../../Enum/EnumCrud.dart';


class QueryGenImageApi {
  Future<List<String>> FncApiImageQueryGen(List<ModDBImage> list_ModSingleMulti) async {
    try {
      List<String> lQueries = [];

      String? Query;
      for (ModDBImage l_ModSingleMulti in list_ModSingleMulti) {
        Query =  await FncGenCrudQueriesApiImage(l_ModSingleMulti);
        lQueries.add(Query);
      }
      return lQueries;
    } catch (e) {
      throw Exception('An error occurred while generating CRUD queries: $e');
    }
  }


  Future<String> FncGenCrudQueriesApiImage(ModDBImage l_ModDBImage) async {
    try {

      switch (l_ModDBImage.Pr_Operation) {
        case DBOPP.insert:
          return '''
            INSERT INTO TBU_ApiImage (
             Image,ISD
            ) VALUES (
              '${l_ModDBImage.Pr_listImages}','false'
            )
          ''';
        case DBOPP.delete:
        // Delete operation based on PKGUID
          final String lWhereclause = "WHERE Image = '${l_ModDBImage.Pr_listImages}'";
          return '''
          UPDATE TBU_ApiImage
          SET ISD = 'true' $lWhereclause
        ''';


        default:
        // Handle unrecognized operation
          break;
      }
      return "";
    } catch (e) {
      throw Exception('An error occurred while generating CRUD queries: $e');
    }
  }

}
