import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:mobispartsearch/app_config.dart';
import 'package:mobispartsearch/model/user_model.dart';
import 'package:mobispartsearch/repository/user_repository.dart';
import 'package:meta/meta.dart';

enum LoginType {NONE, GOOGLE, NAVER, KAKAO}

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

class AuthEventLoading extends AuthEvent {}

class AuthEventUnLoading extends AuthEvent {}

class AuthEventSignOut extends AuthEvent {}

class AuthEventGoogleSignin extends AuthEvent {}

class AuthEventNaverSignin extends AuthEvent {}

class AuthEventKakaoSignin extends AuthEvent {}

class AuthState {
  String errorMsg;
  String id;
  String password;
  bool signUpSucc;
  bool isLoading;
  LoginType loginType;

  AuthState({
    this.errorMsg = '',
    this.id = '',
    this.password = '',
    this.signUpSucc = false,
    this.isLoading = false,
    this.loginType = LoginType.NONE,
  });

  bool isAuthenticated() => id.isNotEmpty;

  bool hasError() => errorMsg.isNotEmpty;

  AuthState _setProps(
          {String errorMsg,
          String id,
          String password,
          bool signUpSucc,
          bool isLoading,
          LoginType loginType,
          }) =>
      AuthState(
        errorMsg: errorMsg ?? '',
        id: id ?? this.id,
        password: password ?? this.password,
        signUpSucc: signUpSucc ?? false,
        isLoading: isLoading ?? this.isLoading,
        loginType: loginType ?? LoginType.NONE,
      );

  factory AuthState.init() => AuthState();

  AuthState success({String id, String password, bool signUpSucc, LoginType loginType}) =>
      _setProps(id: id, password: password, signUpSucc: signUpSucc, isLoading: false, loginType: loginType);

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
    if (event is AuthEventSignOut) {
      yield* _mapSignedOutToState(event);
    }
    if (event is AuthEventGoogleSignin) {
      yield* _mapGoogleSigninToState(event);
    }
    if (event is AuthEventKakaoSignin) {
      yield* _mapKakaoSigninToState(event);
    }
    if (event is AuthEventNaverSignin) {
      yield* _mapNaverSigninToState(event);
    }
    if(event is AuthEventLoading){
      yield* _mapLoadingToState(event);
    }
    if(event is AuthEventUnLoading){
      yield* _mapUnloadingToState(event);
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
        yield state.success(id: event.id, password: event.password);
      } else
        yield state.unauthenticated('아이디 또는 패스워드 오류입니다.');
    } catch (e) {
      yield state.unauthenticated(e.toString());
    }
  }

  Stream<AuthState> _mapSignUpToState(AuthEventSignUp event) async* {
    try {
      yield state.submitting();
      if (await userRepository.signUp(event.user) == true)
      {
        yield state.success(id: event.user.username, password: event.user.password, signUpSucc: true);
      }
      else
        yield state.unauthenticated('가입 실패!');
    } catch (e) {
      yield state.unauthenticated(e.toString());
    }
  }

  Stream<AuthState> _mapSignedOutToState(AuthEventSignOut event) async* {
    try {
      yield state.submitting();
      if(await userRepository.signOut() == true)
        yield state.unauthenticated('');
      else
        yield state.success();
    } catch (e) {
      yield state.unauthenticated(e.toString());
    }
  }

  Stream<AuthState> _mapGoogleSigninToState(AuthEventGoogleSignin event) async* {
    yield state.success(loginType: LoginType.GOOGLE);
  }

  Stream<AuthState> _mapKakaoSigninToState(AuthEventKakaoSignin event) async* {
    yield state.success(loginType: LoginType.KAKAO);
  }

  Stream<AuthState> _mapNaverSigninToState(AuthEventNaverSignin event) async* {
    yield state.success(loginType: LoginType.NAVER);
  }

  Stream<AuthState> _mapLoadingToState(AuthEventLoading event) async*{
    yield state.submitting();
  }

  Stream<AuthState> _mapUnloadingToState(AuthEventUnLoading) async*{
    yield state.success();
  }

}
