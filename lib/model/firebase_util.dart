import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fireapp/model/job.dart';
import 'package:fireapp/model/job_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:path_provider/path_provider.dart';

class MakeCall{
  List<Job> jobListItems = [];
  Directory dir;
  String contentResponse;
  
  Future<Null> createJsonFile() async{
    final databaseReference = FirebaseDatabase.instance.reference();
    DataSnapshot dataSnapshot = await databaseReference.once();
    Map<dynamic,dynamic> jsonResponse = dataSnapshot.value[0];
    var jsonString = jsonEncode(jsonResponse);
    writeJson(jsonString);
    print("JSON File created....");
  }
 
  Future<List<Job>> firebaseCalls(DatabaseReference databaseReference) async{
    JobList jobList;
    DataSnapshot dataSnapshot = await databaseReference.once();
    Map<dynamic,dynamic> jsonResponse = dataSnapshot.value[0];
    // var jsonString = jsonEncode(jsonResponse);
    // writeJson(jsonString);
     String jsonString = await readingJSON();
     Map<dynamic,dynamic> jsonRespo = jsonDecode(jsonString);

    jobList = new JobList.fromJSON(jsonResponse);
    jobListItems.addAll(jobList.jobList);
   
    return jobListItems;
  }

   Future<List<Job>> callLocalJson() async{
      JobList jobList;
      String jsonString = await readingJSON();
      Map<dynamic,dynamic> jsonResponse = jsonDecode(jsonString);
      jobList = new JobList.fromJSON(jsonResponse);
      jobListItems.addAll(jobList.jobList);
      return jobListItems;
   }
 
  Future<String> get _localPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async{
    final path = await _localPath;
    return File('$path/jobs3.json');
  }

  Future<File> writeJson(String content) async {
    final file = await _localFile;
    return file.writeAsString('$content');
  }


  Future<String> readingJSON() async {
  try {
    final file = await _localFile;
    String contents = await file.readAsString();
    return contents;
  } catch (e) {
    return '{jobs:[]}';
  }
}



}
