class User {
  String id;
  String age;
  String city;
  String firstName;
  String lastName;
  String gender;
  String professional;
  String email;
  String username;
  String password;
  String createdAt;
  String deletedAt;
  String formatDate;

  User(
      this.age,
      this.city,
      this.createdAt,
      this.deletedAt,
      this.email,
      this.firstName,
      this.gender,
      this.lastName,
      this.password,
      this.professional,
      this.username) {}

  Map<String, dynamic> toJson() => {
        'id': id,
        'age': age,
        'city': city,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'professional': professional,
        'email': email,
        'username': username,
        'password': 'HoldTheDoor',
        'createdAt': formatDate,
        'deletedAt': 'null',
      };
}
