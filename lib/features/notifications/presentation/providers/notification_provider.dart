import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/notification_repository_impl.dart';

import '../../domain/usecases/get_notifications.dart';
import '../../domain/usecases/mark_notification_as_read.dart';
import 'notification_state.dart';

final notificationRepositoryProvider =
Provider<NotificationRepositoryImpl>((ref) {
  return NotificationRepositoryImpl();
});

final getNotificationsProvider =
Provider<GetNotifications>((ref) {
  return GetNotifications(
    ref.read(notificationRepositoryProvider),
  );
});

final markNotificationAsReadProvider =
Provider<MarkNotificationAsRead>((ref) {
  return MarkNotificationAsRead(
    ref.read(notificationRepositoryProvider),
  );
});

class NotificationNotifier
    extends Notifier<NotificationState> {
  @override
  NotificationState build() {
    return const NotificationState();
  }

  Future<void> loadNotifications() async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    try {
      final notifications = await ref
          .read(getNotificationsProvider)
          .call();

      state = state.copyWith(
        isLoading: false,
        notifications: notifications,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> markAsRead(int id) async {
    try {
      await ref
          .read(markNotificationAsReadProvider)
          .call(id);

      await loadNotifications();
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
      );
    }
  }
}

final notificationProvider =
NotifierProvider<
    NotificationNotifier,
    NotificationState
>(
  NotificationNotifier.new,
);