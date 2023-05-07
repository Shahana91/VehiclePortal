import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicleportaladmin/view.dart';
import 'booking trans.dart';
import 'connect.dart';

class Taxi extends StatefulWidget {
  Taxi({Key? key}) : super(key: key);

  @override
  State<Taxi> createState() => _TaxiState();
}

class _TaxiState extends State<Taxi> {


  Future<dynamic> getData() async {
    print('object');
    var response = await get(Uri.parse('${Con.url}viewtransc.php'));
    print(response.body);
    var res = jsonDecode(response.body);
    print(res);
    return res;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Taxi",style: TextStyle(color: Colors.black),),
        // backgroundColor: Color(0xFF84EE9),
        centerTitle: true,

      ),

      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index]['location']),
                subtitle: Text(snapshot.data![index]['price']),
                leading: Image.network('${Con.url}transport/${snapshot.data[index]['image']}',width: 80,height: 80,fit: BoxFit.fill,),
                // leading: Image.network(
                //   'https://thumbs.dreamstime.com/z/little-baby-crawl-reading-big-book-isolated-white-background-baby-student-100046244.jpg',
                //   width: 80,
                //   height: 80,
                // ),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Bok(
                            id: snapshot.data![index]['transportation_id']);
                      },
                    ));
                  },
                  child: Text("book"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
