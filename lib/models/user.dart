class User {
  final String uuid;
  final String name;
  final String email;
  final String photoUrl;

  User({
    this.uuid,
    this.name,
    this.email,
    this.photoUrl,
  });

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'name': name,
        'email': email,
        'photoUrl': photoUrl,
      };

  User.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        name = json['name'],
        email = json['email'],
        photoUrl = json['photoUrl'];
}
