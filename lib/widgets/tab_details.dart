import 'package:fireapp/main.dart';
import 'package:fireapp/model/firebase_util.dart';
import 'package:fireapp/model/job.dart';
import 'package:fireapp/style.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TabDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabDetailState();
  }
}

class _TabDetailState extends State<TabDetails> {
  String filter;
  final databaseReference = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return listBuilder();
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
                  return filter == null || filter == ""
                      ? _card(snapshot, index)
                      : snapshot.data[index].jobTitle.contains(filter)
                          ? _card(snapshot, index)
                          : Container();
                },
              );
        }
      },
    );
  }

  Widget _card(AsyncSnapshot snapshot, int index) {
    return Card(
        elevation: 2.5,
        child: Container(
          padding: EdgeInsets.all(10.0),
          constraints: BoxConstraints.expand(height: 200.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.work,
                    size: 18.0,
                  ),
                  Text(" ${snapshot.data[index].experience} Experience")
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.location_city,
                    size: 18.0,
                  ),
                  Text(" ${snapshot.data[index].city}")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.attach_money,
                        size: 18.0,
                      ),
                      Text(
                        " ${snapshot.data[index].salary}",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  FlatButton(
                    onPressed: () => onTapCard(context, snapshot.data[index]),
                    child: Text("Apply Now",
                        style: TextStyle(color: Colors.white)),
                    color: MidnightBlue,
                  )
                ],
              )
            ],
          ),
        ));
  }

  void onTapCard(BuildContext context, Job job) {
    Navigator.pushNamed(context, JobDetailsRoute,
        arguments: {"job_detail": job});
  }
}