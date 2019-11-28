import 'package:fireapp/style.dart';
import 'package:fireapp/widgets/tab_details.dart';
import 'package:flutter/material.dart';
import 'package:fireapp/model/job_category.dart';

class TabSection extends StatefulWidget {
  final TextEditingController textEditController;

  TabSection({this.textEditController});
  @override
  State<StatefulWidget> createState() {
    return _TabSectionState(textEditController: textEditController);
  }
}

class _TabSectionState extends State<TabSection> with TickerProviderStateMixin {
  TabController controller;
  TextEditingController textEditController;
  _TabSectionState({this.textEditController});
  @override
  void initState() {
    controller = TabController(initialIndex: 0, vsync: this, length: getCategories.length);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
 
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          constraints: BoxConstraints.expand(height: 55.0),
          decoration: BoxDecoration(color: MidnightBlue),
          child: TabBar(
            isScrollable: true,
            controller: controller,
            tabs: categories()
            // <Widget>[
            //   Tab(
            //     child: Text("All"),
            //   ),
            //   Tab(
            //     child: Text("Government"),
            //   ),
            //   Tab(
            //     child: Text("Engineering"),
            //   )
            // ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: categoryValue(textEditController)
            // <Widget>[
            //   TabDetails(
            //     txtController: textEditController,
            //     category: "all",
            //   ),
            //   TabDetails(
            //     txtController: textEditController,
            //     category: "government/defence",
            //   ),
            //   TabDetails(
            //     txtController: textEditController,
            //     category: "engineering",
            //   ),
            // ],
          ),
        )
      ],
    );
  }

  List<Widget> categories() {
    List<Widget> categories = new List<Widget>();
    for (int i = 0; i < getCategories.length; i++) {
      categories.add(Tab(
        child: Text(getCategories[i]),
      ));
    }
    return categories;
  }

  List<Widget> categoryValue(TextEditingController controller) {
    List<Widget> categoryValue = new List<Widget>();

    for (int i = 0; i < getCategoryValue.length; i++) {
      categoryValue.add(TabDetails(
        txtController: controller,
        category: getCategoryValue[i].trim().toLowerCase(),
      ));
    }

    return categoryValue;
  }
}
