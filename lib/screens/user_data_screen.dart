import 'package:expenz_app/constance/colors.dart';
import 'package:expenz_app/constance/constance.dart';
import 'package:expenz_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {

  // for the check box
bool _rememberMe = false;

//form key for the form validation
final _formKey = GlobalKey<FormState>();
//controllers for the text form feilds
final TextEditingController _userNameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _confirmPasswordController = TextEditingController();
// we enter our data in this form and it get same memory for store. That data is important only for this form so we can forget them when we navigate to next page using dispose();
@override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(child: 
        Padding(
          padding: const EdgeInsets.all(kDefaulPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Enter Your \nPersonal Details", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),),
              SizedBox(height: 30,),
              // form
              Form(
                key: _formKey,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _userNameController,
                    validator: (value) {
                      // check weather the user entered a valid user name
                      if(value!.isEmpty){
                         return "Please Enter Your Name";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      contentPadding: EdgeInsets.all(18)
                    ),
                  ),
                  const SizedBox(height: 15,),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Please Enter Your Email";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      contentPadding: EdgeInsets.all(18)
                    ),
                  ),
                  const SizedBox(height: 15,),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Please Enter a Valid Password";
                      }
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      contentPadding: EdgeInsets.all(18)
                    ),
                  ),
                  const SizedBox(height: 15,),
                   TextFormField(
                    controller: _confirmPasswordController,
                    validator: (value) {
                     if(value!.isEmpty){
                       return "Please Enter The Same Password";
                     }
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      contentPadding: EdgeInsets.all(18)
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    children: [
                      Text("Remember Me for the next time", style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500, color: kGrey),),
                      Expanded(child: 
                      CheckboxListTile(
                        activeColor: kMainColor,
                        value: _rememberMe, 
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value!;
                          },);
                        },))
                    ],
                  ),
                  SizedBox(height: 30,),
                  GestureDetector(
                    onTap: () {
                      if(_formKey.currentState!.validate()){
                        // form is valid, process data
                        String userName = _userNameController.text;
                        String email = _emailController.text;
                        String password = _passwordController.text;
                        String confrimPassword = _confirmPasswordController.text;

                        print("$userName $email $password $confrimPassword");
                      }
                    },
                    child: CustomButton(buttonName: "Next", buttonColor: kMainColor))
                ],
              ))
            ],
          ),
        )),
      ),
    );
  }
}