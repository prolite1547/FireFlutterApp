import 'package:fireapp/model/cme_services.dart';
import 'package:fireapp/model/job.dart';
import 'package:fireapp/style.dart';
import 'package:flutter/material.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:share/share.dart';

class JobDetailsScreen extends StatelessWidget {

  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
  final Job job;
 
  JobDetailsScreen({this.job});
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
                    Container(
                      padding: EdgeInsets.only(
                          right: 10.0, bottom: 10.0, left: 10.0),
                      child: Text(
                        "${job.industry}",
                        style: SubheaderTextStyle,
                      ),
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
      floatingActionButton: UnicornDialer(
        backgroundColor: Colors.transparent,
        parentButtonBackground: MidnightBlue,
        orientation: UnicornOrientation.VERTICAL,
        parentButton: Icon(Icons.apps, semanticLabel: "Apply",),
        childButtons: _getProfileMenu(job),
      ),
    );
  }

  List<UnicornButton> _getProfileMenu(Job job) {
    List<UnicornButton> children = [];
    children.add(_profileOption(
        iconData: Icons.share, color: WetAsphalt, onTap: () { Share.share(job.jobTitle+ "\n\n"+ job.description);}));
    if(job.email != "" && job.contactNo != null){
      children.add(_profileOption(
        iconData: Icons.email, color: WetAsphalt, onTap: () { _service.sendEmail(job.email);}));
    }
    if(job.contactNo != "" && job.contactNo != null){
      children.add(_profileOption(
        iconData: Icons.call, color: WetAsphalt, onTap: () { _service.call(job.contactNo);}));
    }

    return children;
  }

  Widget _profileOption({IconData iconData, Color color, Function onTap}) {
    return UnicornButton(
      currentButton: FloatingActionButton(
        heroTag: null,
        backgroundColor: color,
        mini: true,
        child: Icon(iconData),
        onPressed: onTap,
      ),
    );
  }

   
}
