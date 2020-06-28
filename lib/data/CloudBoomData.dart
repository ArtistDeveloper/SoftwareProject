import 'package:flutter/material.dart';

class CloudBoomProvider with ChangeNotifier {
  Widget boom = Opacity(
    opacity: 0,
    child: Container(),
  );
}

Widget boomerNullDelete() {
  return Opacity(
    opacity: 0,
    child: Container(),
  );
}