import 'dart:async';
import 'package:fireapp/model/job.dart';
import 'package:fireapp/model/job_list.dart';
import 'package:firebase_database/firebase_database.dart';

class MakeCall{
  List<Job> jobListItems = [];

  Future<List<Job>> firebaseCalls(DatabaseReference databaseReference) async{
    JobList jobList;
    DataSnapshot dataSnapshot = await databaseReference.once();
    Map<dynamic,dynamic> jsonResponse = dataSnapshot.value[0];
    jobList = new JobList.fromJSON(jsonResponse);
    jobListItems.addAll(jobList.jobList);
    return jobListItems;
  }
}
