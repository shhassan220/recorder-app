import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  // final Size size;
  // DrawerScreen({
  //   required this.size,
  // });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(right: 15, left: 15, top: 55, bottom: 55),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(37),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.08, vertical: size.height * 0.06),
          children: [
            ListTile(
              leading: Text("data"),
            ),
            ListTile(
              leading: Text("data"),
            ),
            ListTile(
              leading: Text("data"),
            ),
            ListTile(
              leading: Text("data"),
            ),
          ],
        ),
      ),
    );
  }
}
