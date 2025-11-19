class AppNotification {
  final String title;
  final String description;
  final String time;
  final bool read;
  final String icon;
  final String color;

  AppNotification({
    required this.title,
    required this.description,
    required this.time,
    required this.read,
    required this.icon,
    required this.color,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      time: json["time"] ?? "",
      read: json["read"] ?? false,
      icon: json["icon"] ?? "info",
      color: json["color"] ?? "blue",
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "time": time,
        "read": read,
        "icon": icon,
        "color": color,
      };
}
