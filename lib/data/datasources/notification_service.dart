import 'package:hosta_app/data/models/notification_model.dart';

class NotificationService {
  // سيتم استبدال هذا بعنوان الباك إند الحقيقي
  static const String baseUrl = 'https://api.example.com';

  // جلب قائمة الإشعارات
  Future<List<NotificationModel>> getNotifications({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      // TODO: استبدل هذا بالاتصال الحقيقي بالباك إند
      // final response = await http.get(
      //   Uri.parse('$baseUrl/notifications?page=$page&limit=$limit'),
      //   headers: {'Authorization': 'Bearer $token'},
      // );
      // if (response.statusCode == 200) {
      //   final List<dynamic> data = json.decode(response.body)['data'];
      //   return data.map((json) => NotificationModel.fromJson(json)).toList();
      // }

      // بيانات تجريبية
      return [
        NotificationModel(
          id: '1',
          type: 'welcome',
          title: 'Hosta',
          message:
              'Welcome Ahmed! Thank you for using Hosta. Explore our diverse services and request skilled professionals through our app.',
          createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
        NotificationModel(
          id: '2',
          type: 'booking_confirmation',
          title: 'Hosta',
          message:
              'Booking #234567 for Gardening Service has been confirmed by provider Hassan Ali.',
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          data: {
            'booking_id': '234567',
            'service_id': '1',
            'provider_id': '123',
          },
        ),
        NotificationModel(
          id: '3',
          type: 'service_completed',
          title: 'Hosta',
          message:
              'Service #789012 has been completed by provider Ali Hassan. Please confirm the payment amount.',
          createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
          data: {
            'booking_id': '789012',
            'provider_name': 'Ali Hassan',
            'amount': 150.00,
          },
        ),
      ];
    } catch (e) {
      throw Exception('Failed to load notifications: $e');
    }
  }

  // تحديث حالة الإشعار إلى مقروء
  Future<void> markAsRead(String notificationId) async {
    try {
      // TODO: استبدل هذا بالاتصال الحقيقي بالباك إند
      // final response = await http.patch(
      //   Uri.parse('$baseUrl/notifications/$notificationId/read'),
      //   headers: {'Authorization': 'Bearer $token'},
      // );
      // if (response.statusCode != 200) {
      //   throw Exception('Failed to mark notification as read');
      // }
    } catch (e) {
      throw Exception('Failed to mark notification as read: $e');
    }
  }

  // تحديث حالة جميع الإشعارات إلى مقروءة
  Future<void> markAllAsRead() async {
    try {
      // TODO: استبدل هذا بالاتصال الحقيقي بالباك إند
      // final response = await http.patch(
      //   Uri.parse('$baseUrl/notifications/read-all'),
      //   headers: {'Authorization': 'Bearer $token'},
      // );
      // if (response.statusCode != 200) {
      //   throw Exception('Failed to mark all notifications as read');
      // }
    } catch (e) {
      throw Exception('Failed to mark all notifications as read: $e');
    }
  }

  // حذف إشعار
  Future<void> deleteNotification(String notificationId) async {
    try {
      // TODO: استبدل هذا بالاتصال الحقيقي بالباك إند
      // final response = await http.delete(
      //   Uri.parse('$baseUrl/notifications/$notificationId'),
      //   headers: {'Authorization': 'Bearer $token'},
      // );
      // if (response.statusCode != 200) {
      //   throw Exception('Failed to delete notification');
      // }
    } catch (e) {
      throw Exception('Failed to delete notification: $e');
    }
  }

  // حذف جميع الإشعارات
  Future<void> deleteAllNotifications() async {
    try {
      // TODO: استبدل هذا بالاتصال الحقيقي بالباك إند
      // final response = await http.delete(
      //   Uri.parse('$baseUrl/notifications'),
      //   headers: {'Authorization': 'Bearer $token'},
      // );
      // if (response.statusCode != 200) {
      //   throw Exception('Failed to delete all notifications');
      // }
    } catch (e) {
      throw Exception('Failed to delete all notifications: $e');
    }
  }
}
