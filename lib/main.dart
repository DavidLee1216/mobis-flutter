
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyundai_mobis/repository/cart_repository.dart';
import 'package:hyundai_mobis/repository/market_search_repository.dart';
import 'package:hyundai_mobis/repository/simple_search_repository.dart';
import 'package:hyundai_mobis/bloc/auth_bloc.dart';
import 'package:hyundai_mobis/bloc/notice_bloc.dart';
import 'package:hyundai_mobis/repository/user_repository.dart';
import 'package:hyundai_mobis/repository/notice_repository.dart';
import 'package:hyundai_mobis/ui/widget/navigation_bar.dart';

import 'bloc/cart_bloc.dart';
import 'bloc/market_search_bloc.dart';
import 'bloc/simple_search_bloc.dart';

import 'package:hyundai_mobis/common.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  get_session();
  get_sido();

  UserRepository userRepository = UserRepository();
  NoticeRepository noticeRepository = NoticeRepository();
  SimpleSearchRepository simpleSearchRepository = SimpleSearchRepository();
  MarketSearchRepository marketSearchRepository = MarketSearchRepository();
  CartRepository cartRepository = CartRepository();
  runApp(
    BlocProvider<AuthBloc>(
      create: (context) =>
          AuthBloc(userRepository: userRepository)..add(AuthEventAppStarted()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NoticeBloc>(
            create: (context) => NoticeBloc(
              noticeRepository: noticeRepository,
            ),
          ),
          BlocProvider<SimpleSearchBloc>(create: (context)=>SimpleSearchBloc(simpleSearchRepository: simpleSearchRepository)),
          BlocProvider<MarketSearchBloc>(create: (context)=>MarketSearchBloc(marketSearchRepository: marketSearchRepository)),
          BlocProvider<CartBloc>(create: (context)=>CartBloc(cartRepository: cartRepository)),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.white,
      ),
      home: NavigationBar(index: 1,),
    );
  }
}
