import 'package:flutter/material.dart';

import '../../../providers/index.dart';

class NotificationsSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(getLocale(context).notifications_title),
      ),
    );
  }
}
