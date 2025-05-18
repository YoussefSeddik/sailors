
class ContactUsParams {
  final String name;
  final String email;
  final String phone;
  final String details;

  const ContactUsParams({
    required this.name,
    required this.email,
    required this.phone,
    required this.details,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'details': details,
    };
  }
}
