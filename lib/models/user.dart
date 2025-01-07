class User {
  int id;
  String name;
  String email;

  User({
    this.id = 0,
    this.name = '',
    this.email = '',
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'] . json['last_name'],
    email: json['email'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email
  };
}