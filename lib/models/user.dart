class User {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String photoUrl;
  final String connectedToUid;
  final String connectedToName;
  final String connectedToPhone;
  final String timetableId;
  final bool sosStatus;

  User({
    this.uid,
    this.name,
    this.email,
    this.phone,
    this.photoUrl,
    this.connectedToUid,
    this.connectedToName,
    this.connectedToPhone,
    this.timetableId,
    this.sosStatus,
  });

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'email': email,
    'phone': phone,
    'photoUrl': photoUrl,
    'connectedToUid': connectedToUid,
    'connectedToName': connectedToName,
    'connectedToPhone': connectedToPhone,
    'timetableId': timetableId,
    'sosStatus':sosStatus,
  };

  User.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        name = json['name'],
        email = json['email'],
        phone = json['phone'],
        photoUrl = json['photoUrl'],
        connectedToUid = json['connectedToUid'],
        connectedToName = json['connectedToName'],
        connectedToPhone = json['connectedToPhone'],
        timetableId = json['timetableId'],
        sosStatus = json['sosStatus'];
}
