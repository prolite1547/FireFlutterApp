import 'package:fireapp/screens/job_details_screen.dart';
import 'package:fireapp/screens/job_list_screen.dart';
import 'package:fireapp/style.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

const JobListRoute = "/";
const JobDetailsRoute = "/job_details_screen";

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _routes(),
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primaryColor: MidnightBlue,
      ),
      home: JobListScreen() ,
    );
  }

  RouteFactory _routes(){
      return (settings){
          final Map<String, dynamic> arguments = settings.arguments;
          Widget screen;
          switch(settings.name){
              case JobListRoute:
                screen = JobListScreen();
              break;
              case JobDetailsRoute:
                screen = JobDetailsScreen(job: arguments["job_detail"],);
              break;
              default:
                return null;
          }
          return MaterialPageRoute(builder: (BuildContext context)=>screen);
      };
  }
}

 
