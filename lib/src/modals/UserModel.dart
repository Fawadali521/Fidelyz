import 'dart:convert';

UserModal userModalFromJson(String str) => UserModal.fromJson(json.decode(str));

String userModalToJson(UserModal data) => json.encode(data.toJson());

class UserModal {
  String? message;
  String? token;
  String? usertype;
  int? id;
  String? firstname;
  String? lastname;
  dynamic businessname;
  dynamic managername;
  dynamic dob;
  String? email;
  String? mobilenumber;
  dynamic gender;
  dynamic profilepicurl;

  UserModal({
    this.message,
    this.token,
    this.usertype,
    this.id,
    this.firstname,
    this.lastname,
    this.businessname,
    this.managername,
    this.dob,
    this.email,
    this.mobilenumber,
    this.gender,
    this.profilepicurl,
  });

  factory UserModal.fromJson(Map<String, dynamic> json) => UserModal(
        message: json["message"],
        token: json["token"],
        usertype: json["usertype"],
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        businessname: json["businessname"],
        managername: json["managername"],
        dob: json["dob"],
        email: json["email"],
        mobilenumber: json["mobilenumber"],
        gender: json["gender"],
        profilepicurl: json["profilepicurl"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "usertype": usertype,
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "businessname": businessname,
        "managername": managername,
        "dob": dob,
        "email": email,
        "mobilenumber": mobilenumber,
        "gender": gender,
        "profilepicurl": profilepicurl,
      };
}
