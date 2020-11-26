import 'package:flutter/material.dart';

class ModalQueryScreen {
  mainModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _createTile(context, '앱 관련 문의하기', _action1),
                Divider(),
                _createTile(context, '그 외 사항 문의하기', _action2),
              ],
            ),
          );
        });
  }

  ListTile _createTile(BuildContext context, String title, Function action) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'HDharmony',
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        action();
      },
    );
  }

  _action1() {}

  _action2() {}
}
