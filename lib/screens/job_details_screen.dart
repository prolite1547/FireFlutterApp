import 'package:fireapp/model/job.dart';
import 'package:fireapp/style.dart';
import 'package:flutter/material.dart';

class JobDetailsScreen extends StatelessWidget {
  final Job job;
  JobDetailsScreen({this.job});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MidnightBlue,
      appBar: AppBar(
        title: Text("Job Details"),
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 10.0, bottom: 5.0 ,left: 10.0),
                  child: Text("${job.jobTitle}",style: HeaderTextStyle1,),
                ),
                 Container(
                  padding: EdgeInsets.only(right: 10.0, bottom: 10.0,left: 10.0),
                  child: Text("${job.industry}",style: SubheaderTextStyle,),
                )
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(30.0))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30.0)) ,
                    child: SingleChildScrollView(
                      child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, top: 20.0 ,right: 10.0),
                        child: Text("${job.description}" , style: DescriptionTextStyle,),
                      )
                    ],
                  ),
                    ),
                  ),
            ),
          )
        ],
      ),
    );
  }
}
