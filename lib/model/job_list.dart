
import 'package:fireapp/model/job.dart';

class JobList{
  List<Job> jobList;
  
  JobList({this.jobList});

  factory JobList.fromJSON(Map<dynamic,dynamic> json){
    return JobList(jobList: parseJobs(json));
  }

  static List<Job> parseJobs(jobsJSON){
    var jList = jobsJSON["jobs"] as List;
    List<Job> _jobList = jList.map((data)=> Job.fromJson(data)).toList();
    return _jobList;
  }
}