import 'package:fireapp/model/firebase_util.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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
                  return Card(
                      elevation: 1.5,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        constraints: BoxConstraints.expand(height: 150.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                             Text(
                                "${snapshot.data[index].jobTitle}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            SizedBox(height: 10.0,),
                            Text("${snapshot.data[index].description}", overflow: TextOverflow.ellipsis,),
                            SizedBox(height: 10.0,),
                            Text("${snapshot.data[index].city} | Salary : ${snapshot.data[index].salary}", overflow: TextOverflow.ellipsis,),
                            SizedBox(height: 10.0,),
                            Text("Experience : ${snapshot.data[index].experience}", overflow: TextOverflow.ellipsis,),
                          ],
                        ),
                      ));
                },
              );
        }
      },
    );
  }
}
