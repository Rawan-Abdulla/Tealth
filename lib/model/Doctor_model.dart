class DoctorModel {
  String? uid;
  String? email;
  String? firstName;
  String? role;
  //String? id;
  String? gender;
  String? age;
  String? phoneNumber;
  String? StartWorkTime;
  String? EndWorkTime;
  String? location;

  String? imageUrl;

  String? specialistDoctor;
  // Location? location;

  DoctorModel(
      {this.uid,
        this.email,
        this.firstName,
        this.role,
        //this.id,
        this.gender,
        this.age,
        this.phoneNumber,
        this.StartWorkTime,
        this.EndWorkTime,
        this.specialistDoctor,
        this.imageUrl,
        this.location});

  // receiving data from server
  factory DoctorModel.fromMap(map) {
    return DoctorModel(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        role: map['role'],
        //id: map['id'],
        gender: map['gender'],
        age: map['age'],
        phoneNumber: map['phoneNumber'],
        StartWorkTime: map['StartWorkTime'],
        EndWorkTime: map['EndWorkTime'],
        specialistDoctor: map['specialistDoctor'],
        imageUrl: map['imageUrl'],
        location: map['location']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'role': role,
      //'id': id,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'StartWorkTime': StartWorkTime,
      'EndWorkTime': EndWorkTime,
      'specialistDoctor': specialistDoctor,
      'imageUrl': imageUrl,
      'location': location
    };
  }
}
