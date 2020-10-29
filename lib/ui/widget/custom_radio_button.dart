import 'package:flutter/material.dart';

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 14.0,
            width: 14.0,
            child: new Center(
              child: new Text(_item.buttonText,
                  style: new TextStyle(
                      color:
                      _item.isSelected ? Colors.white : Colors.black54,
                      //fontWeight: FontWeight.bold,
                      fontSize: 14.0)),
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
          new Container(
            margin: new EdgeInsets.only(left: 5.0),
            child: new Text(_item.text),
          )
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;
  final String text;

  RadioModel(this.isSelected, this.buttonText, this.text);
}