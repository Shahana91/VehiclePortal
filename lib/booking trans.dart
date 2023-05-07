import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:vehicleportaladmin/transportation.dart';

import 'connect.dart';


class Bok extends StatefulWidget {
  String? id;
  Bok({Key? key, required this.id}) : super(key: key);


  @override
  State<Bok> createState() => _BokState();
}

class _BokState extends State<Bok> {
  var name = TextEditingController();
  var phone_no = TextEditingController();
  var address = TextEditingController();
  var from = TextEditingController();
  var destination = TextEditingController();
  var date = TextEditingController();
  var time = TextEditingController();
  var vehicle = TextEditingController();
  var payment = TextEditingController();
  Future<void> getData() async {
    var data = {
      "name": name.text,
      "phone number": phone_no.text,
      "address": address.text,
      "from": from.text,
      "destination": destination.text,
      "date": date.text,
      "time": time.text,
      "vehicle": vehicle.text,
      "payment": payment.text,
    };
    print(data);
    var response= await post(Uri.parse('${Con.url}booktran.php'),body:data);
    print(response.body);
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body)["message"];
      if (res == 'added') {
        const snackBar = SnackBar(content: Text("successfully"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // Fluttertoast.showToast(msg: 'Successfully added...');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Vehicles();
        }
        ));
      }
      else {
        Fluttertoast.showToast(msg: 'Invalid ');
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BOOKING DETAILS"),
        centerTitle: true,
      ),
      body:Center(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:80.0,right: 20.0,top:10.0),
              child: Container(
                width: 100,
                child: TextField(
                    controller:name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),

                    ),
                    labelText:"Name",hintText: "Name ",
                  ),
                  keyboardType: TextInputType.name,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:80.0,right: 20.0,top:10.0),
              child: Container(
                width: 100,
                child: TextField(
                  controller:phone_no,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),

                    ),
                    labelText:"Phone no",hintText: "Phone no ",
                  ),
                  keyboardType: TextInputType.name,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:80.0,right: 20.0,top:10.0),
              child: Container(
                width: 100,
                child: TextField(
                  controller:address,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),

                    ),
                    labelText:"Address",hintText: "Address ",
                  ),
                  keyboardType: TextInputType.name,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:80.0,right: 20.0,top:10.0),
              child: Container(
                width: 100,
                child: TextField(
                  controller:from,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),

                    ),
                    labelText:"From",hintText: "From",
                  ),
                  keyboardType: TextInputType.name,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:80.0,right: 20.0,top:10.0),
              child: Container(
                width: 100,
                child: TextField(
                  controller:destination,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),

                    ),
                    labelText:"destination",hintText: "destination",
                  ),
                  keyboardType: TextInputType.name,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left:80.0,right: 20.0,top:10.0),
              child: Container(
                width: 100,
                child: TextField(
                  controller:date,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),

                    ),
                    labelText:"Date",hintText: "Date",
                  ),
                  keyboardType: TextInputType.name,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:80.0,right: 20.0,top:10.0),
              child: Container(
                width: 100,
                child: TextField(
                  controller:time,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    labelText:"Time",hintText: "Time ",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:80.0,right: 20.0,top:10.0),
              child: Container(
                width: 100,
                child: TextField(
                  controller:vehicle,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    labelText:"Vehicle",hintText: "Vehicle",
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:80.0,right: 20.0,top:10.0),
              child: Container(
                width: 100,
                child: TextField(
                  controller:payment,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),

                    ),
                    labelText:"Payment",hintText: "Payment",
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left:80.0,right: 20.0,top:10.0),
            //   child: Container(
            //     width: 100,
            //     child: TextField(
            //       decoration: InputDecoration(
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(30.0),
            //         ),
            //         labelText:"Password",hintText: "Password",
            //       ),
            //       obscureText: true,
            //     ),            //   ),
            // ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: (){
                  getData();
                }, child: Text("Submit"))
            ),
          ],
        ),
      ),
    );
  }
}