class User {
  final int id;
  final String email;
  final String userName;
  final String adresse;
  final String imagePath;
  final String password;
  final int role;

  User({
    required this.id,
    required this.userName,
    required this.email,
    required this.adresse,
    required this.password,
    required this.imagePath,
    required this.role
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id : json["id"],
      userName: json['userName'],
      email: json['email'],  
      adresse: json['adresse'],
      imagePath: json['imagePath'],
      password: json['password'],
      role: json['role']
    );
  }
}