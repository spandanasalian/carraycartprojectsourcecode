import 'package:get/get.dart';
import 'package:sdmecom/core/viewmodel/auth_viewmodel.dart';
import 'package:sdmecom/core/viewmodel/cart_viewmodel.dart';
import 'package:sdmecom/core/viewmodel/home_viewmodel.dart';
import 'package:sdmecom/core/viewmodel/network_viewmodel.dart';



class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => HomeViewModel());
    Get.put(CartViewModel());
    Get.lazyPut(() => NetworkViewModel());
  }
}
