import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  //Store the userName and password using shared preferences
  static Future<void> storeUserDetails({
    required String userName, 
    required String email,
    required String password, 
    required String confirmPassword, 
    required BuildContext context}) async {
   
    //if the password and confirm password are same then store the users name and email
    try{
       //check if the password and confirm password are the same
    if (password != confirmPassword) {
      //show a snackbar with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password and Confirm Password do not match"),
        ),
      );
      return;
    }
      //create an instance from shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // store the user name and email as key value pairs
      await prefs.setString("username", userName);
      await prefs.setString("email", email);

      //show a message to a user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User Details stored successfully."),),
      );
    }catch(err){
      err.toString();
    }
}

// method to check weather the username is saved in the shared preferences
static Future<bool> checkUserName() async{

  //creste an instance for shared preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userName = prefs.getString("username");
  return userName != null;
}
// get the username and email
static Future<Map < String, String >> getUserData () async {
     //create a instance for shared preferences
     SharedPreferences prefs = await SharedPreferences.getInstance();

     String? userName = prefs.getString("username");
     String? email = prefs.getString("email");

     return {"username" : userName!, "email" : email!};
     }
}