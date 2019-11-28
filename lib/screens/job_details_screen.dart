import 'package:fireapp/model/cme_services.dart';
import 'package:fireapp/model/job.dart';
import 'package:fireapp/style.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:unicorndial/unicorndial.dart';
import 'package:share/share.dart';

class JobDetailsScreen extends StatefulWidget {
  final Job job;
  JobDetailsScreen({this.job});
  @override
  State<StatefulWidget> createState() {
    return _JobDetailScreenState(job);
  }
}

class _JobDetailScreenState extends State<JobDetailsScreen> {
  CallsAndMessagesService _service = locator<CallsAndMessagesService>();
  Job job;
  _JobDetailScreenState(this.job);

  Future showApplyPopup(BuildContext context, Job job) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return applyContent(job);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MidnightBlue,
      appBar: AppBar(
        title: Text(
          "Summary",
        ),
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              flex: 2,
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.only(right: 10.0, bottom: 5.0, left: 10.0),
                      child: Text(
                        "${job.jobTitle}",
                        style: HeaderTextStyle1,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              right: 10.0, bottom: 10.0, left: 10.0),
                          child: Text(
                            "${job.industry}",
                            style: SubheaderTextStyle,
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(
                                right: 10.0, bottom: 10.0, left: 10.0),
                            child: Row(
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    showApplyPopup(context, job);
                                  },
                                  color: BelizeHole,
                                  child: Text(
                                    "APPLY",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontFamily: Poppins,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),

                                //  FlatButton(
                                //   onPressed: () {},
                                //   color: GreenSea,
                                //   child: Text(
                                //     "SHARE",
                                //     style: TextStyle(
                                //         color: Colors.white,
                                //         fontFamily: Poppins,
                                //         fontWeight: FontWeight.w400),
                                //   ),
                                // )
                              ],
                            ))
                      ],
                    )
                  ],
                ),
              )),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                  color: Clouds,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0))),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0)),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.people),
                                    Text(" ${job.gender}")
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.attach_money),
                                    Text(" ${job.salary}")
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.query_builder),
                                    Text(" ${job.experience} Experience")
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.work),
                                    Text(" ${job.jobType}")
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0),
                        child: Text(
                          "JOB OVERVIEW :",
                          style: HeaderBlacKTextStyle,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0),
                        child: Text(
                          "${job.description}",
                          style: DescriptionTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      // floatingActionButton: UnicornDialer(
      //   backgroundColor: Colors.transparent,
      //   parentButtonBackground: MidnightBlue,
      //   orientation: UnicornOrientation.VERTICAL,
      //   parentButton: Icon(Icons.apps, semanticLabel: "Apply",),
      //   childButtons: _getProfileMenu(job),
      // ),
    );
  }

  // List<UnicornButton> _getProfileMenu(Job job) {
  //   List<UnicornButton> children = [];
  //   children.add(_profileOption(
  //       iconData: Icons.share, color: WetAsphalt, onTap: () { Share.share(job.jobTitle+ "\n\n"+ job.description);}));
  //   if(job.email != "" && job.contactNo != null){
  //     children.add(_profileOption(
  //       iconData: Icons.email, color: WetAsphalt, onTap: () { _service.sendEmail(job.email);}));
  //   }
  //   if(job.contactNo != "" && job.contactNo != null){
  //     children.add(_profileOption(
  //       iconData: Icons.call, color: WetAsphalt, onTap: () { _service.call(job.contactNo);}));
  //   }

  //   return children;
  // }

  // Widget _profileOption({IconData iconData, Color color, Function onTap}) {
  //   return UnicornButton(
  //     currentButton: FloatingActionButton(
  //       heroTag: null,
  //       backgroundColor: color,
  //       mini: true,
  //       child: Icon(iconData),
  //       onPressed: onTap,
  //     ),
  //   );
  // }

  Widget applyContent(Job job) {
    return AlertDialog(
      backgroundColor: Clouds,
      title: Text("Apply via",
          style: TextStyle(
            color: Colors.black,
            fontFamily: Poppins,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          )),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          job.email != null && job.email != ""
              ? FlatButton.icon(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  onPressed: () {
                    _service.sendEmail(job.email);
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.email,
                    size: 36,
                    color: MidnightBlue,
                  ),
                  label: Text(
                    "EMAIL",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: Poppins,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                )
              : SizedBox(),
          job.contactNo != null && job.contactNo != ""
              ? FlatButton.icon(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  onPressed: () {
                    _service.call(job.contactNo);
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.call, size: 36, color: MidnightBlue),
                  label: Text(
                    "CALL",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: Poppins,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                )
              : SizedBox()
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Close",
            style: TextStyle(color: Colors.black),
          ),
        )
      ],
    );
  }
}
