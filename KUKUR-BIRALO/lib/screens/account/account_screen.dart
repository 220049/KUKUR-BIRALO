import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:n_baz/services/local_notification_service.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/global_ui_viewmodel.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  void logout() async{
    _ui.loadState(true);
    try{
      await _auth.logout().then((value){
        Navigator.of(context).pushReplacementNamed('/login');
      })
          .catchError((e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
      });
    }catch(err){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.toString())));
    }
    _ui.loadState(false);
  }

  late GlobalUIViewModel _ui;
  late AuthViewModel _auth;
  @override
  void initState() {
    _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _auth = Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Image.asset(
            "assets/images/logo.png",
            height: 300,
            width: 300,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(_auth.loggedInUser!.email.toString()),
          ),
          SizedBox(
            height: 10,
          ),
          // makeSettings(
          //     icon: Icon(Icons.sell),
          //     title: "My Products",
          //     subtitle: "Get listing of my products",
          //     onTap: (){
          //       Navigator.of(context).pushNamed("/my-products");
          //     }
          // ),
          makeSettings(
              icon: Icon(Icons.person),
              title: "My Profile",
              subtitle: "View and Update profile",
              onTap: (){
                Navigator.of(context).pushNamed("/my-profile");
              }
          ),
          makeSettings(
              icon: Icon(Icons.logout),
              title: "Logout",
              subtitle: "Logout from this application",
              onTap: (){
                logout();
              }
          ),
          makeSettings(
            icon: Icon(Icons.delete),
            title: "Delete Account",
            subtitle: "Permanently delete account from this application",
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Delete Account"),
                    content: Text("Are you sure you want to delete your account?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          deleteAccount();
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.red, // Set the text color to red
                        ),
                        child: Text("Delete"),
                      ),
                    ],
                  );
                },
              );
            },
          ),


          makeSettings(
              icon: Icon(Icons.android),
              title: "Version",
              subtitle: "0.0.1",
              onTap: (){

              }
          )
        ],
      ),
    );
  }

  makeSettings({required Icon icon, required String title, required String subtitle, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Card(
            elevation: 4,
            color: Colors.white,
            child: ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.5),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                leading: icon,
                title: Text(
                  title,
                ),
                subtitle: Text(
                  subtitle,
                ))),
      ),
    );
  }

  void deleteAccount() async {
    _ui.loadState(true);
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Delete user data from Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();

        // Delete the user account
        await user.delete();

        Navigator.of(context).pushReplacementNamed('/login');
      } else {
        // User is not authenticated or already logged out
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User not found or already logged out")),
        );
      }
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(err.toString())),
      );
    }
    _ui.loadState(false);
  }
}
