class UserModel {
  final String id;
  final String fullname;
  final String address;
  final String phone;
  final String email;
  final String? image; // ✅ Ensure it's nullable

  UserModel({
    required this.id,
    required this.fullname,
    required this.address,
    required this.phone,
    required this.email,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["_id"],
      fullname: json["fullname"] ?? "Unknown",
      address: json["address"] ?? "No Address",
      phone: json["phone"] ?? "No Phone",
      email: json["email"] ?? "No Email",
      image: json["image"] != null && json["image"].toString().isNotEmpty
          ? json["image"] as String
          : null, // ✅ Directly use Cloudinary URL
    );
  }
}
