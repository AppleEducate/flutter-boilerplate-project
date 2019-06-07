import 'package:boilerplate/locale/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(Provider.of<LocaleState>(context).strings.notifications_title),
      ),
    );
  }
}
