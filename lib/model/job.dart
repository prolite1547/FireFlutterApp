 class Job{
  String city;
  String contactNo;
  String email;
  String experience;
  String gender;
  String industry;
  String posted;
  String jobTitle;
  String jobLocation;
  String description;
  String jobType;
  String salary;

  Job({
      this.city,
      this.contactNo,
      this.email,
      this.experience,
      this.gender,
      this.industry,
      this.posted,
      this.jobTitle, 
      this.jobLocation, 
      this.description, 
      this.jobType,
      this.salary
    });
  
   factory Job.fromJson(Map<dynamic,dynamic> parsedJobs){
     return Job(
              city: parsedJobs["city"],
              contactNo: parsedJobs["contact_no"],
              email: parsedJobs["email"],
              experience: parsedJobs["experience"],
              gender: parsedJobs["gender"],
              industry: parsedJobs["industry"],
              posted: parsedJobs["posted"],
              jobTitle: parsedJobs["job_title"], 
              jobLocation: parsedJobs["job_location"], 
              description: parsedJobs["description"], 
              jobType: parsedJobs["job_type"],
              salary: parsedJobs["salary"]
       );
   }
}