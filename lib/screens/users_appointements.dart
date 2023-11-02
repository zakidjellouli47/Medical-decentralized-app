class User {
  String UID; // class objects
  String firstname;
  String lastname;
  String age;
  String email;
  String ilnessdescription;
  String date;
  String doctors;
  String ethereumAddress;

// constructor
  User({required this.UID, required this.firstname, required this.lastname, required this.age,  required this.email, required this.ilnessdescription,required this.date,required this.doctors,required this.ethereumAddress});
//https://www.youtube.com/watch?v=Qpw59OJVvgo&t=663s
  factory User.fromJson(Map<String, dynamic> json) {//we use the factory keyword when implementing a constructor that doesn’t always create a new instance of its class
    // from json means we took the records as json format and we convert them to objects in order to read the table after that
    // mapping a string with a dynamic value since the key stays string always but the value in json can be anything
    return User(//  returning the user object from jsob
      UID: json['UID'] as String,// taking the id from json and parse as a string
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      age: json['age'] as String,
      email: json['email'] as String,
      ilnessdescription: json['ilnessdescription'] as String,
      date: json['date'] as String,
      doctors: json['doctors'] as String,
      ethereumAddress: json['ethereumAddress']as String,

    );
  }
}