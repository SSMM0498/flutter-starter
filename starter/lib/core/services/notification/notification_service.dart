import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static final LocalNotificationService _instance = LocalNotificationService._internal();
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();

  factory LocalNotificationService() {
    return _instance;
  }

  LocalNotificationService._internal();

//   on tap on any notification
//   void onNotificationTap(NotificationResponse notificationResponse) {
//     onClickNotification.value.add(notificationResponse.payload!);
//   }

  // initialize the local notifications
  Future init(void Function(String?) onData) async {
    print("🔔 Init notification service");

    // Android Settings
    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS Settings
    final initializationSettingsDarwin = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    // Linux Settings
    const initializationSettingsLinux = LinuxInitializationSettings(defaultActionName: 'Open notification');

    // Settings
    final settings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux,
    );

    _localNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();

    _localNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestExactAlarmsPermission();

    _localNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onSelectNotification,
    );

    var initialNotification = await _localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (initialNotification?.didNotificationLaunchApp == true) {
      final payload = initialNotification?.notificationResponse?.payload;
      onData(payload);
    }
  }

  NotificationDetails _notificationDetails(String channelName) {
    final androidNotificationDetails = AndroidNotificationDetails(
      'starter-app-id',
      channelName,
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.max,
      ticker: 'ticker',
      playSound: true,
    );

    const DarwinNotificationDetails iosNotificationDetails = DarwinNotificationDetails();

    return NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  // show a simple notification
  Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    final notificationDetails = _notificationDetails('starter-app_simple_notif');
    await _localNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  // to show periodic notification at regular interval
  Future showPeriodicNotifications({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    final notificationDetails = _notificationDetails('starter-app_periodic_notif');
    await _localNotificationsPlugin.periodicallyShow(
      id,
      title,
      body,
      RepeatInterval.weekly,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );
  }

  // to schedule a local notification
  Future showScheduleNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
    required tz.TZDateTime scheduledDate,
  }) async {
    final notificationDetails = _notificationDetails('starter-app_schedule_notif');
    await _localNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      payload: payload,
    );
  }

  void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) {
    print('🔔 New notification id > $id');
  }

  void onSelectNotification(NotificationResponse? notificationResponse) {
    if (notificationResponse != null && notificationResponse.payload != null) {
      onNotificationClick.add(notificationResponse.payload);
    }
  }

  // close a specific channel notification
  Future cancel(int id) async {
    await _localNotificationsPlugin.cancel(id);
  }

  // close all the notifications available
  Future cancelAll() async {
    await _localNotificationsPlugin.cancelAll();
  }
}
