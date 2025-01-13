import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Settings"),
            SizedBox(
              height: 20,
            ),
            Text("Change Password"),
            SizedBox(
              height: 8,
            ),
            Text("Click button and change your password"),
            SizedBox(
              height: 8,
            ),
            OutlinedButton(onPressed: () {}, child: Text("Change Password")),
            SizedBox(
              height: 20,
            ),
            Text("Logout"),
            SizedBox(
              height: 8,
            ),
            Text("Click button and logout"),
            SizedBox(
              height: 8,
            ),
            OutlinedButton(onPressed: () {}, child: Text("Logout")),
          ],
        ),
      ),
    );
  }
}
