import 'package:flutter/cupertino.dart';

class ModDBImage {

  ModDBImage({
    this.Pr_listImages,
    this.Pr_Operation

  });

  String? Pr_listImages;
  int? Pr_Operation;


  Map<String, dynamic> UserToJson() {
    final jsonMap = <String, dynamic>{};
    if (Pr_listImages != null) jsonMap["Pr_listImages"] = Pr_listImages!;
    if (Pr_Operation != null) jsonMap["Pr_Operation"] = Pr_Operation!;

    return jsonMap;
  }
}
