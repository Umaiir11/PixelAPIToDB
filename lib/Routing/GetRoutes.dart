import 'package:get/get.dart';
import '../MVVM/View/VwHome.dart';
import '../MVVM/View/VwImage.dart';
import 'AppRoutes.dart';

class GetAppRoutes {
  static List<GetPage> Fnc_GetPages() {
    return [
      GetPage(name: AppRoutes.initialRoute, page: () => const VwHome()),
      GetPage(name: AppRoutes.VwImage, page: () => const VwImage()),

    ];
  }
}