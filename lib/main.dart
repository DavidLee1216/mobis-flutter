import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobispartsearch/repository/cart_repository.dart';
import 'package:mobispartsearch/repository/market_search_repository.dart';
import 'package:mobispartsearch/repository/simple_search_repository.dart';
import 'package:mobispartsearch/bloc/auth_bloc.dart';
import 'package:mobispartsearch/bloc/notice_bloc.dart';
import 'package:mobispartsearch/repository/user_repository.dart';
import 'package:mobispartsearch/repository/notice_repository.dart';
import 'package:mobispartsearch/ui/widget/navigation_bar.dart';
import 'bloc/cart_bloc.dart';
import 'bloc/market_search_bloc.dart';
import 'bloc/simple_search_bloc.dart';

import 'package:mobispartsearch/common.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  HttpOverrides.global = new TestHttpOverrides();

  getSession();
  getGloablModels();
  getSido();

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
            lazy: false,
            create: (context) => NoticeBloc(
              noticeRepository: noticeRepository,
            ),
          ),
          BlocProvider<CartBloc>(
              lazy: false,
              create: (context) => CartBloc(cartRepository: cartRepository)),
          BlocProvider<SimpleSearchBloc>(
              lazy: false,
              create: (context) => SimpleSearchBloc(
                  simpleSearchRepository: simpleSearchRepository)),
          BlocProvider<MarketSearchBloc>(
              lazy: false,
              create: (context) => MarketSearchBloc(
                  marketSearchRepository: marketSearchRepository)),
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
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [
        const Locale('en'),
        const Locale('ko'),
      ],
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.white,
      ),
      home: NavigationBar(
        index: 1,
      ),
    );
  }
}
