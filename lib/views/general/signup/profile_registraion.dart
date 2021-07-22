import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hutech_go/components/custom_button.dart';
import 'package:hutech_go/components/custom_notch.dart';
import 'package:hutech_go/utils/constants.dart';
import 'package:hutech_go/views/general/home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:uuid/uuid.dart';

class ProfileRegistration extends StatefulWidget {
  static final routeName = "regis";
  final String userId;
  final String phoneNumber;
  @override
  ProfileRegistration(this.userId, this.phoneNumber);
  _ProfileRegistration createState() => _ProfileRegistration();
}

class _ProfileRegistration extends State<ProfileRegistration> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  DateTime _selectedDate;
  File _imageFile;
  var _items = ['Nam', 'Nữ', 'Khác'];
  final _formKey = GlobalKey<FormState>();
  var _uuid = Uuid();
  TextEditingController _textStudentIdController = TextEditingController();
  TextEditingController _textStudentNameController = TextEditingController();
  TextEditingController _textClassController = TextEditingController();
  TextEditingController _textDateOfBirthController = TextEditingController();
  TextEditingController _textGenderController = TextEditingController();
  TextEditingController _textEmailController = TextEditingController();
  TextEditingController _textAddressController = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('students');
  bool _isDriver = false;
  String _profileImageURL;
  _addUser() {
    return users.doc(widget.userId).set({
      "student_id": _textStudentIdController.text,
      "student_name": _textStudentNameController.text,
      "class": _textClassController.text,
      "birthday": _textDateOfBirthController.text,
      "phone_number": widget.phoneNumber,
      "gender": _textGenderController.text,
      "email": _textEmailController.text,
      "address": _textAddressController.text,
      "idcard_image": _profileImageURL,
      "profile_image": _profileImageURL,
      "status": "Enable",
      "university": "DKC",
      "is_driver": _isDriver
    }).then((value) {
      FocusScope.of(context).unfocus();
      _scaffoldkey.currentState
          .showSnackBar(SnackBar(
            backgroundColor: Constants.primary,
            content: Text('Đăng ký thành công'),
          ))
          .closed
          .then((resion) {
        Navigator.pushNamedAndRemoveUntil(
            context, Home.routeName, (route) => false);
      });
    }).catchError((error) => print("Failed to add user: $error"));
  }

  _selectDate() async {
    DateTime pickedDate = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (context) {
        DateTime tempPickedDate;
        return Container(
          height: 300,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text('Done'),
                      onPressed: () {
                        Navigator.of(context).pop(tempPickedDate);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _textDateOfBirthController.text =
            DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _getFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _getFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  _uploadFile(String filePath, String ref) async {
    File file = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref(ref)
          .putFile(file)
          .whenComplete(() => _getFileURL(ref));
    } on firebase_core.FirebaseException catch (e) {
      print(e.message);
    }
  }

  _getFileURL(String ref) async {
    _profileImageURL = await firebase_storage.FirebaseStorage.instance
        .ref(ref)
        .getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    final mQSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Container(
                width: mQSize.width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: mQSize.height * 0.01),
                      Image.asset(
                        "assets/images/logos/hutechgo_logo.png",
                        height: mQSize.width * 0.18,
                      ),
                      SizedBox(height: mQSize.height * 0.08),
                      Container(
                        width: mQSize.width * 0.8,
                        child: Column(children: [
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập mã số sinh viên';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            controller: _textStudentIdController,
                            decoration: InputDecoration(
                                labelText: "Mã số sinh viên",
                                labelStyle:
                                    TextStyle(fontSize: 18, color: Colors.blue),
                                fillColor: Colors.blue.withOpacity(0.15),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập họ tên sinh viên';
                              }
                              return null;
                            },
                            controller: _textStudentNameController,
                            decoration: InputDecoration(
                                labelText: "Họ và Tên",
                                fillColor: Colors.blue.withOpacity(0.15),
                                labelStyle:
                                    TextStyle(fontSize: 18, color: Colors.blue),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập mã lớp';
                              }
                              return null;
                            },
                            controller: _textClassController,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.blue),
                                fillColor: Colors.blue.withOpacity(0.15),
                                labelStyle:
                                    TextStyle(fontSize: 18, color: Colors.blue),
                                labelText: "Mã lớp",
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập ngày sinh';
                              }
                              return null;
                            },
                            readOnly: true,
                            showCursor: true,
                            onTap: () => _selectDate(),
                            keyboardType: TextInputType.datetime,
                            controller: _textDateOfBirthController,
                            decoration: InputDecoration(
                                labelText: "Ngày sinh",
                                labelStyle:
                                    TextStyle(fontSize: 18, color: Colors.blue),
                                fillColor: Colors.blue.withOpacity(0.15),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                          SizedBox(height: 30),
                          Row(
                            children: <Widget>[
                              new Expanded(
                                  child: new TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng nhập giới tính';
                                  }
                                  return null;
                                },
                                readOnly: true,
                                showCursor: true,
                                controller: _textGenderController,
                                decoration: InputDecoration(
                                  labelText: "Giới tính",
                                  labelStyle: TextStyle(
                                      fontSize: 18, color: Colors.blue),
                                  fillColor: Colors.blue.withOpacity(0.15),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  suffixIcon: PopupMenuButton<String>(
                                    icon: const Icon(Icons.arrow_drop_down),
                                    onSelected: (String value) {
                                      _textGenderController.text = value;
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return _items.map<PopupMenuItem<String>>(
                                          (String value) {
                                        return new PopupMenuItem(
                                            child: new Text(value),
                                            value: value);
                                      }).toList();
                                    },
                                  ),
                                ),
                              )),
                            ],
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _textEmailController,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.blue),
                                fillColor: Colors.blue.withOpacity(0.15),
                                labelStyle:
                                    TextStyle(fontSize: 18, color: Colors.blue),
                                labelText: "Email",
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            keyboardType: TextInputType.streetAddress,
                            controller: _textAddressController,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.blue),
                                fillColor: Colors.blue.withOpacity(0.15),
                                labelStyle:
                                    TextStyle(fontSize: 18, color: Colors.blue),
                                labelText: "Địa chỉ",
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                          SizedBox(height: 30),
                          GestureDetector(
                            onTap: () {
                              _showPicker(context);
                            },
                            child: Container(
                              height: 140,
                              width: 140,
                              child: _imageFile != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(0),
                                      child: Image.file(
                                        _imageFile,
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(0)),
                                      width: 120,
                                      height: 120,
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            // child: Text(
                            //   "Ảnh đại diện",
                            //   style:
                            //       TextStyle(backgroundColor: Constants.primary),
                            // ),
                            child: TextNotch(
                              text: "Ảnh đại diện",
                              color: Constants.primary,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Constants.primary, width: 1),
                                  borderRadius: BorderRadius.circular(8)),
                              child: SizedBox(
                                child: MergeSemantics(
                                  child: ListTile(
                                    title: const Text(
                                        'Bạn muốn trở thành tài xế?'),
                                    trailing: CupertinoSwitch(
                                      activeColor: Constants.primary,
                                      value: _isDriver,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _isDriver = value;
                                        });
                                      },
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _isDriver = !_isDriver;
                                      });
                                    },
                                  ),
                                ),
                              )),
                          SizedBox(height: 30),
                        ]),
                      ),
                      RoundedButtonGradient(
                        text: "Đăng ký",
                        color: Constants.primary,
                        height: 50,
                        width: mQSize.width * 0.8,
                        press: () {
                          String _fileName = _uuid.v4();
                          String _fileReference =
                              'images/students/profiles/${_textStudentIdController.text}/$_fileName.png';
                          _uploadFile(_imageFile.path, _fileReference);
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.

                            _addUser();
                          }
                        },
                      ),
                    ]),
              ),
            )
          ],
        ),
      )),
    );
  }
}
