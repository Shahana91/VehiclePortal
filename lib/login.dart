import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicleportaladmin/register.dart';

import 'connect.dart';
import 'main menu-user.dart';
import 'main menu.dart';
import 'nav bar.dart';

class Homelog extends StatefulWidget {
  const Homelog({Key? key}) : super(key: key);

  @override
  State<Homelog> createState() => _HomelogState();
}

class _HomelogState extends State<Homelog> {

  var Email = TextEditingController();
  var Password = TextEditingController();

  Future<void> getData() async {
    var data = {
      "email": Email.text,
      "password": Password.text,
    };
    var response = await post(Uri.parse('${Con.url}login.php'), body: data);
    var res = jsonDecode(response.body);
    print(res);

    if (response.statusCode == 200) {
      if (res['message'] == 'User Successfully LoggedIn') {
        var id = res["log_id"];
        print(id);
        final spref = await SharedPreferences.getInstance();
        spref.setString('regi_id', id);
        Fluttertoast.showToast(msg: 'Successfully login...');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Homeee();
        }
        ));

      }
      else {
        Fluttertoast.showToast(msg: 'Invalid username or password');
      }
    }
    else {
      Fluttertoast.showToast(msg: 'Something went wrong!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body:Center(
        child: Center(
          child: ListView(
            children: [
              Center(child: Padding(
                padding: const EdgeInsets.only(top: 120.0),
                child: Text("Welcome Back!!",style: TextStyle(fontSize: 40,fontWeight:FontWeight.bold),),
              )),
              Padding(
                padding: const EdgeInsets.only(left:20.0,right: 20.0,top:10.0),
                child: Container(
                  width: 100,
                  child: TextField(
                    controller:Email ,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText:"Email",hintText: "Email",
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:20.0,right: 20.0,top:10.0),
                child: Container(
                  width: 100,
                  child: TextField(
                    controller: Password,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText:"Password",hintText: "Password",
                    ),
                    obscureText: true,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: () {
                  getData();

                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 88.0,right: 90.0),
                  child: Container(
                    child: Center(child: Text('Login')),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    height: 50,
                    width: 50,

                  ),
                ),
              ),
              TextButton(onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Register()));
              }, child: Text("Don't have any account please login here!"))
            ],
          ),
        ),
      ),
    );
  }
}