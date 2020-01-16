class User {
  final String uuid;
  final String name;
  final String email;
  final String photoUrl;
  final String connectedToUuid;
  final String connectedToName;

  User({
    this.uuid,
    this.name,
    this.email,
    this.photoUrl,
    this.connectedToUuid,
    this.connectedToName,
  });

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'name': name,
        'email': email,
        'photoUrl': photoUrl,
        'connectedToUuid': connectedToUuid,
        'connectedToName': connectedToName,
      };

  User.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        name = json['name'],
        email = json['email'],
        photoUrl = json['photoUrl'],
        connectedToUuid = json['connectedToUuid'],
        connectedToName = json['connectedToName'];
}
