import 'package:fireapp/main.dart';
import 'package:fireapp/model/firebase_util.dart';
import 'package:fireapp/model/job.dart';
import 'package:fireapp/style.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TabDetails extends StatefulWidget {
  final TextEditingController txtController;
  final String category;
  TabDetails({this.txtController, this.category});
  @override
  State<StatefulWidget> createState() {
    return _TabDetailState(txtController: txtController, category: category);
  }
}

class _TabDetailState extends State<TabDetails> {
  final databaseReference = FirebaseDatabase.instance.reference();
  ScrollController _scrollController;
  TextEditingController txtController;
  String category;
  String filter;
  AsyncSnapshot snapshots;
  _TabDetailState({this.txtController, this.category});

  Future<Null> getPosition() async{
       SharedPreferences pref  = await SharedPreferences.getInstance();
          _scrollController  = ScrollController(
            initialScrollOffset: (pref.getDouble("position") ?? 0.0)
          );
           _scrollController.addListener((){ 
               pref.setDouble("position", _scrollController.position.pixels);
          });
  }

  Future<Null> setPosition() async{
    SharedPreferences pref  = await SharedPreferences.getInstance();
    _scrollController  = ScrollController(
            initialScrollOffset: 0.0
    );
    _scrollController.addListener((){ 
        pref.setDouble("position", _scrollController.position.pixels);
    });
  }

  @override
  void initState() {
    setPosition();
    super.initState();
    txtController.addListener(() {
      if (this.mounted) {
        setState(() {
          filter = txtController.text;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return listBuilder();
  }

  Widget listBuilder() {
    return FutureBuilder(
      future: MakeCall().firebaseCalls(databaseReference),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        snapshots = snapshot;
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (snapshot.hasError)
              return Center(child: Text("Snapshot error : ${snapshot.error}"));
            else
              // return 
              // StatefulListView(snapshot.data.length, listitemBuilder);
              return ListView.builder(
                controller: _scrollController,
                itemCount: snapshot.data.length,
                itemBuilder: listitemBuilder,
              );
        }
      },
    );
  }
  Widget listitemBuilder(BuildContext context, int index) {
                  Widget card;
                  if (filter == null || filter == "") {
                    if (category == "all") {
                      card = _card(snapshots, index);
                    } else { 
                      if(category == snapshots.data[index].industry.toString().trim().toLowerCase()) {
                          card = _card(snapshots, index);
                      }else{
                          card = Container();
                      }
                    }
                  } else {
                    if (category == "all") {
                      if (snapshots.data[index].jobTitle.contains(filter)) {
                        card = _card(snapshots, index);
                      } else {
                        card = Container();
                      }
                    } else {
                      if (snapshots.data[index].jobTitle.contains(filter) &&
                          category == snapshots.data[index].industry.toString().trim().toLowerCase()) {
                        card = _card(snapshots, index);
                      } else {
                        card = Container();
                      }
                    }
                  }
                  return card;

                  // return filter == null || filter == ""
                  //     ? _card(snapshot, index)
                  //     : snapshot.data[index].jobTitle.contains(filter)
                  //         ? _card(snapshot, index)
                  //         : Container();
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
    getPosition();
    Navigator.pushNamed(context, JobDetailsRoute,
        arguments: {"job_detail": job});
  }
  
}
