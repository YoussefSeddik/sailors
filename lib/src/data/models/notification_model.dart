class NotificationModel {
  final String? title;
  final String? desc;
  final String? image;

  NotificationModel({this.title, this.desc, this.image});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      desc: json['desc'],
      image: json['image'],
    );
  }
}
