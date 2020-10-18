import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';



class MyModel extends ChangeNotifier {

  String _profileName='Naveen John';
  String _phoneNumber='1234567890';
  String _imagePath;
  bool edit = false;


  initialPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _phoneNumber = prefs.getString('phoneNumber') ?? 'Enter your phone number';
    notifyListeners();
  }

  initialProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _profileName = prefs.getString('profileName') ?? 'Enter your name';
    notifyListeners();
  }

  initialPic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _imagePath=prefs.getString('profilePic');
    notifyListeners();
  }

  get getProfileName => _profileName;
  get getPhoneNumber => _phoneNumber;
  ImageProvider getImage(){
    if(_imagePath==null)
      return AssetImage("assets/index.png");
    else
      FileImage(File(_imagePath));}
  get ifEnabled => edit;

  Future<void> imagePick() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    String path = image.path;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('profilePic', path);
    notifyListeners();
  }

  Future setEnabled() async {
    edit = !edit;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('editable', edit);
    notifyListeners();
  }

  void setProfileName(String text) async {
    _profileName = text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profileName', _profileName);
    debugPrint(_profileName);
    notifyListeners();
  }

  void setPhone(String text) async {
    _phoneNumber = text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phoneNumber', _phoneNumber);
    notifyListeners();
  }


  String validateMobile(String value) {
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

}
