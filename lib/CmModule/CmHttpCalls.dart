import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../MVVM/Model/ApiModel/ModImage.dart';
import 'cmGlobalVariables.dart';


class cmHttpCalls {
  Future<http.Response> Fnc_HttpWeb(String lControllerUrl) async {
    String lToken = 'LWI9pCIHOrkeUsh5jwyhqZOKwtBeGarmJGvKzrk3EBIVK067JR92jckq';
    Uri lUri = Uri.parse(cmGlobalVariables.Pb_WebAPIURL + lControllerUrl);
    Map<String, String> lStringContect = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      HttpHeaders.authorizationHeader: lToken,
    };
    final lResponse = await http.get(lUri, headers: lStringContect);
    return lResponse;
  }

}
