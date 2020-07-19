class User {
  User(
    this.age,
    this.city,
    this.createdAt,
    this.deletedAt,
    this.email,
    this.firstName,
    this.gender,
    this.lastName,
    this.profession,
    this.username
  );

  String age;
  String city;
  String firstName;
  String lastName;
  String gender;
  String profession;
  String email;
  String username;
  String createdAt;
  String deletedAt;

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'city': city,
        'age': age,
        'gender': gender,
        'profession': profession,
        'email': email,
        'username': username,
        'created_at': createdAt,
        'deletedAt': null,
      };
}
