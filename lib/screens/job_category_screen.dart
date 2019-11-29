import 'package:flutter/material.dart';
import 'package:fireapp/model/job_category.dart';
import 'package:flat_icons_flutter/flat_icons_flutter.dart';
import 'package:fireapp/style.dart';

class JobCategoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _JobCategoryScreenState();
  }
}

class _JobCategoryScreenState extends State<JobCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Clouds,
      appBar: AppBar(
        title:  Text("Industry")
        ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              children: getIndustries(),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> getIndustries() {
    List<Widget> industries = new List<Widget>();
    List<Widget> rows = new List<Widget>();
    int items = 0;
    
    for (var industry in Category.fetchAll()) {
      if (items < 2) {
        rows.add(industryCard(industry.name));
      } else {
        items = 0;
        industries.add(new Row(mainAxisAlignment: MainAxisAlignment.center,children: rows));
        rows = [];
        rows.add(industryCard(industry.name));
      }
      items++;
    }

    if (rows.length > 0) {
      industries.add(new Row(mainAxisAlignment: MainAxisAlignment.center,children: rows));
    }
    return industries;
  }

  Widget industryCard(String text) {
    return Container(
        margin: EdgeInsets.only(right: 10, left: 10, bottom: 20),
        height: 140,
        width: MediaQuery.of(context).size.width * 0.40,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            new BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(FlatIcons.menu_4, size: 24.0,),
            SizedBox(height: 10.0,),
            Text(text, textAlign: TextAlign.center ,style: DrawerLabelTextStyle,)
            ],
        ));
  }
}
