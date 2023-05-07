import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../connect.dart';


class Image3 extends StatefulWidget {
  const Image3({Key? key}) : super(key: key);

  @override
  State<Image3> createState() => _Image3State();
}

class _Image3State extends State<Image3> {

  File? _image;
  File? _image_rc;
  File? _image_dl;
  final picker = ImagePicker();


  var vehicle = TextEditingController();
  var location = TextEditingController();
  var seat =TextEditingController();
  var RC = TextEditingController();
  var price = TextEditingController();
  var insurance = TextEditingController();
  var driving_licence = TextEditingController();
  var upload_photo = TextEditingController();
  Future chooseImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path );
    });
  } Future chooseRC() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image_rc = File(pickedImage!.path );
    });
  } Future choosedl() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image_dl = File(pickedImage!.path );
    });
  }
  Future upload(File imageFile1,File imageFile2,File imageFile3) async {
    //print(name.text);
    // print(description.text);
    // print(location.text);
    // print(widget.reportType);
    //   print(category);

    //var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    //var length = await imageFile.length();
    var uri = Uri.parse("${Con.url}add transportation.php");

    var request = http.MultipartRequest("POST", uri);
    // request.fields['bookName'] = name.text;
    request.fields['vehicle'] = vehicle.text;
    request.fields['number_of_seats'] = seat.text;
    request.fields['location'] = location.text;
    request.fields['price'] = price.text;
    // request.fields['RC'] = RC.text;
    // request.fields['insurance'] = insurance.text;
    // request.fields['dl'] = driving_licence.text;

    var pic1 = await http.MultipartFile.fromPath("image1", imageFile1.path);
    //var pic = http.MultipartFile("image",stream,length,filename: basename(imageFile.path));

    request.files.add(pic1);
    var pic2 = await http.MultipartFile.fromPath("image2", imageFile2.path);
    //var pic = http.MultipartFile("image",stream,length,filename: basename(imageFile.path));

    request.files.add(pic2);
    var pic3 = await http.MultipartFile.fromPath("image3", imageFile3.path);
    //var pic = http.MultipartFile("image",stream,length,filename: basename(imageFile.path));

    request.files.add(pic3);
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
        title: Text("Add Transportation Vehicles"),
        centerTitle: true,

      ),
      body: Center(
        child:ListView(

          children:[
            Text('Add Vehicle Image'),
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
                        // upload(_image!);
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
                                chooseImage();
                              },
                            ),
                          )))
                ])
                    : Image.file(_image!),
              ),
            ),

            // Expanded(child: Text('ADD transportation vehicles', style:  TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
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
            Padding(padding: EdgeInsets.all(10),
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
                  controller: price,
                  decoration: InputDecoration(
                      border:OutlineInputBorder(),
                      labelText: "price",hintText: "price"
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
            Text('Upload RC'),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                //     child: _image == null ? Text('No image selected') : Image.file(_image!),
                child: _image_rc == null
                    ? Stack(children: [
                  Center(
                    child: InkWell(
                      onTap: () {
                        // upload(_image!);
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
                                chooseRC();
                              },
                            ),
                          )))
                ])
                    : Image.file(_image_rc!),
              ),
            ),
            Text('Upload Driving Liscence'),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                //     child: _image == null ? Text('No image selected') : Image.file(_image!),
                child: _image_dl == null
                    ? Stack(children: [
                  Center(
                    child: InkWell(
                      onTap: () {
                        // upload(_image!);
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
                                choosedl();
                              },
                            ),
                          )))
                ])
                    : Image.file(_image_dl!),
              ),
            ),

            // Padding(padding: EdgeInsets.all(10),
            //   child:Card(
            //     child: TextField(
            //       controller: RC,
            //       decoration: InputDecoration(
            //           border:OutlineInputBorder(),
            //           labelText: "RC",hintText: "enter your RC no:"
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(padding: EdgeInsets.all(10),
            //   child:Card(
            //     child: TextField(
            //       controller: insurance,
            //       decoration: InputDecoration(
            //           border:OutlineInputBorder(),
            //           labelText: "Insurance",hintText: "enter your policy no;"
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(padding: EdgeInsets.all(10),
            //   child:Card(
            //     child: TextField(
            //       controller:driving_licence ,
            //       decoration: InputDecoration(
            //           border:OutlineInputBorder(),
            //           labelText: "driving licencd",hintText: "enter your licence no"
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(padding: EdgeInsets.all(10),
            //   child:Card(
            //     child: TextField(
            //       controller: upload_photo,
            //       decoration: InputDecoration(
            //           border:OutlineInputBorder(),
            //           labelText: "Upload photo",hintText: "Upload file"
            //       ),
            //     ),
            //   ),
            // ),
            ElevatedButton(onPressed: (){
              upload(_image!,_image_rc!,_image_dl!);
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
