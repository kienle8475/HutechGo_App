class DriverResponse {
  String reponseId;
  num distance;
  num timeArrival;
  String universityName;
  String studentName;
  String imageProfile;
  num price;
  bool status;
  DriverResponse({
    this.reponseId,
    this.distance,
    this.timeArrival,
    this.universityName,
    this.studentName,
    this.imageProfile,
    this.price,
    this.status,
  });
  DriverResponse.fromJson(Map<String, dynamic> json) {
    reponseId = json['reponse_id'];
    distance = json['distance'];
    timeArrival = json['time_arrival'];
    universityName = json['university_name'];
    studentName = json['student_name'];
    imageProfile = json['image_profile'];
    price = json['price'];
    status = json['status'];
  }
  get getReponseId => this.reponseId;

  set setReponseId(String reponseId) => this.reponseId = reponseId;

  get getDistance => this.distance;

  set setDistance(distance) => this.distance = distance;

  get getTimeArrival => this.timeArrival;

  set setTimeArrival(timeArrival) => this.timeArrival = timeArrival;

  get getUniversityName => this.universityName;

  set setUniversityName(universityName) => this.universityName = universityName;

  get getStudentName => this.studentName;

  set setStudentName(studentName) => this.studentName = studentName;

  get getImageProfile => this.imageProfile;

  set setImageProfile(imageProfile) => this.imageProfile = imageProfile;

  get getPrice => this.price;

  set setPrice(price) => this.price = price;

  get getStatus => this.status;

  set setStatus(status) => this.status = status;
}
