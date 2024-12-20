class UserData {
  final String name;
  final int age;
  final String message;

  UserData({required this.name, required this.age, required this.message});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'] as String,
      age: json['age'] as int,
      message: json['message'] as String,
    );
  }
}
