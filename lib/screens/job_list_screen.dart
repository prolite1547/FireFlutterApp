import 'package:fireapp/main.dart';
import 'package:fireapp/model/firebase_util.dart';
import 'package:fireapp/model/notif.dart';
import 'package:fireapp/style.dart';
import 'package:fireapp/widgets/tab_section.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
  TextEditingController controller = new TextEditingController();
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  // String  filter;

  @override
  void initState() {
    super.initState();
           _firebaseMessaging.configure(
            onMessage: (Map<String, dynamic> message) {
              print('on message $message');
            },
            onResume: (Map<String, dynamic> message) {
              print('on resume $message');
            },
            onLaunch: (Map<String, dynamic> message) {
              print('on launch $message');
            },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.getToken().then((token) {
      print(token);
    });
    // controller.addListener(() {
    //   setState(() {
    //     filter = controller.text;
    //   });
    // });
    // Notif().initializeNotif(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Jobs Corner',
                      style: HeaderTextStyle1,
                    )
                  ],
                ),
                decoration: BoxDecoration(color: MidnightBlue),
              ),
              ListTile(
                title: Text(
                  'Job Categories',
                  style: DrawerLabelTextStyle,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, JobCategoryRoute);
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: controller,
                  style: TextStyle(color: Colors.white, fontFamily: Poppins),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.blueGrey,
                    ),
                    hintText: "Search job here ..",
                    hintStyle:
                        TextStyle(color: Colors.blueGrey, fontFamily: Poppins),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: TabSection(
              textEditController: controller,
            )

            // Column(
            //   children: <Widget>[
            //     Expanded(
            //       child: Container(
            //         child: listBuilder(),
            //       ),
            //     )
            //   ],
            // ),
            ));
  }

  // Widget listBuilder() {
  //   return FutureBuilder(
  //     future: MakeCall().firebaseCalls(databaseReference),
  //     builder: (BuildContext context, AsyncSnapshot snapshot) {
  //       switch (snapshot.connectionState) {
  //         case ConnectionState.waiting:
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         default:
  //           if (snapshot.hasError)
  //             return Center(child: Text("Snapshot error : ${snapshot.error}"));
  //           else
  //             return ListView.builder(
  //               itemCount: snapshot.data.length,
  //               itemBuilder: (BuildContext context, int index) {
  //                 return filter == null || filter == "" ? _card(snapshot, index) : snapshot.data[index].jobTitle.contains(filter) ? _card(snapshot, index) : Container() ;
  //               },
  //             );
  //       }
  //     },
  //   );
  // }

  // Widget _card(AsyncSnapshot snapshot, int index) {
  //   return Card(
  //       elevation: 2.5,
  //       child: Container(
  //         padding: EdgeInsets.all(10.0),
  //         constraints: BoxConstraints.expand(height: 200.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             Expanded(
  //               child: SingleChildScrollView(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                     Text(
  //                       "${snapshot.data[index].jobTitle}",
  //                       style: TextStyle(
  //                         color: MidnightBlue,
  //                         fontSize: 18.0,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 5.0,
  //                     ),
  //                     Text("${snapshot.data[index].industry}"),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             SizedBox(
  //               height: 5.0,
  //             ),
  //             Row(
  //               children: <Widget>[
  //                 Icon(
  //                   Icons.work,
  //                   size: 18.0,
  //                 ),
  //                 Text(" ${snapshot.data[index].experience} Experience")
  //               ],
  //             ),
  //             Row(
  //               children: <Widget>[
  //                 Icon(
  //                   Icons.location_city,
  //                   size: 18.0,
  //                 ),
  //                 Text(" ${snapshot.data[index].city}")
  //               ],
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: <Widget>[
  //                 Row(
  //                   children: <Widget>[
  //                     Icon(
  //                       Icons.attach_money,
  //                       size: 18.0,
  //                     ),
  //                     Text(
  //                       " ${snapshot.data[index].salary}",
  //                       style: TextStyle(
  //                           fontSize: 16.0, fontWeight: FontWeight.bold),
  //                     )
  //                   ],
  //                 ),
  //                 FlatButton(
  //                   onPressed: () => onTapCard(context, snapshot.data[index]),
  //                   child: Text("Apply Now", style: TextStyle(color: Colors.white)),
  //                   color: MidnightBlue,
  //                 )
  //               ],
  //             )
  //           ],
  //         ),
  //       ));
  // }

  // void onTapCard(BuildContext context, Job job) {
  //   Navigator.pushNamed(context, JobDetailsRoute,
  //       arguments: {"job_detail": job});
  // }

}
