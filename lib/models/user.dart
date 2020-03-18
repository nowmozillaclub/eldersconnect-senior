class User {
  final String uid;
  final String name;
  final String email;
  final String photoUrl;
  final String connectedToUid;
  final String connectedToName;

  User({
    this.uid,
    this.name,
    this.email,
    this.photoUrl,
    this.connectedToUid,
    this.connectedToName,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'photoUrl': photoUrl,
        'connectedToUid': connectedToUid,
        'connectedToName': connectedToName,
      };

  User.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        name = json['name'],
        email = json['email'],
        photoUrl = json['photoUrl'],
        connectedToUid = json['connectedToUid'],
        connectedToName = json['connectedToName'];
}
