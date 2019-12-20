import 'package:flutter/material.dart';
import 'package:fireapp/model/sharedprefer.dart';

class DoubleHolder {
  double value = 0.0;
}

class StatefulListView extends StatefulWidget {
  final DoubleHolder offset = new DoubleHolder();

  StatefulListView(this._itemCount,
      this._indexedWidgetBuilder,
      {
        Key key
      })
      : super(key: key);

  double getOffsetMethod() {
    return offset.value;
  }

  void setOffsetMethod(double val) {
    offset.value = val;
  }

  final int _itemCount;
  final IndexedWidgetBuilder _indexedWidgetBuilder;

  @override
  _StatefulListViewState createState() =>
      new _StatefulListViewState(_itemCount, _indexedWidgetBuilder);
}

class _StatefulListViewState extends State<StatefulListView> {

  ScrollController scrollController;
  final int _itemCount;
  final IndexedWidgetBuilder _itemBuilder;
  double scrollpos = 0.0;

  _StatefulListViewState(this._itemCount, this._itemBuilder);

  @override
  void initState() {
    super.initState();
    SharedPref().getScrollPos().then((value){
         setState(() {
            scrollpos = value;
         });
         print(scrollpos);
    });
    scrollController = new ScrollController(
        initialScrollOffset: scrollpos
    );
  }

  @override
  Widget build(BuildContext context) {
    return new NotificationListener(
      child: new ListView.builder(
          controller: scrollController, 
          itemCount: _itemCount,
          itemBuilder: _itemBuilder
      ),
      onNotification: (notification) {
        if (notification is ScrollNotification) {
          // widget.setOffsetMethod(notification.metrics.pixels);
          SharedPref().setScrollPos(notification.metrics.pixels);
        }
      },
    );
  }
}