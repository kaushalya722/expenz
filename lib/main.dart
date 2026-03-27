import 'package:expenz_app/services/user_service.dart';
import 'package:expenz_app/widgets/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
   runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     return FutureBuilder(
      future: UserService.checkUserName(), 
      builder: (context, snapshot){
        // if the snapshot is still waiting
        if(snapshot.connectionState == ConnectionState.waiting){
          return const CircularProgressIndicator();
        }else{
          //here the hasUserName will be set to true of the data is in the snapshot and otherwise false
          bool hasUserName = snapshot.data ?? false;
          return  MaterialApp(
              title: "Expenz",
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                 fontFamily: "Inter",
                ),
                home: Wrapper(showMainScreen: hasUserName,),
              );
        }
      },
      );
   
  }
}