import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:mentoria/providers/theme_provider.dart';
import 'package:mentoria/providers/notifications_provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, NotificationsProvider>(
      builder: (context, themeProvider, notificationsProvider, _) {
        final isDarkMode = themeProvider.isDarkMode;
        final selectedLanguage = themeProvider.selectedLanguage;
        final bgColor = isDarkMode ? const Color(0xFF0f0f0f) : Colors.white;
        final textColor = isDarkMode ? Colors.white : const Color(0xFF0b1e6b);
        final cardBgColor = isDarkMode ? const Color(0xFF1a1a1a) : Colors.grey[50];
        final borderColor = isDarkMode ? Colors.grey[800] : Colors.grey[100];
        final subtextColor = isDarkMode ? Colors.grey[500] : Colors.grey[600];

        final texts = {
          'es': {
            'notificaciones': 'Notificaciones',
            'sinNotificaciones': 'No hay notificaciones',
            'marcarLeida': 'Marcar como leída',
            'marcarNoLeida': 'Marcar como no leída',
            'eliminar': 'Eliminar',
          },
          'en': {
            'notificaciones': 'Notifications',
            'sinNotificaciones': 'No notifications',
            'marcarLeida': 'Mark as read',
            'marcarNoLeida': 'Mark as unread',
            'eliminar': 'Delete',
          },
        };

        String getText(String key) {
          return texts[selectedLanguage]?[key] ?? '';
        }

        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: bgColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: textColor),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              getText('notificaciones'),
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: textColor,
                letterSpacing: -0.5,
              ),
            ),
            centerTitle: false,
          ),
          body: notificationsProvider.notifications.isEmpty
              ? Center(
                  child: Text(
                    getText('sinNotificaciones'),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: subtextColor,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: notificationsProvider.notifications.length,
                  itemBuilder: (context, index) {
                    final notification =
                        notificationsProvider.notifications[index];
                    return GestureDetector(
                      onLongPress: () => _showNotificationOptions(
                        context,
                        index,
                        notification,
                        notificationsProvider,
                        getText,
                        isDarkMode,
                        textColor,
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: notification['read']
                              ? cardBgColor
                              : (isDarkMode
                                  ? const Color(0xFF1a2a3a)
                                  : Colors.blue[50]),
                          border: Border.all(
                            color: notification['read']
                                ? borderColor!
                                : Colors.blue[300]!,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(isDarkMode ? 0.1 : 0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (notification['color'] as Color)
                                    .withOpacity(0.15),
                              ),
                              child: Icon(
                                notification['icon'],
                                color: notification['color'],
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          notification['title'],
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: textColor,
                                          ),
                                        ),
                                      ),
                                      if (!notification['read'])
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFF8b5cf6),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    notification['description'],
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: subtextColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    notification['time'],
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      color: subtextColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                          .animate()
                          .slideX(
                            begin: 0.3,
                            duration: 500.ms,
                            delay: Duration(milliseconds: 100 * index),
                          )
                          .fadeIn(),
                    );
                  },
                ),
        );
      },
    );
  }

  void _showNotificationOptions(
    BuildContext context,
    int index,
    Map<String, dynamic> notification,
    NotificationsProvider provider,
    String Function(String) getText,
    bool isDarkMode,
    Color textColor,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor:
          isDarkMode ? const Color(0xFF1a1a1a) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              ListTile(
                leading: Icon(
                  notification['read'] ? Icons.mail_outline : Icons.done_all,
                  color: const Color(0xFF8b5cf6),
                  size: 24,
                ),
                title: Text(
                  notification['read']
                      ? getText('marcarNoLeida')
                      : getText('marcarLeida'),
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                onTap: () {
                  if (notification['read']) {
                    provider.markAsUnread(index);
                  } else {
                    provider.markAsRead(index);
                  }
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: Icon(
                  Icons.delete_outline,
                  color: Colors.red[500],
                  size: 24,
                ),
                title: Text(
                  getText('eliminar'),
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.red[500],
                  ),
                ),
                onTap: () {
                  provider.deleteNotification(index);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}