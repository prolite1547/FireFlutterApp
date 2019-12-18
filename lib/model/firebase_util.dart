import 'dart:async';
import 'dart:io';
import 'package:fireapp/model/job.dart';
import 'package:fireapp/model/job_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:path_provider/path_provider.dart';

class MakeCall{
  List<Job> jobListItems = [];
  Directory dir;
  Future<List<Job>> firebaseCalls(DatabaseReference databaseReference) async{
    JobList jobList;
    DataSnapshot dataSnapshot = await databaseReference.once();
    Map<dynamic,dynamic> jsonResponse = dataSnapshot.value[0];
    wrtieJson(jsonResponse.toString());
    jobList = new JobList.fromJSON(jsonResponse);
    jobListItems.addAll(jobList.jobList);
    return jobListItems;
  }


  // void writeJsonFile(String content) async{
 
  //   File file = new File(dir.path+"/"+"jobs.json");
  //   file.createSync();
  //   file.writeAsStringSync(content);
  // }

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



}
