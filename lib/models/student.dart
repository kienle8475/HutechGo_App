import 'package:hutech_go/services/convert_service.dart';

class Student {
  String studentId;
  String userId;
  String phoneNumber;
  String studentName;
  String gender;
  String birthday;
  String address;
  String schoolClass;
  String email;
  String profileImage;
  String idcardImage;
  String university;
  String status;
  bool isDriver;

  Student(
      this.studentId,
      this.userId,
      this.phoneNumber,
      this.studentName,
      this.gender,
      this.birthday,
      this.address,
      this.email,
      this.profileImage,
      this.idcardImage,
      this.university,
      this.status,
      this.isDriver,
      this.schoolClass);

  get getStudentId => this.studentId;

  set setStudentId(studentId) => this.studentId = studentId;

  get getUserId => this.userId;

  set setUserId(userId) => this.userId = userId;

  get getPhoneNumber => this.phoneNumber;

  set setPhoneNumber(phoneNumber) => this.phoneNumber = phoneNumber;

  get getStudentName => this.studentName;

  set setStudentName(studentName) => this.studentName = studentName;

  get getGender => this.gender;

  set setGender(gender) => this.gender = gender;

  get getBirthday => this.birthday;

  set setBirthday(birthday) => this.birthday = birthday;

  get getAddress => this.address;

  set setAddress(address) => this.address = address;

  get getEmail => this.email;

  set setEmail(email) => this.email = email;

  get getProfileImage => this.profileImage;

  set setProfileImage(profileImage) => this.profileImage = profileImage;

  get getIdcardImage => this.idcardImage;

  set setIdcardImage(idcardImage) => this.idcardImage = idcardImage;

  get getUniversity => this.university;

  set setUniversity(university) => this.university = university;

  get getStatus => this.status;

  set setStatus(status) => this.status = status;

  get getIsDriver => this.isDriver;

  set setIsDriver(isDriver) => this.isDriver = isDriver;

  get getSchoolClass => this.schoolClass;

  set setSchoolClass(String schoolClass) => this.schoolClass = schoolClass;

  Student.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    phoneNumber = json['phone_number'];
    studentName = json['student_name'];
    gender = json['gender'];
    birthday = json['birthday'];
    address = json['address'];
    email = json['email'];
    profileImage = json['profile_image'];
    idcardImage = json['idcard_image'];
    university = json['university'];
    status = json['status'];
    isDriver = json['is_driver'];
    schoolClass = json['class'];
  }
}
