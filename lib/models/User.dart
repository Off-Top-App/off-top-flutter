class User {
  String id;
  String age;
  String city;
  String firstName;
  String lastName;
  String gender;
  String profession;
  String email;
  String username;
  String password;
  String createdAt;
  String deletedAt;

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
      this.profession,
      this.username) {}

  Map<String, dynamic> toJson() => {
        'id': id,
        'age': age,
        'city': city,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'profession': profession,
        'email': email,
        'username': username,
        'password': 'HoldTheDoor',
        'createdAt': createdAt,
        'deletedAt': 'null',
      };
}
