class Modimamge {
  Modimamge({
    this.Pr_Image,
    this.Pr_Operation

  });

  String? Pr_Image;
  int? Pr_Operation;


  Map<String, dynamic> UserToJson() {
    final jsonMap = <String, dynamic>{};
    if (Pr_Image != null) jsonMap["Pr_Image"] = Pr_Image!;
    if (Pr_Operation != null) jsonMap["Pr_Operation"] = Pr_Operation!;

    return jsonMap;
  }
}
