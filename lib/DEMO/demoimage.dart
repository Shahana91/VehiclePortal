// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:straycare_app/screens/location/location_controller.dart';
// import 'dart:io';
//
// import '../../../../connection/connect.dart';
// import '../../../style/style.dart';
//
// class ReportingCase extends StatefulWidget {
//   ReportingCase({Key? key,required this.uid, required this.reportType}) : super(key: key);
//   var reportType;
//   var uid;
//
//   @override
//   _ReportingCaseState createState() => _ReportingCaseState();
// }
//
// class _ReportingCaseState extends State<ReportingCase> {
//   var myLatitude;
//   var myLongitude;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   File? _image;
//   final picker = ImagePicker();
//
//   // TextEditingController nameContr = TextEditingController();
//   TextEditingController description = TextEditingController();
//   TextEditingController name = TextEditingController();
//   // TextEditingController rate=TextEditingController();
//   TextEditingController location = TextEditingController();
//   TextEditingController missingDate = TextEditingController();
//   TextEditingController phone = TextEditingController();
//   TextEditingController animal = TextEditingController();
//   TextEditingController animalColor = TextEditingController();
//   TextEditingController breed = TextEditingController();
//   TextEditingController mapLocation = TextEditingController();
//   var gender;
//   //var mapLocation;
//
//   //var category;
//
//   Future choiceImage() async {
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       _image = File(pickedImage!.path);
//     });
//   }
//
//   Future upload(File imageFile) async {
//     //print(name.text);
//     print(description.text);
//     print(location.text);
//     print(widget.reportType);
//     //   print(category);
//
//     //var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
//     //var length = await imageFile.length();
//     var uri = Uri.parse("${Con.url}report.php");
//
//     var request = http.MultipartRequest("POST", uri);
//     // request.fields['bookName'] = name.text;
//     request.fields['caseType'] = widget.reportType;
//     request.fields['user_id'] = widget.uid;
//     request.fields['description'] = description.text;
//     request.fields['location'] = mapLocation.text;
//     request.fields['lati'] = myLatitude.toString();
//     request.fields['longi'] = myLongitude.toString();
//     request.fields['reportedDate'] = DateTime.now().toString();
//
//
//     var pic = await http.MultipartFile.fromPath("image", imageFile.path);
//     //var pic = http.MultipartFile("image",stream,length,filename: basename(imageFile.path));
//
//     request.files.add(pic);
//     var response = await request.send();
//
//     if (response.statusCode == 200) {
//       print("image uploaded");
//     } else {
//       print("uploaded failed");
//     }
//   }
//   Future uploadMissing(File imageFile) async {
//     //print(name.text);
//     print(description.text);
//     print(location.text);
//     print(phone.text);
//     print(animal.text);
//     print(animalColor.text);
//     print(breed.text);
//     print(widget.reportType);
//     //   print(category);
//
//     //var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
//     //var length = await imageFile.length();
//     var uri = Uri.parse("${Con.url}missingReport.php");
//
//     var request = http.MultipartRequest("POST", uri);
//     // request.fields['bookName'] = name.text;
//     request.fields['caseType'] = widget.reportType;
//     request.fields['user_id'] = widget.uid;
//     request.fields['name'] = name.text;
//     request.fields['gender'] = gender;
//     request.fields['description'] = description.text;
//     request.fields['location'] = location.text;
//     request.fields['missingDate'] = missingDate.text;
//     request.fields['phone'] = phone.text;
//     request.fields['animal'] = animal.text;
//     request.fields['animalColor'] = animalColor.text;
//     request.fields['breed'] = breed.text;
//     request.fields['reportedDate'] = DateTime.now().toString();
//
//
//     var pic = await http.MultipartFile.fromPath("image", imageFile.path);
//     //var pic = http.MultipartFile("image",stream,length,filename: basename(imageFile.path));
//
//     request.files.add(pic);
//     var response = await request.send();
//
//     if (response.statusCode == 200) {
//       print("image uploaded");
//     } else {
//       print("uploaded failed");
//     }
//   }
//   Future<void> phoneDialog() async {
//     await showDialog<void>(
//         context: context,
//         builder: (BuildContext context) {
//           return SimpleDialog( // <-- SEE HERE
//             //  title: const Text('Select Booking Type'),
//             children: <Widget>[
//               SimpleDialogOption(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Column(
//                   children: const[Text('Perinthalmanna'),
//                     Text('9078256575'),
//                   ],
//                 ),
//               ),
//               SimpleDialogOption(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child:Column(
//                   children: const[Text('Malappuram'),
//                     Text('897256575'),
//                   ],
//                 ),
//               ),
//               SimpleDialogOption(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Column(
//                   children: const[Text('Kozhikode'),
//                     Text('908756575'),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<LocationController>(
//       init:  LocationController(),
//       builder: (controller){
//         return  SafeArea(
//           child: Scaffold(
//             appBar: AppBar(
//               backgroundColor: Colors.white,
//               shadowColor: vio,
//               title: Text(
//                 'Report a case',
//                 style: subHead,
//               ),
//               centerTitle: true,
//             ),
//             body: Padding(
//               padding: const EdgeInsets.all(30.0),
//               child: ListView(
//                 children: <Widget>[
//                   Center(
//                     child: Container(
//                       width: MediaQuery.of(context).size.width,
//                       height: 300,
//                       //     child: _image == null ? Text('No image selected') : Image.file(_image!),
//                       child: _image == null
//                           ? Stack(children: [
//                         Center(
//                           child: InkWell(
//                             onTap: () {
//                               upload(_image!);
//                             },
//                             child: Card(
//                               elevation: 5,
//                               child: Container(
//                                 //color: Colors.red,
//                                 height: 200,
//                                 width: 250,
//                                 child: Center(
//                                     child: Text(
//                                       '-- Click to select image --',
//                                       style: normalTextPlay,
//                                     )),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                             right: 80,
//                             top: 180,
//                             child: ClipOval(
//                                 child: Container(
//                                   height: 50,
//                                   width: 50,
//                                   color: Colors.blueGrey[100],
//                                   child: IconButton(
//                                     icon: Icon(
//                                       Icons.photo_camera_back_outlined,
//                                       size: 30,
//                                       color: Colors.red,
//                                     ),
//                                     onPressed: () {
//                                       choiceImage();
//                                     },
//                                   ),
//                                 )))
//                       ])
//                           : Image.file(_image!),
//                     ),
//                   ),
//
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Visibility(
//                     visible: (widget.reportType == 'missing') ? true : false,
//                     child: TextFormField(
//                       controller: name,
//                       keyboardType: TextInputType.text,
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.type_specimen_sharp),
//                         enabledBorder:
//                         OutlineInputBorder(borderSide: BorderSide(color: vio)),
//                         focusedBorder:
//                         OutlineInputBorder(borderSide: BorderSide(color: vio)),
//
//                         label: Text(
//                           'Name',
//                           style: normalTextPlay,
//                         ),
//                       ),
//                     ),
//                   ),
//
//
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Visibility(
//                       visible: (widget.reportType == 'missing') ? true : false,
//                       child: Container(
//                         height: 70,
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: RadioListTile(
//                                   title: Text('Male',
//                                     style: normalTextPlay,
//                                   ),
//                                   value: 'male',
//                                   groupValue: gender,
//                                   onChanged: (val){
//                                     setState(() {
//                                       gender=val;
//                                     });
//                                   }),
//                             ),
//                             Expanded(
//                               child: RadioListTile(
//                                   title: Text('Female'
//
//                                     , style: normalTextPlay,
//                                   ),
//                                   value: 'female',
//                                   groupValue: gender,
//                                   onChanged: (val){
//                                     setState(() {
//                                       gender=val;
//                                     });
//                                   }),
//                             ),
//                           ],
//                         ),
//                       )
//                   ),
//
//
//                   SizedBox(
//                     height: 10,
//                   ),
//
//                   TextFormField(
//                     textAlign: TextAlign.center,
//                     controller: description,
//                     keyboardType: TextInputType.text,
//                     maxLines: 5,
//                     decoration: InputDecoration(
//
//                       prefixIcon: Icon(Icons.description_outlined),
//                       enabledBorder:
//                       OutlineInputBorder(borderSide: BorderSide(color: vio)),
//                       focusedBorder:
//                       OutlineInputBorder(borderSide: BorderSide(color: vio)),
//
//                       label: Text(
//                         'Add Description',
//                         style: normalTextPlay,
//                       ),
//                     ),
//                   ),
//                   // ListTile(
//                   //   title: Expanded(
//                   //     child: TextFormField(
//                   //       controller: location,
//                   //       keyboardType: TextInputType.text,
//                   //       maxLines: 5,
//                   //       decoration: InputDecoration(
//                   //         prefixIcon: Icon(Icons.location_on_outlined),
//                   //         enabledBorder:
//                   //         OutlineInputBorder(borderSide: BorderSide(color: vio)),
//                   //         label: Text(
//                   //           'Location',
//                   //           style: normalTextPlay,
//                   //         ),
//                   //       ),
//                   //       onTap: (){
//                   //         controller.getCurrentLocation();
//                   //       },
//                   //     ),
//                   //   ),
//                   //   trailing: ElevatedButton(onPressed: (){
//                   //     controller.getCurrentLocation();
//                   //   },child:Text('Get My Location')),
//                   // ),
//                   Visibility(
//                     visible: (widget.reportType=='missing')?false:true,
//
//                     child: SizedBox(
//                       height: 10,
//                     ),
//                   ),
//                   Visibility(
//                     visible: (widget.reportType=='missing')?false:true,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: TextFormField(
//                         controller:mapLocation,
//                         decoration: InputDecoration(
//                           border:InputBorder.none,
//                           // label: Text('--No Location Selected--'),
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                   // Visibility(
//                   //     visible: (widget.reportType=='missing')?false:true,
//                   //   child: Padding(
//                   //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   //     child: Text(
//                   //       controller.currentLocation == null ? '--No Location Selected--' :
//                   //       controller.currentLocation!, style: blackTextPlay,
//                   //       textAlign: TextAlign.center,
//                   //     ),
//                   //   ),
//                   // ),
//                   Visibility(
//                       visible: (widget.reportType=='missing')?false:true,
//
//                       child: SizedBox(height: 20,)),
//                   Visibility(
//                     visible: (widget.reportType=='missing')?false:true,
//
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                               side: BorderSide(color: vio)
//
//                           )
//                       ),
//
//
//                       onPressed: () {
//                         setState(() {
//                           controller.getCurrentLocation();
//                           // mapLocation.text= controller.currentLocation == null ? '--No Location Selected--' :
//                           // controller.currentLocation!;
//                           mapLocation.text= controller.currentLocation == null ? '--Wait for a while to get Location or tap again below after a few seconds--' :
//                           controller.currentLocation!;
//                           myLatitude=controller.myLat;
//                           myLongitude=controller.myLong;
//                           print(myLatitude);
//                           print(myLongitude);
//
//                         });
//
//                         //style: blackTextPlay,
//                         // mapLocation=controller.currentLocation!;
//                         // print(controller.currentLocation!);
//                         // print(mapLocation);
//                       },
//                       child: Center(
//                         child: ListTile(
//                           title: Text('Get My Location',style: normalTextPlay,),
//                           leading: Icon(Icons.location_on_outlined),
//
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Visibility(
//                     visible: (widget.reportType == 'missing') ? true : false,
//
//                     child: TextFormField(
//
//                       controller: missingDate,
//                       //editing controller of this TextField
//                       decoration: InputDecoration(
//                         label: Text(
//                           'Last Seen Date',
//                           style: normalTextPlay,
//                         ),
//                         enabledBorder:
//                         OutlineInputBorder(borderSide: BorderSide(color: vio)),
//                         focusedBorder:
//                         OutlineInputBorder(borderSide: BorderSide(color: vio)),
//
//                         prefixIcon: Icon(Icons.calendar_today), //icon of text field
//                       ),
//                       //readOnly: true,
//                       //set it true, so that user will not able to edit text
//                       onTap: () async {
//                         DateTime? pickedDate = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime.now().subtract(Duration(days: 100)),
//                             // firstDate: DateTime(1950),
//                             //DateTime.now() - not to allow to choose before today.
//                             lastDate: DateTime(2100));
//
//                         if (pickedDate != null) {
//                           print(
//                               pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
//                           String formattedDate =
//                           DateFormat('yyyy-MM-dd').format(pickedDate);
//                           print(
//                               formattedDate); //formatted date output using intl package =>  2021-03-16
//                           setState(() {
//                             missingDate.text =
//                                 formattedDate; //set output date to TextField value.
//                           });
//                         } else {}
//                       },
//                     ),
//                   ),
//
//                   // TextFormField(
//                   //   controller: location,
//                   //   keyboardType: TextInputType.text,
//                   //   maxLines: 5,
//                   //   decoration: InputDecoration(
//                   //     prefixIcon: Icon(Icons.location_on_outlined),
//                   //     enabledBorder:
//                   //     OutlineInputBorder(borderSide: BorderSide(color: vio)),
//                   //     focusedBorder:
//                   //     OutlineInputBorder(borderSide: BorderSide(color: vio)),
//                   //
//                   //     label: Text(
//                   //       'Location',
//                   //       style: normalTextPlay,
//                   //     ),
//                   //   ),
//                   //   onTap: (){
//                   //      controller.getCurrentLocation();
//                   //      location.text= controller.currentLocation!;
//                   //   },
//                   // ),
//                   Visibility(
//                     visible: (widget.reportType == 'missing') ? true : false,
//
//                     child: SizedBox(
//                       height: 10,
//                     ),
//                   ),
//                   Visibility(
//                     visible: (widget.reportType == 'missing') ? true : false,
//                     child: TextFormField(
//                       controller: location,
//                       keyboardType: TextInputType.text,
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.location_on_outlined),
//                         enabledBorder:
//                         OutlineInputBorder(borderSide: BorderSide(color: vio)),
//                         focusedBorder:
//                         OutlineInputBorder(borderSide: BorderSide(color: vio)),
//
//                         label: Text(
//                           'Last Seen At',
//                           style: normalTextPlay,
//                         ),
//                       ),
//                     ),
//                   ),
//
//
//                   Visibility(
//                     visible: (widget.reportType == 'missing') ? true : false,
//
//                     child: SizedBox(
//                       height: 10,
//                     ),
//                   ),
//                   Visibility(
//                     visible: (widget.reportType == 'missing') ? true : false,
//                     child: TextFormField(
//                       controller: phone,
//                       keyboardType: TextInputType.text,
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.phone),
//                         enabledBorder:
//                         OutlineInputBorder(borderSide: BorderSide(color: vio)),
//                         focusedBorder:
//                         OutlineInputBorder(borderSide: BorderSide(color: vio)),
//
//                         label: Text(
//                           'Contact On',
//                           style: normalTextPlay,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   Visibility(
//                     visible: (widget.reportType == 'missing') ? true : false,
//
//                     child: SizedBox(
//                       height: 10,
//                     ),
//                   ),
//                   Visibility(
//                     visible: (widget.reportType == 'missing') ? true : false,
//                     child: TextFormField(
//                       controller: animal,
//                       keyboardType: TextInputType.text,
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.pets_outlined),
//                         enabledBorder:
//                         OutlineInputBorder(borderSide: BorderSide(color: vio)),
//                         focusedBorder:
//                         OutlineInputBorder(borderSide: BorderSide(color: vio)),
//
//                         label: Text(
//                           'Animal',
//                           style: normalTextPlay,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   Visibility(
//                     visible: (widget.reportType == 'missing') ? true : false,
//
//                     child: SizedBox(
//                       height: 10,
//                     ),
//                   ),
//                   Visibility(
//                     visible: (widget.reportType == 'missing') ? true : false,
//                     child: TextFormField(
//                       controller: animalColor,
//                       keyboardType: TextInputType.text,
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.color_lens_outlined),
//                         enabledBorder:
//                         OutlineInputBorder(borderSide: BorderSide(color: vio)),
//                         focusedBorder:
//                         OutlineInputBorder(borderSide: BorderSide(color: vio)),
//
//                         label: Text(
//                           'Color',
//                           style: normalTextPlay,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   Visibility(
//
//                     visible: (widget.reportType == 'missing') ? true : false,
//
//                     child: SizedBox(
//                       height: 10,
//                     ),
//                   ),
//                   Visibility(
//                     visible: (widget.reportType == 'missing') ? true : false,
//                     child: TextFormField(
//                       controller: breed,
//                       keyboardType: TextInputType.text,
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.type_specimen_outlined),
//                         enabledBorder:
//                         OutlineInputBorder(borderSide: BorderSide(color: vio)),
//                         focusedBorder:
//                         OutlineInputBorder(borderSide: BorderSide(color: vio)),
//
//                         label: Text(
//                           'Breed',
//                           style: normalTextPlay,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Align(
//                     alignment: AlignmentDirectional.bottomCenter,
//                     child: Container(
//                       width: 260,
//                       height: 60,
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             shape:RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(60),
//                             ),
//
//                             //  color: vio
//
//
//                             backgroundColor: vio,),
//                           // side: BorderSide(color: vio)),
//                           onPressed: () {
//                             if (_image != null ) {
//                               if(widget.reportType=='missing'){
//
//                                 uploadMissing(_image!);
//
//                               }else{
//                                 upload(_image!);
//                               }
//                               //  upload(_image!);
//                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                 content: Text(
//                                   'Posting ...',
//                                   style:
//                                   TextStyle(fontSize: 20, color: Colors.white),
//                                 ),
//                                 backgroundColor: Color(0xfa8f7805),
//                               ));
//                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                 content: Text(
//                                   'Posted Successfully ...',
//                                   style: TextStyle(fontSize: 20, color: Colors.white),
//                                 ),
//                                 backgroundColor: Color(0xfa8f7805),
//                               ));
//
//                               Navigator.pop(context);
//                             } else {
//                               ScaffoldMessenger.of(context)
//                                   .showSnackBar(const SnackBar(
//                                 content: Text(
//                                   'All fields required ...',
//                                   style:
//                                   TextStyle(fontSize: 20, color: Colors.white),
//                                 ),
//                                 backgroundColor: Color(0xfa8f7805),
//                               ));
//
//                               throw 'choose image';
//                             }
//                           },
//                           child: Center(
//                               child: ListTile(
//                                 title: Text(
//                                   'Post',
//                                   style: btnHeadPlay,
//                                 ),
//                                 trailing: CircleAvatar(
//                                     backgroundColor: Colors.white54,
//                                     child: Icon(Icons.send)),
//                               ))),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Visibility(
//                       visible: (widget.reportType == 'injured') ? true : false,
//                       child: Container(
//                         width: 260,
//                         height: 60,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(60),
//                             color: vio
//                         ),
//                         child: ListTile(
//                           onTap: (){
//                             phoneDialog();
//                           },
//                           title: Text(
//                             'Call Veterinary',
//                             style: btnHeadPlay,
//                           ),
//                           leading: CircleAvatar(
//                               backgroundColor: Colors.white54,
//                               child: Icon(Icons.phone,color: Colors.red,)),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(
//                     height: 24,
//                   ),
//
//                   // ElevatedButton(child: Text('Upload Image'),
//                   //   onPressed: (){
//                   //     upload(_image!);
//                   //   },),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//
//
//     );
//   }
// }
