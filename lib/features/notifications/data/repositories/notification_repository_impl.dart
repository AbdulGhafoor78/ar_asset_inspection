import '../../domain/entities/notification.dart';
import '../../domain/repositories/notification_repository.dart';
import '../models/notification_model.dart';

class NotificationRepositoryImpl
    implements NotificationRepository {
  final List<Notification> _notifications = [
    NotificationModel(
      id: 1,
      title: 'Critical Maintenance Required',
      message:
      'Power Generator GEN-001 requires immediate maintenance.',
      type: 'Critical',
      isRead: false,
      createdAt: DateTime.now(),
    ),
    NotificationModel(
      id: 2,
      title: 'Inspection Completed',
      message:
      'Inspection #1 has been completed successfully.',
      type: 'Inspection',
      isRead: false,
      createdAt: DateTime.now(),
    ),
    NotificationModel(
      id: 3,
      title: 'Maintenance Pending',
      message:
      'A maintenance task is pending for Industrial Pump PUMP-001.',
      type: 'Maintenance',
      isRead: true,
      createdAt: DateTime.now(),
    ),
  ];

  @override
  Future<List<Notification>> getNotifications() async {
    return List<Notification>.from(_notifications);
  }

  @override
  Future<void> markAsRead(int id) async {
    final index = _notifications.indexWhere(
          (notification) => notification.id == id,
    );

    if (index == -1) {
      throw Exception('Notification not found');
    }

    final notification = _notifications[index];

    _notifications[index] = NotificationModel(
      id: notification.id,
      title: notification.title,
      message: notification.message,
      type: notification.type,
      isRead: true,
      createdAt: notification.createdAt,
    );
  }
}