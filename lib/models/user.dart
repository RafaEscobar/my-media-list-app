class User {
  int id;
  String name;
  String email;
  String token;

  User({
    this.id = 0,
    this.name = '',
    this.email = '',
    this.token = ''
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] ?? 0,
    name: '${json['name'] ?? ''} ${json['last_name'] ?? ''}'.trim(),
    email: json['email'] ?? '',
    token: json['token'] ?? ''
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'token': token
  };
}