
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


  Future<String> FncGenCrudQueriesApiImage(ModDBImage l_ModSingleMulti) async {
    try {

      switch (l_ModSingleMulti.Pr_Operation) {
        case DBOPP.insert:
          return '''
            INSERT INTO TBU_ApiImage (
             Image,ISD
            ) VALUES (
              '${l_ModSingleMulti.Pr_listImages}','false'
            )
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
