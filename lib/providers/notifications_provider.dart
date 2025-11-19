import 'package:flutter/material.dart';

class NotificationsProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'Nueva Tarea Asignada',
      'description': 'Se te ha asignado una nueva tarea de matemáticas',
      'time': 'Hace 2 horas',
      'read': false,
      'icon': Icons.assignment,
      'color': Colors.blue,
    },
    {
      'title': 'Recordatorio de Sesión',
      'description': 'Tu sesión con el mentor comienza en 30 minutos',
      'time': 'Hace 4 horas',
      'read': false,
      'icon': Icons.people,
      'color': Colors.purple,
    },
    {
      'title': 'Logro Desbloqueado',
      'description': 'Felicidades, completaste 10 tareas esta semana',
      'time': 'Hace 1 día',
      'read': true,
      'icon': Icons.star,
      'color': Colors.amber,
    },
  ];

  List<Map<String, dynamic>> get notifications => List.unmodifiable(_notifications);

  int get unreadCount => _notifications.where((n) => n['read'] == false).length;

  void markAsRead(int index) {
    if (index >= 0 && index < _notifications.length) {
      _notifications[index]['read'] = true;
      notifyListeners();
    }
  }

  void markAsUnread(int index) {
    if (index >= 0 && index < _notifications.length) {
      _notifications[index]['read'] = false;
      notifyListeners();
    }
  }

  void deleteNotification(int index) {
    if (index >= 0 && index < _notifications.length) {
      _notifications.removeAt(index);
      notifyListeners();
    }
  }

  void addNotification(Map<String, dynamic> notification) {
    _notifications.insert(0, notification);
    notifyListeners();
  }

  void clearAllNotifications() {
    _notifications.clear();
    notifyListeners();
  }

  void markAllAsRead() {
    for (var notification in _notifications) {
      notification['read'] = true;
    }
    notifyListeners();
  }
}
