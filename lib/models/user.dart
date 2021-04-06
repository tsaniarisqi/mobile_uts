class User {
  int _id;
  String _username;
  String _password;

  /*Setter untuk memasukkan nilai
  getter untuk mengambil nilai */
  int get id => this._id;

  get username => this._username;
  set username(value) => this._username = value;

  get password => this._password;
  set password(value) => this._password = value;

  // konstruktor versi 1
  User(this._username, this._password);

  // konstruktor versi 2: konversi dari Map ke User
  User.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._username = map['username'];
    this._password = map['password'];
  }

  // konversi dari User ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['username'] = username;
    map['password'] = password;
    return map;
  }
}
