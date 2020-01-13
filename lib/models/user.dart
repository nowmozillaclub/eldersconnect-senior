class User {
  final String uuid;
  final String name;
  final String email;

  User({
    this.uuid,
    this.name,
    this.email,
  });

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'name': name,
        'email': email,
      };

  User.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        name = json['name'],
        email = json['email'];
}
