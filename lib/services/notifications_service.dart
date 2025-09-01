// notifications_service.dart
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:graduation_med_/models/dose_state.dart';
import 'package:graduation_med_/providers/medicine_provider.dart';
import 'package:provider/provider.dart';

class NotificationsService {
  static Future<void> initialize() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'medicine_channel',
          channelName: 'Medicine Reminders',
          channelDescription: 'Reminders for taking medicines',
          defaultColor: Colors.teal,
          importance: NotificationImportance.Max,
          ledColor: Colors.white,
        ),
      ],
      debug: true,
    );
  }

  static Future<void> requestPermission() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  // 🔔 إشعار بجرعة
  static Future<void> scheduleDoseNotification({
    required String userId,
    required String medicineId,
    required String medicineName,
    required int phaseIndex,
    required String doseId,
    required DateTime doseTime,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: doseTime.millisecondsSinceEpoch.remainder(100000),
        channelKey: 'medicine_channel',
        title: '💊 $medicineName',
        body: 'الجرعة المجدولة في ${doseTime.hour}:${doseTime.minute.toString().padLeft(2, '0')}',
        payload: {
          'userId': userId,
          'medicineId': medicineId,
          'phaseIndex': phaseIndex.toString(),
          'doseId': doseId,
        },
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'TAKEN',
          label: '✅ أخذت',
        ),
        NotificationActionButton(
          key: 'MISSED',
          label: '❌ لم آخذ',
        ),
        NotificationActionButton(
          key: 'SKIPPED',
          label: '🟤 إلغاء',
        ),
      ],
      schedule: NotificationCalendar.fromDate(date: doseTime),
    );
  }

  // 🎯 ربط الأزرار بالـ Provider
  static void listenNotificationActions(BuildContext context) {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: (receivedAction) async {
        final payload = receivedAction.payload;
        if (payload == null) return;

        final userId = payload['userId'];
        final medicineId = payload['medicineId'];
        final phaseIndexStr = payload['phaseIndex'];
        final doseId = payload['doseId'];

        if (userId == null || medicineId == null || phaseIndexStr == null || doseId == null) return;

        final phaseIndex = int.parse(phaseIndexStr);

        DoseState newState = DoseState.none;
        if (receivedAction.buttonKeyPressed == 'TAKEN') {
          newState = DoseState.taken;
        } else if (receivedAction.buttonKeyPressed == 'MISSED') {
          newState = DoseState.missed;
        } else if (receivedAction.buttonKeyPressed == 'SKIPPED') {
          newState = DoseState.cancelled;
        }

        // ✅ تحديث الحالة عبر البروفايدر
        context.read<MedicineProvider>().updateDoseStateFromNotification(
          userId: userId,
          medicineId: medicineId,
          phaseIndex: phaseIndex,
          doseId: doseId,
          newState: newState,
        );

        print("🔔 [Context] زر الإشعار → ${receivedAction.buttonKeyPressed}");
      },
    );
  }
}
