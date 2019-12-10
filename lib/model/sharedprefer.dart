import 'dart:ffi';

import 'package:fireapp/widgets/listbuilder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SharedPref {
   
  setScrollPos(double value) async{
   SharedPreferences sharedPref  = await SharedPreferences.getInstance();
   sharedPref.setDouble('scrollpos', value);
  }

  Future<double> getScrollPos() async{
    SharedPreferences sharedPref  = await SharedPreferences.getInstance();
    return sharedPref.getDouble('scrollpos');
  }
 
}
