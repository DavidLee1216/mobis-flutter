import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final isLoading;

  LoadingIndicator({@required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
        child: Center(child: CircularProgressIndicator()),
        color: Colors.white.withOpacity(0.8)
    )
        : Container();
  }
}
