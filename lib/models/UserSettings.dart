
import 'dart:convert';

class UserSettings {
  UserSettings({
    this.appColor,
    this.vibrationType,
    this.defaultCategories,
    this.alertType,
    this.userEmail,
  });

  String appColor;
  String vibrationType;
  List<String> defaultCategories;
  String alertType;
  String userEmail;

  void setUserSettingsData(dynamic json){
    appColor = json['data']['app_color'].toString();
    vibrationType = json['data']['vibration_type'].toString();
    defaultCategories = json['data']['default_categories'].toString().replaceAll("[", "").replaceAll("]", "").split(', ').map((String text) => text.toString()).toList();
    alertType = json['data']['alert_type'].toString();
    userEmail = json['data']['user_email'].toString();


  }
  List<String> returnAppCollor(){
    List<String> desiredData = List<String>();
    desiredData.add(appColor.toString());
    print(appColor);
  }
  List<String> returnDefaultCategories(){
    return defaultCategories;
  }
  List<String> returnVibrationType(){
    List<String> desiredData = List<String>();
    desiredData.add(vibrationType);
    print(vibrationType);
  }
  List<String> returnAlertType(){
    List<String> desiredData = List<String>();
    desiredData.add(alertType);
    print(alertType);
  }



  Map<String, dynamic> toJson() => {
    "app_color": appColor,
    "vibration_type": vibrationType,
    "default_catgories": List<dynamic>.from(defaultCategories.map((x) => x)),
    "alert_type": alertType,
    "user_email": userEmail,
  };




}
