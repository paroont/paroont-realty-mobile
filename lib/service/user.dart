import 'package:paroont_realty_mobile/model/user.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  static final RealtyUser user = RealtyUser();
  factory UserService() {
    return _instance;
  }

  UserService._internal();

 RealtyUser getUser()
  {
    return user;
  }


}
