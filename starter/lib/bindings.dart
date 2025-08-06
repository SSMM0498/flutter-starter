import 'package:get/get.dart';
import 'package:starter/core/controllers/network_manager.dart';
import 'package:starter/core/controllers/notification_controller.dart';
import 'package:starter/core/services/device/device_access_service.dart';
import 'package:starter/data/repository/user_repository.dart';
import 'package:starter/usecase/user/controllers/user_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager(), permanent: true);
    Get.put(UserRepository(), permanent: true);
    Get.put(UserController(), permanent: true);
    Get.put(NotificationController(), permanent: true);
    Get.put(DeviceAccessService(), permanent: true);
  }
}