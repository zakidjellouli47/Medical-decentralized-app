


class User {
  String UID;
   String firstname;
   String lastname;
  String age;
  String role;
  String email;
  String pass;
  String ethereumAddress;


  User({ required this.UID, required this.firstname, required this.lastname, required this.age, required this.role, required this.email, required this.pass,required this.ethereumAddress});

  factory User.fromJson(Map<String, dynamic> json) {//we use the factory keyword when implementing a constructor that doesn’t always create a new instance of its class
    // from json means we took the records as json format and we convert them to objects in order to read the table after that
    // mapping a string with a dynamic value since the key stays string always but the value in json can be anything
//deserialization
    return User(//  returning the user object from jsob
      UID: json['UID'] as String,// taking the id from json and parse as a string
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      age: json['age'] as String,
      role: json['role'] as String,
      email: json['email'] as String,
      pass: json['pass'] as String,
      ethereumAddress: json['ethereumAddress'] as String,

    );
  }
}