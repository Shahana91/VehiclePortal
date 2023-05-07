import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../connect.dart';
import '../main menu.dart';

class AddRental extends StatefulWidget {
  const AddRental({Key? key}) : super(key: key);

  @override
  State<AddRental> createState() => _AddRentalState();
}

class _AddRentalState extends State<AddRental> {

  // XFile? image;
  // File? pickedImage;
  // final ImagePicker picker = ImagePicker();
  File? _image;
  final picker = ImagePicker();


  var name = TextEditingController();
  var price = TextEditingController();
  var vehicle = TextEditingController();
  var gear = TextEditingController();
  var color = TextEditingController();
  var seat = TextEditingController();
  var fuel = TextEditingController();
  var location = TextEditingController();
  var RC = TextEditingController();
  var insurance = TextEditingController();
  var driving_licence = TextEditingController();
  var upload_photo = TextEditingController();

  // Future<void> getData() async {
  //   var data = {
  //     "name": name.text,
  //     "price": price.text,
  //     "vehicle_type": vehicle.text,
  //     "type_of_gear": gear.text,
  //     "color_of_vehicle": color.text,
  //     "seats_of_vehicle": seat.text,
  //     "fuel_of_vehicle": fuel.text,
  //     "location": location.text,
  //     "RC": RC.text,
  //     "insurance": insurance.text,
  //     "driving_licence": driving_licence.text,
  //     "upload_photo": upload_photo.text,
  //
  //   };
  //   print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$data');
  //   var response = await post(Uri.parse('${Con.url}add rental.php'), body: data);
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     var res = jsonDecode(response.body)["message"];
  //     if (res == 'successfully added') {
  //       const snackBar = SnackBar(content: Text("successfully added"),
  //       );
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //       // Fluttertoast.showToast(msg: 'Successfully added...');
  //       Navigator.push(context, MaterialPageRoute(builder: (context) {
  //         return Mainmenu1();
  //       }
  //       ));
  //     }
  //     else {
  //       Fluttertoast.showToast(msg: 'Invalid ');
  //     }
  //   }

  // }
  Future choiceImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path );
    });
  }
  Future upload(File imageFile) async {
    //print(name.text);
    // print(description.text);
    // print(location.text);
    // print(widget.reportType);
    //   print(category);

    //var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    //var length = await imageFile.length();
    var uri = Uri.parse("${Con.url}add rental.php");

    var request = http.MultipartRequest("POST", uri);
    // request.fields['bookName'] = name.text;
    request.fields['name'] = name.text;
    request.fields['price'] = price.text;
    request.fields['vehicle_type'] = vehicle.text;
    request.fields['type_of_gear'] = gear.text;
    request.fields['color_of_vehicle'] = color.text;
    request.fields['seats_of_vehicle'] = seat.text;
    request.fields['fuel_of_vehicle'] = fuel.text;
    request.fields['location'] = location.text;
    request.fields['RC'] = RC.text;
    request.fields['insurance'] = insurance.text;
    request.fields['driving_licence'] = driving_licence.text;


    var pic = await http.MultipartFile.fromPath("image", imageFile.path);
    //var pic = http.MultipartFile("image",stream,length,filename: basename(imageFile.path));

    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      print("image uploaded");
    } else {
      print("uploaded failed");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Rental Vehicles"),
        centerTitle: true,

        actions: [
        ],
      ),
      body: Center(
        child: ListView(
          children:[
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                //     child: _image == null ? Text('No image selected') : Image.file(_image!),
                child: _image == null
                    ? Stack(children: [
                  Center(
                    child: InkWell(
                      onTap: () {
                        upload(_image!);
                      },
                      child: Card(
                        elevation: 5,
                        child: Container(
                          //color: Colors.red,
                          height: 200,
                          width: 250,
                          child: Center(
                              child: Text(
                                '-- Click to select image --',
                                style: TextStyle(color: Colors.white10),
                              )),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 80,
                      top: 180,
                      child: ClipOval(
                          child: Container(
                            height: 50,
                            width: 50,
                            color: Colors.blueGrey[100],
                            child: IconButton(
                              icon: Icon(
                                Icons.photo_camera_back_outlined,
                                size: 30,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                choiceImage();
                              },
                            ),
                          )))
                ])
                    : Image.file(_image!),
              ),
            ),

            Padding(padding: EdgeInsets.all(10),
              child:Card(
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                      border:OutlineInputBorder(),
                      labelText: "vehicle name",hintText: "enter your vehicle name"
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10),
              child:Card(
                child: TextField(
                  controller: price,
                  decoration: InputDecoration(
                      border:OutlineInputBorder(),
                      labelText: "Price",hintText: "enter price"
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10),
              child:Card(
                child: TextField(
                  controller: vehicle,
                  decoration: InputDecoration(
                      border:OutlineInputBorder(),
                      labelText: "Type of vehicle",hintText: "enter your vehicle type"
                  ),
                ),
              ),
            ),
            // Expanded(child: Text('ADD rental vehicles', style:  TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

            Padding(padding: EdgeInsets.all(10),
              child:Card(
                child: TextField(
                  controller: gear,
                  decoration: InputDecoration(
                      border:OutlineInputBorder(),
                      labelText: "gear",hintText: "enter type of gear"
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10),
              child:Card(
                child: TextField(
                  controller: color,
                  decoration: InputDecoration(
                      border:OutlineInputBorder(),
                      labelText: "color",hintText: "enter color of vehicle"
                  ),
                ),
              ),
            ),Padding(padding: EdgeInsets.all(10),
              child:Card(
                child: TextField(
                  controller: seat,
                  decoration: InputDecoration(
                      border:OutlineInputBorder(),
                      labelText: "seat",hintText: "enter number of seats"
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10),
              child:Card(
                child: TextField(
                  controller: fuel,
                  decoration: InputDecoration(
                      border:OutlineInputBorder(),
                      labelText: "fuel",hintText: "enter fuel"
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10),
              child:Card(
                child: TextField(
                  controller: location,
                  decoration: InputDecoration(
                      border:OutlineInputBorder(),
                      labelText: "Location",hintText: "enter your Location"
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10),
              child:Card(
                child: TextField(
                  controller: RC,
                  decoration: InputDecoration(
                      border:OutlineInputBorder(),
                      labelText: "RC",hintText: "upload RC"
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(22.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         'RC',
            //         style: TextStyle(fontSize: 15),
            //       ),
            //       FloatingActionButton(
            //         onPressed: () async {
            //           File? temp = (await Services.pickImage(context)) as File?;
            //           setState(() {
            //              pickedImage = temp;
            //           });
            //          // print(pickedImage!.path);
            //         },
            //         child: Icon(Icons.camera_alt),
            //       ),
            //       // image == null ? Text('no image') : Image.file(image!),
            //     ],
            //   ),
            // ),


            Padding(padding: EdgeInsets.all(10),
              child:Card(
                child: TextField(
                  controller: insurance,
                  decoration: InputDecoration(
                      border:OutlineInputBorder(),
                      labelText: "Insurance",hintText: "upload insurance;"
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10),
              child:Card(
                child: TextField(
                  controller: driving_licence,
                  decoration: InputDecoration(
                      border:OutlineInputBorder(),
                      labelText: "driving licencd",hintText: "upload licence"
                  ),
                ),
              ),
            ),
            // Wrap(
            //   children: [
            //     Text(''),
            //     ElevatedButton(onPressed: (){
            //       upload(_image!);
            //     }, child: Text("Upload Photo"))
            //
            //   ],
            // ),
            // Padding(padding: EdgeInsets.all(10),
            //   child:Card(
            //     child: TextField(
            //       controller: upload_photo,
            //       decoration: InputDecoration(
            //           border:OutlineInputBorder(),
            //           labelText: "Upload photo",hintText: "Upload photo"
            //       ),
            //     ),
            //   ),
            // ),
            ElevatedButton(

                onPressed: (){
                  upload(_image!);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item added Successfully ...',style: TextStyle(fontSize: 20,color: Colors.white),),
                    backgroundColor:  Color(
                        0xfa8f7805),));
                  Navigator.pop(context);

                }, child: Text("ADD"))
          ],
        ),
      ),

    );
  }
}
