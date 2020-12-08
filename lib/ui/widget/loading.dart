import 'package:flutter/material.dart';

class LoadingData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(alignment: Alignment.center, height: 45, width: 45, child: CircularProgressIndicator()));
  }
}
