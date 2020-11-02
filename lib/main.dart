import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyundai_mobis/ui/screen/cart_screen.dart';
import 'package:hyundai_mobis/ui/screen/login_screen.dart';
import 'package:hyundai_mobis/ui/screen/part_simple_search_screen.dart';
import 'package:hyundai_mobis/ui/screen/register_screen.dart';
import 'package:hyundai_mobis/ui/screen/id_login_screen.dart';
import 'package:hyundai_mobis/ui/screen/home_screen.dart';
import 'package:hyundai_mobis/ui/screen/notice_screen.dart';
import 'package:hyundai_mobis/bloc/auth_bloc.dart';
import 'package:hyundai_mobis/bloc/notice_bloc.dart';
import 'package:hyundai_mobis/repository/user_repository.dart';
import 'package:hyundai_mobis/repository/notice_repository.dart';
import 'package:hyundai_mobis/ui/screen/part_market_search_screen.dart';
import 'package:hyundai_mobis/ui/screen/pass_reset_screen.dart';
import 'package:hyundai_mobis/ui/screen/purchase_request_screen.dart';
import 'package:hyundai_mobis/ui/screen/delivery_screen.dart';
import 'package:hyundai_mobis/ui/screen/visit_screen.dart';
import 'package:hyundai_mobis/ui/screen/notification_screen.dart';
import 'package:hyundai_mobis/ui/screen/my_page_screen.dart';
import 'package:hyundai_mobis/ui/screen/my_info_screen.dart';
import 'package:hyundai_mobis/ui/screen/my_coupon_screen.dart';
import 'package:hyundai_mobis/ui/widget/navigation_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserRepository userRepository = UserRepository();
  NoticeRepository noticeRepository = NoticeRepository();
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
      // initialRoute: '/',
       routes: {
      //   '/': (context) => HomeScreen(),
      //   '/login': (context) => LoginScreen(),
      //   '/register': (context) => RegisterScreen(),
      //   '/getpass': (context) => GetPassScreen(),
      //   '/home': (context) => HomeScreen(),
      //   '/idlogin': (context) => IdLoginScreen(),
      //   '/notice': (context) => NoticeScreen(),
      //   '/notification': (context) => NotificationScreen(),
      //   '/simpleSearch': (context) => PartSimpleSearchScreen(),
      //   '/marketSearch': (context) => PartMarketSearchScreen(),
      //   '/purchase': (context) => PurchaseRequestScreen(),
      //   '/addToCart': (context) => CartScreen(),
      //   '/delivery': (context) => DeliveryScreen(),
      //   '/visit': (context) => VisitScreen(),
      //   '/my_page': (context) => MyPageScreen(),
      //   '/my_info': (context) => MyInfoScreen(),
      //   '/coupon': (context) => MyCouponScreen(),
       },
    );
  }
}
