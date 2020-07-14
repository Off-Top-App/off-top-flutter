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
      this.password,
      this.profession,
      this.username);

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

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'city': city,
        'age': age,
        'gender': gender,
        'profession': profession,
        'email': email,
        'username': username,
        'password': 'HoldTheDoor',
        'createdAt': createdAt,
        'deletedAt': null,
      };
}
