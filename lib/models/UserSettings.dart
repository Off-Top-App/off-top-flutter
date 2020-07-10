// To parse this JSON data, do
//
//     final userSettings = userSettingsFromJson(jsonString);

import 'dart:convert';

class UserSettings {
  UserSettings({
    this.appColor,
    this.vibrationType,
    this.defaultCatgories,
    this.alertType,
    this.userEmail,
  });

  String appColor;
  String vibrationType;
  List<String> defaultCatgories;
  String alertType;
  String userEmail;

  factory UserSettings.fromJson(Map<String, dynamic> json){
    return UserSettings(
      appColor: json["app_color"] as String,
      vibrationType: json['vibration_type'] as String,
      defaultCatgories: List<String>.from(json["default_catgories"] as List<String>),
      alertType: json["alert_type"] as String,
      userEmail: json["user_email"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    "app_color": appColor,
    "vibration_type": vibrationType,
    "default_catgories": List<dynamic>.from(defaultCatgories.map((x) => x)),
    "alert_type": alertType,
    "user_email": userEmail,
  };

}
