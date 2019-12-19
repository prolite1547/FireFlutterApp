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
  Future<List<Job>> firebaseCalls(DatabaseReference databaseReference) async{
    JobList jobList;
    DataSnapshot dataSnapshot = await databaseReference.once();
    Map<dynamic,dynamic> jsonResponse = dataSnapshot.value[0];

    jobList = new JobList.fromJSON(jsonResponse);
    jobListItems.addAll(jobList.jobList);
    print(jobListItems);
    return jobListItems;
  }
 
  Future<String> get _localPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async{
    final path = await _localPath;
    return File('$path/jobs.json');
  }

  Future<File> wrtieJson(String content) async {
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
