// import 'dart:convert';

// SellerSearchModel sellerSearchModelFromJson(String str) =>
//     SellerSearchModel.fromJson(json.decode(str));

// String sellerSearchModelToJson(SellerSearchModel data) =>
//     json.encode(data.toJson());

// class SellerSearchModel {
//   List<Seller> sellers;
//   int totalrecords;

//   SellerSearchModel({
//     required this.sellers,
//     required this.totalrecords,
//   });

//   factory SellerSearchModel.fromJson(Map<String, dynamic> json) =>
//       SellerSearchModel(
//         sellers:
//             List<Seller>.from(json["sellers"].map((x) => Seller.fromJson(x))),
//         totalrecords: json["totalrecords"],
//       );

//   Map<String, dynamic> toJson() => {
//         "sellers": List<dynamic>.from(sellers.map((x) => x.toJson())),
//         "totalrecords": totalrecords,
//       };
// }

// class Seller {
//   int selleruserid;
//   int sellerid;
//   String countrycode;
//   String mobilenumber;
//   String email;
//   dynamic profilepicurl;
//   String managername;
//   String businessname;
//   String? address;
//   String? latitude;
//   String? longitude;
//   String sellerstatus;
//   String sellercategory;
//   int? activemarkerid;
//   String? activemarkertype;
//   Marker? marker;

//   Seller({
//     required this.selleruserid,
//     required this.sellerid,
//     required this.countrycode,
//     required this.mobilenumber,
//     required this.email,
//     this.profilepicurl,
//     required this.managername,
//     required this.businessname,
//     this.address,
//     this.latitude,
//     this.longitude,
//     required this.sellerstatus,
//     required this.sellercategory,
//     this.activemarkerid,
//     this.activemarkertype,
//     this.marker,
//   });

//   factory Seller.fromJson(Map<String, dynamic> json) => Seller(
//         selleruserid: json["selleruserid"],
//         sellerid: json["sellerid"],
//         countrycode: json["countrycode"],
//         mobilenumber: json["mobilenumber"],
//         email: json["email"],
//         profilepicurl: json["profilepicurl"],
//         managername: json["managername"],
//         businessname: json["businessname"],
//         address: json["address"],
//         latitude: json["latitude"],
//         longitude: json["longitude"],
//         sellerstatus: json["sellerstatus"],
//         sellercategory: json["sellercategory"],
//         activemarkerid: json["activemarkerid"],
//         activemarkertype: json["activemarkertype"],
//         marker: json["marker"] == null ? null : Marker.fromJson(json["marker"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "selleruserid": selleruserid,
//         "sellerid": sellerid,
//         "countrycode": countrycode,
//         "mobilenumber": mobilenumber,
//         "email": email,
//         "profilepicurl": profilepicurl,
//         "managername": managername,
//         "businessname": businessname,
//         "address": address,
//         "latitude": latitude,
//         "longitude": longitude,
//         "sellerstatus": sellerstatus,
//         "sellercategory": sellercategory,
//         "activemarkerid": activemarkerid,
//         "activemarkertype": activemarkertype,
//         "marker": marker?.toJson(),
//       };
// }

// class Marker {
//   int markerid;
//   String markername;
//   String markerdescription;
//   String markertype;
//   int? activedealid;
//   Deal? deal;
//   int? activevisitrewardid;
//   Visitloyaltyreward? visitloyaltyreward;
//   int? activerevenuerewardid;
//   Revenueloyaltyreward? revenueloyaltyreward;

//   Marker({
//     required this.markerid,
//     required this.markername,
//     required this.markerdescription,
//     required this.markertype,
//     this.activedealid,
//     this.deal,
//     this.activevisitrewardid,
//     this.visitloyaltyreward,
//     this.activerevenuerewardid,
//     this.revenueloyaltyreward,
//   });

//   factory Marker.fromJson(Map<String, dynamic> json) => Marker(
//         markerid: json["markerid"],
//         markername: json["markername"],
//         markerdescription: json["markerdescription"],
//         markertype: json["markertype"],
//         activedealid: json["activedealid"],
//         deal: json["deal"] == null ? null : Deal.fromJson(json["deal"]),
//         activevisitrewardid: json["activevisitrewardid"],
//         visitloyaltyreward: json["visitloyaltyreward"] == null
//             ? null
//             : Visitloyaltyreward.fromJson(json["visitloyaltyreward"]),
//         activerevenuerewardid: json["activerevenuerewardid"],
//         revenueloyaltyreward: json["revenueloyaltyreward"] == null
//             ? null
//             : Revenueloyaltyreward.fromJson(json["revenueloyaltyreward"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "markerid": markerid,
//         "markername": markername,
//         "markerdescription": markerdescription,
//         "markertype": markertype,
//         "activedealid": activedealid,
//         "deal": deal?.toJson(),
//         "activevisitrewardid": activevisitrewardid,
//         "visitloyaltyreward": visitloyaltyreward?.toJson(),
//         "activerevenuerewardid": activerevenuerewardid,
//         "revenueloyaltyreward": revenueloyaltyreward?.toJson(),
//       };
// }

// class Deal {
//   int id;
//   String dealtype;
//   String dealduration;
//   int selleritemid;
//   DateTime periodstart;
//   DateTime periodend;
//   List<String> applicabledays;
//   int buyitemsquantity;
//   int getitemsquantity;
//   dynamic atdiscount;
//   bool? enable;

//   Deal({
//     required this.id,
//     required this.dealtype,
//     required this.dealduration,
//     required this.selleritemid,
//     required this.periodstart,
//     required this.periodend,
//     required this.applicabledays,
//     required this.buyitemsquantity,
//     required this.getitemsquantity,
//     required this.atdiscount,
//     this.enable,
//   });

//   factory Deal.fromJson(Map<String, dynamic> json) => Deal(
//         id: json["id"],
//         dealtype: json["dealtype"],
//         dealduration: json["dealduration"],
//         selleritemid: json["selleritemid"],
//         periodstart: DateTime.parse(json["periodstart"]),
//         periodend: DateTime.parse(json["periodend"]),
//         applicabledays: List<String>.from(json["applicabledays"].map((x) => x)),
//         buyitemsquantity: json["buyitemsquantity"],
//         getitemsquantity: json["getitemsquantity"],
//         atdiscount: json["atdiscount"],
//         enable: json["enable"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "dealtype": dealtype,
//         "dealduration": dealduration,
//         "selleritemid": selleritemid,
//         "periodstart": periodstart.toIso8601String(),
//         "periodend": periodend.toIso8601String(),
//         "applicabledays": List<dynamic>.from(applicabledays.map((x) => x)),
//         "buyitemsquantity": buyitemsquantity,
//         "getitemsquantity": getitemsquantity,
//         "atdiscount": atdiscount,
//         "enable": enable,
//       };
// }

// class Revenueloyaltyreward {
//   int id;
//   int referencespend;
//   int referencepoints;

//   Revenueloyaltyreward({
//     required this.id,
//     required this.referencespend,
//     required this.referencepoints,
//   });

//   factory Revenueloyaltyreward.fromJson(Map<String, dynamic> json) =>
//       Revenueloyaltyreward(
//         id: json["id"],
//         referencespend: json["referencespend"],
//         referencepoints: json["referencepoints"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "referencespend": referencespend,
//         "referencepoints": referencepoints,
//       };
// }

// class Visitloyaltyreward {
//   int id;
//   int visitpoints;
//   int firstvisitpoints;

//   Visitloyaltyreward({
//     required this.id,
//     required this.visitpoints,
//     required this.firstvisitpoints,
//   });

//   factory Visitloyaltyreward.fromJson(Map<String, dynamic> json) =>
//       Visitloyaltyreward(
//         id: json["id"],
//         visitpoints: json["visitpoints"],
//         firstvisitpoints: json["firstvisitpoints"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "visitpoints": visitpoints,
//         "firstvisitpoints": firstvisitpoints,
//       };
// }
