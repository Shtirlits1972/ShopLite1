import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplite1/model/users.dart';

class KeeperUser {
  users user = users.empty();
}

class DataCubitUser extends Cubit<KeeperUser> {
  users get getUser => state.user;

  setCurrentUser(users NewUser) {
    state.user = NewUser;
  }

  DataCubitUser(KeeperUser initState) : super(initState);
}
