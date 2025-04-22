import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logiology_machinetest/features/auth/presentation/view/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // height = MediaQuery.of(context).size.height;
    // width = MediaQuery.of(context).size.width;

    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(
    //       create: (context) => UserProvider(sl<IUserFacade>()),
    //     ),
    //     ChangeNotifierProvider(create: (_) =>AddItemProvider(sl<IItemFacade>()),),
    //     ChangeNotifierProvider(create: (_) => OrderHistoryProvider( sl<IOrderHistoryFacade>())),
    //     ChangeNotifierProvider(create: (context) => OrderSummeryProvider(sl<IOrderSummeryFacade>()),),
    //     ChangeNotifierProvider(create: (_)=> HomeProvider(sl<IHomeFacade>(),),),
    //     ChangeNotifierProvider(create: (_)=>TodayOrderProvider(sl<ITodayOrderFacade>()),),
    //     ChangeNotifierProvider(create: (_) => UserPaymentProvider(sl<IUserPaymentFacade>()),),
    //     ChangeNotifierProvider(create: (_) =>OrderDetailsProvider(sl<IOrderDetailsFacade>()) ,)
    //   ],
    //child:
    return MaterialApp(
      // navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      // ),
    );
  }
}
