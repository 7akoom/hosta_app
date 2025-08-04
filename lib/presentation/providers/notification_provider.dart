import 'package:flutter/material.dart';
import 'package:hosta_app/data/models/notification_model.dart';
import 'package:hosta_app/data/datasources/notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationService _notificationService;

  NotificationProvider([NotificationService? notificationService])
    : _notificationService = notificationService ?? NotificationService();

  List<NotificationModel> _notifications = [];
  bool _isLoading = false;
  String? _error;
  int _currentPage = 1;
  bool _hasMorePages = true;

  // getters
  List<NotificationModel> get notifications => _notifications;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasMorePages => _hasMorePages;
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  // جلب الإشعارات
  Future<void> fetchNotifications({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _hasMorePages = true;
    }

    if (_isLoading || (!_hasMorePages && !refresh)) return;

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final newNotifications = await _notificationService.getNotifications(
        page: _currentPage,
      );

      if (refresh) {
        _notifications = newNotifications;
      } else {
        _notifications.addAll(newNotifications);
      }

      _hasMorePages = newNotifications.isNotEmpty;
      if (_hasMorePages) _currentPage++;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // تحديث حالة إشعار إلى مقروء
  Future<void> markAsRead(String notificationId) async {
    try {
      await _notificationService.markAsRead(notificationId);

      final index = _notifications.indexWhere((n) => n.id == notificationId);
      if (index != -1) {
        _notifications[index] = _notifications[index].copyWith(isRead: true);
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // تحديث حالة جميع الإشعارات إلى مقروءة
  Future<void> markAllAsRead() async {
    try {
      await _notificationService.markAllAsRead();

      _notifications = _notifications
          .map((n) => n.copyWith(isRead: true))
          .toList();

      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // حذف إشعار
  Future<void> deleteNotification(String notificationId) async {
    try {
      await _notificationService.deleteNotification(notificationId);

      _notifications.removeWhere((n) => n.id == notificationId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // حذف جميع الإشعارات
  Future<void> deleteAllNotifications() async {
    try {
      await _notificationService.deleteAllNotifications();

      _notifications.clear();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // إعادة تعيين حالة الخطأ
  void resetError() {
    _error = null;
    notifyListeners();
  }
}
