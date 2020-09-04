import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              "https://www.esa.int/var/esa/storage/images/19716864-11-eng-GB/ESA_root_pillars.jpg",
              height: 256,
            ),
            Text("Usuario nombre")
          ],
        ),
      ),
    );
  }
}
