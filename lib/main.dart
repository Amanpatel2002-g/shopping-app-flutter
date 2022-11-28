import 'package:amazon_new/constants/bottomNavigation_bar.dart';
import 'package:amazon_new/constants/loader.dart';
import 'package:amazon_new/features/admin/screen/admin_screen.dart';
import 'package:amazon_new/providers/user_provider.dart';
import 'package:amazon_new/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/global_variables.dart';
import 'features/screens/auth/auth_screen.dart';
import 'features/screens/home/screens/home_screen.dart';
import 'services/auth_service.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const Myapp()));
}

class Myapp extends StatefulWidget {
  const Myapp({Key? key}) : super(key: key);
  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  final AuthServices authServices = AuthServices();
  Widget? startingWidget;
  @override
  void initState() {
    super.initState();
    initalize();
  }

  void initalize() async {
    await authServices.getUserData(context);
    Provider.of<UserProvider>(context, listen: false).user.token.isNotEmpty
        ? Provider.of<UserProvider>(context, listen: false).user.type == 'user'
            ? startingWidget = const BottomBar()
            : startingWidget = const AdminScreen()
        : startingWidget = const AuthScreen();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: GlobalVariables.backgroundColor,
            colorScheme: const ColorScheme.light(
                primary: Color.fromARGB(255, 234, 172, 73)),
            appBarTheme: const AppBarTheme(
                elevation: 0, iconTheme: IconThemeData(color: Colors.black))),
        onGenerateRoute: ((settings) => generateRoute(settings)),
        // ignore: prefer_if_null_operators
        home: startingWidget == null ? const Loader() : startingWidget
        // home: const AdminScreen(),
        );
  }
}
