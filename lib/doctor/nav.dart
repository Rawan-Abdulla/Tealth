import 'package:flutter/material.dart';
import 'package:tealth_project/doctor/barDr.dart';

class NavDrawerDr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text("Home"),
            leading: IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => barDr()));
            },
          ),
          Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: Text("Profile"),
            leading: IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {},
            ),
            // onTap: ()
            // {

            //   Navigator.of(context).push(MaterialPageRoute(
            //       builder: (BuildContext context) => profile()));
            // },
          ),
          Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: Text("Contact"),
            leading: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {},
            ),
            // onTap: ()
            //  {
            //   Navigator.of(context).pop();
            //   Navigator.of(context).push(MaterialPageRoute(
            //         builder: (BuildContext context) => contact()));
            //   },
          )
        ],
      ),
    );
  }
}
