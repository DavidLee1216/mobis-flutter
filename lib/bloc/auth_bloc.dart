import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hyundai_mobis/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthEvent{}

class AuthEventAppStarted extends AuthEvent {
}

class AuthEventSignIn extends AuthEvent {
  final String id, password;

  AuthEventSignIn({@required this.id, @required this.password});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AuthEventSignUp extends AuthEvent {
  final String email, password;

  AuthEventSignUp({@required this.email, @required this.password});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AuthEventSignOut extends AuthEvent {
  final Function() completeCallback;

  AuthEventSignOut({this.completeCallback});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AuthState {
  String uid;
  String errorMsg;
  String id;
  String password;
  bool isLoading;

  AuthState({
    this.uid = '',
    this.errorMsg = '',
    this.id = '',
    this.password = '',
    this.isLoading = false,
  });

  bool isAuthenticated() => uid.isNotEmpty;

  bool hasError() => errorMsg.isNotEmpty;

  AuthState _setProps(
      {String uid,
        String errorMsg,
        String id,
        String password,
        bool isLoading}) =>
      AuthState(
        uid: uid ?? this.uid,
        errorMsg: errorMsg ?? '',
        id: id ?? this.id,
        password: password ?? this.password,
        isLoading: isLoading ?? this.isLoading,
      );

  factory AuthState.init() => AuthState();

  AuthState success({@required String uid}) =>
      _setProps(uid: uid, isLoading: false);

  AuthState unauthenticated(String errorMsg) =>
      AuthState.init()..errorMsg = errorMsg;

  AuthState submitting() => _setProps(isLoading: true);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserRepository userRepository;

  AuthBloc({@required this.userRepository}) : super(AuthState());

  @override
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
  }

  Stream<AuthState> _mapAppStartedToState(AuthEventAppStarted event) async* {
    try {
      bool isSignedIn = await userRepository.isSignedIn();
      if (isSignedIn) {
        final user = await userRepository.getUser();
        yield (state.success(uid: user.uid));
      } else {
        yield (state.unauthenticated(''));
      }
    } catch (e) {
      yield state.unauthenticated(e.toString());
    }
  }

  Stream<AuthState> _mapSignInToState(AuthEventSignIn event) async* {
    try {
      yield state.submitting();
      final user = await userRepository.signInWithCredentials(
        id: event.id,
        password: event.password,
      );
      yield state.success(uid: user.uid);
    } catch (e) {
      yield state.unauthenticated(e.toString());
    }
  }

  Stream<AuthState> _mapSignUpToState(AuthEventSignUp event) async* {
    try {
      yield state.submitting();
      final user = await userRepository.signUp(
        email: event.email,
        password: event.password,
      );
      yield state.success(uid: user.uid);
    } catch (e) {
      yield state.unauthenticated(e.toString());
    }
  }

  Stream<AuthState> _mapSignedOutToState(AuthEventSignOut event) async* {
    try {
      await userRepository.signOut();
      yield state.unauthenticated('');
      if (event.completeCallback != null) {
        event.completeCallback();
      }
    } catch (e) {
      yield state.unauthenticated(e.toString());
    }
  }
}
