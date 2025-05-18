class SupportRequestParams {
  final String title;
  final String name;
  final String phone;
  final String details;

  const SupportRequestParams({
    required this.title,
    required this.name,
    required this.phone,
    required this.details,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'name': name,
      'phone': phone,
      'details': details,
    };
  }
}