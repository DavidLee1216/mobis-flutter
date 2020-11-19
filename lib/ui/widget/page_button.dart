
import 'package:flutter/material.dart';

class PageItem extends StatelessWidget {
  final PageModel _item;
  PageItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 20.0,
            width: 20.0,
            child: new Center(
              child: new Text(_item.number.toString(),
                  style: new TextStyle(
                      color:
                      _item.isSelected ? Colors.white : Colors.black54,
                      //fontWeight: FontWeight.bold,
                      fontSize: 8.0)),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected
                  ? Colors.black54
                  : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected
                      ? Colors.black54
                      : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(1.0)),
            ),
          ),
          SizedBox(width: 5,),
        ],
      ),
    );
  }
}

class PageModel {
  bool isSelected;
  final int number;

  PageModel(this.isSelected, this.number);
}