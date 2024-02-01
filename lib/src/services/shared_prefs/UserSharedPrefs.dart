import 'package:fidelyz/src/modals/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPrefs {
  /// Save user data
  Future<bool> saveUser(UserModal userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userModel.id != null ? preferences.setInt('id', userModel.id!) : null;
    preferences.setString('usertype', userModel.usertype.toString());
    userModel.token != null
        ? preferences.setString('token', userModel.token.toString())
        : null;
    preferences.setString('firstname', userModel.firstname.toString());
    preferences.setString('lastname', userModel.lastname.toString());
    preferences.setString('email', userModel.email.toString());
    userModel.mobilenumber != null
        ? preferences.setString(
        'mobilenumber', userModel.mobilenumber.toString())
        : null;
    preferences.setString('businessname', userModel.businessname.toString());
    preferences.setString('managername', userModel.managername.toString());
    preferences.setString('dob', userModel.dob.toString());
    preferences.setString('gender', userModel.gender.toString());
    preferences.setString('profilepicurl', userModel.profilepicurl.toString());
    return true;
  }

  /// Get user data
  Future<UserModal> getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    UserModal userModal = UserModal(
      message: 'message',
      token: preferences.getString('token'),
      usertype: preferences.getString('usertype'),
      id: preferences.getInt('id'),
      firstname: preferences.getString('firstname'),
      lastname: preferences.getString('lastname'),
      businessname: preferences.getString('businessname'),
      managername: preferences.getString('managername'),
      dob: preferences.getString('dob'),
      email: preferences.getString('email'),
      mobilenumber: preferences.getString('mobilenumber'),
      gender: preferences.getString('gender'),
      profilepicurl: preferences.getString('profilepicurl'),
    );
    return userModal;
  }

  /// Clear user Data
  Future<bool> removeUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('token');
    preferences.remove('usertype');
    preferences.remove('id');
    preferences.remove('firstname');
    preferences.remove('lastname');
    preferences.remove('email');
    preferences.remove('mobilenumber');
    preferences.remove('usinessname');
    preferences.remove('anagername');
    preferences.remove('dob');
    preferences.remove('gender');
    preferences.remove('profilepicurl');
    return true;
  }

  /// save user token
  Future<bool> saveUserToken(String userToken) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userToken', userToken);
    return true;
  }

  /// check if it is a fresh user
  Future<String?> getUserToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userToken = preferences.getString('userToken');
    return userToken;
  }
}
