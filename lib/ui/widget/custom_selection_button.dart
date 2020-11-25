import 'package:flutter/material.dart';

class SelectionButtonItem extends StatelessWidget {
  final SelectionButtonModel _item;
  final double width;
  final double height;
  SelectionButtonItem(this._item, this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: height,
      width: width,
      child: new Center(
        child: new Text(_item.buttonText,
            style: new TextStyle(
                fontFamily: 'HDharmony',
                color: _item.isSelected ? Colors.white : Colors.black54,
                //fontWeight: FontWeight.bold,
                fontSize: 14.0)),
      ),
      decoration: new BoxDecoration(
        color: _item.isSelected ? Colors.black54 : Colors.transparent,
        border: new Border.all(
            width: 1.0, color: _item.isSelected ? Colors.black54 : Colors.grey),
        borderRadius: const BorderRadius.all(const Radius.circular(1.0)),
      ),
    );
  }
}

class SelectionButtonModel {
  bool isSelected;
  final String buttonText;

  SelectionButtonModel(this.isSelected, this.buttonText);
}
