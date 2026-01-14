class AppNotification {
  final String id;
  final String title;
  final String body;
  final bool isRead;

  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    this.isRead = false,
  });

  AppNotification copyWith({bool? isRead}) {
    return AppNotification(
      id: id,
      title: title,
      body: body,
      isRead: isRead ?? this.isRead,
    );
  }
}
