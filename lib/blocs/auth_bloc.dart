import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ht/blocs/auth_events.dart';
import 'package:ht/blocs/auth_state.dart';
import 'package:ht/repository/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvents, AuthState> {
  AuthRepository repo;
  AuthBloc(AuthState initialState, this.repo) : super(initialState);

  @override
  Stream<AuthState> mapEventToState(AuthEvents event) async* {
    var pref = await SharedPreferences.getInstance();
    // TODO: implement mapEventToState
    if (event is StartEvent) {
      yield LoginInitState();
    } else {
      if (event is LoginButtonPressed) {
        yield LoginLoadingState();
        var data = await repo.login(event.email, event.password);
        if (data['statueCode'] == 200) {
          pref.setString("token", data['token']);
          pref.setString("email", data['email']);
          yield UserLoginSuccesState();
        }
      }
    }
  }
}
