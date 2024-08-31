import 'package:get/get.dart';
import 'package:starter/core/services/notification/notification_service.dart';

class NotificationController extends GetxController {
  late final LocalNotificationService notify;

  void _listenToNotification() => notify.onNotificationClick.stream.listen(_onNotificationListener);

  void _onNotificationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('🔔 Process notification - payload $payload');

      // Parse the payload

      notify.onNotificationClick.add("");
    }
  }

  @override
  void onInit() async {
    notify = LocalNotificationService();
    notify.init(_onNotificationListener);
    _listenToNotification();
    super.onInit();
  }
}
