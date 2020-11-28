
import 'package:bloc/bloc.dart';
import 'package:mobispartsearch/common.dart';
import 'package:mobispartsearch/model/user_model.dart';
import 'package:mobispartsearch/repository/user_repository.dart';
import 'package:meta/meta.dart';

abstract class AuthEvent {}

class AuthEventAppStarted extends AuthEvent {}

class AuthEventSignIn extends AuthEvent {
  final String id, password;

  AuthEventSignIn({@required this.id, @required this.password});
}

class AuthEventSignUp extends AuthEvent {
  final User user;

  AuthEventSignUp({
    @required this.user,
  });
}

class AuthEventSignOut extends AuthEvent {
  final Function() completeCallback;

  AuthEventSignOut({this.completeCallback});
}

class AuthState {
  String errorMsg;
  String id;
  String password;
  bool signUpSucc;
  bool isLoading;

  AuthState({
    this.errorMsg = '',
    this.id = '',
    this.password = '',
    this.signUpSucc = false,
    this.isLoading = false,
  });

  bool isAuthenticated() => id.isNotEmpty;

  bool hasError() => errorMsg.isNotEmpty;

  AuthState _setProps(
          {String errorMsg,
          String id,
          String password,
          bool signUpSucc,
          bool isLoading}) =>
      AuthState(
        errorMsg: errorMsg ?? '',
        id: id ?? this.id,
        password: password ?? this.password,
        signUpSucc: signUpSucc ?? false,
        isLoading: isLoading ?? this.isLoading,
      );

  factory AuthState.init() => AuthState();

  AuthState success({String id, bool signUpSucc}) =>
      _setProps(id: id, signUpSucc: signUpSucc, isLoading: false);

  AuthState unauthenticated(String errorMsg) =>
      AuthState.init()..errorMsg = errorMsg;

  AuthState submitting() => _setProps(isLoading: true);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserRepository userRepository;

  AuthBloc({@required this.userRepository}) : super(AuthState());

  AuthState get initialState => AuthState.init();

  @override
  Stream<AuthState> mapEventToState(event) async* {
    if (event is AuthEventAppStarted) {
      yield* _mapAppStartedToState(event);
    }
    if (event is AuthEventSignIn) {
      yield* _mapSignInToState(event);
    }
    if (event is AuthEventSignUp) {
      yield* _mapSignUpToState(event);
    }
  }

  Stream<AuthState> _mapAppStartedToState(AuthEventAppStarted event) async* {
    yield (state.unauthenticated(''));
  }

  Stream<AuthState> _mapSignInToState(AuthEventSignIn event) async* {
    try {
      yield state.submitting();
      if (await userRepository.signIn(event.id, event.password) == true) {
        globalUsername = event.id;
        yield state.success(id: event.id);
      } else
        yield state.unauthenticated('로그인 실패!');
    } catch (e) {
      yield state.unauthenticated(e.toString());
    }
  }

  Stream<AuthState> _mapSignUpToState(AuthEventSignUp event) async* {
    try {
      yield state.submitting();
      if (await userRepository.signUp(event.user) == true)
        yield state.success(signUpSucc: true);
      else
        yield state.unauthenticated('가입 실패!');
    } catch (e) {
      yield state.unauthenticated(e.toString());
    }
  }
//
//  Stream<AuthState> _mapSignedOutToState(AuthEventSignOut event) async* {
//    try {
//      await userRepository.signOut();
//      yield state.unauthenticated('');
//      if (event.completeCallback != null) {
//      }
//    } catch (e) {
//      yield state.unauthenticated(e.toString());
//    }
//  }
}
