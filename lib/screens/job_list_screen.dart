import 'package:fireapp/main.dart';
import 'package:fireapp/model/firebase_util.dart';
import 'package:fireapp/style.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fireapp/model/job.dart';

class JobListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _JobListScreenState();
  }
}

class _JobListScreenState extends State<JobListScreen> {
  final databaseReference = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: listBuilder(),
            ),
          )
        ],
      ),
    );
  }

  Widget listBuilder() {
    return FutureBuilder(
      future: MakeCall().firebaseCalls(databaseReference),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (snapshot.hasError)
              return Center(child: Text("Snapshot error : ${snapshot.error}"));
            else
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () =>onTapCard(context, snapshot.data[index]) ,
                    child: Card(
                        elevation: 2.5,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          constraints: BoxConstraints.expand(height: 170.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "${snapshot.data[index].jobTitle}",
                                        style: TextStyle(
                                          color: MidnightBlue,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text("${snapshot.data[index].industry}"),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.location_city),
                                  Text("${snapshot.data[index].city}")
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.attach_money),
                                  Text(
                                    "${snapshot.data[index].salary}",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
                  );
                },
              );
        }
      },
    );
  }

  void onTapCard(BuildContext context, Job job) {
    Navigator.pushNamed(context, JobDetailsRoute,
        arguments: {"job_detail": job});
  }
}
