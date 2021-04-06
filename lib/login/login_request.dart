import 'package:uts_daftar_lagu/helper/dbhelper.dart';
import 'package:uts_daftar_lagu/models/user.dart';

class LoginRequest {
  DbHelper dbHelper = new DbHelper();
  Future<User> getLogin(String username, String password) {
    var result = dbHelper.getLogin(username, password);
    return result;
  }
}
