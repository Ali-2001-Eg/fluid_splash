import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homepage.dart';

// NOTE: You can change the pictures in images folder if you want to use. If you want a good experience then my suggestion is to use the illustrations.
// If you like the project then don't forget to give a star to the project.
// Connect with me on LinkedIn: https://www.linkedin.com/in/imran-farooq-8192b1238/

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // For full screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );

  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Showcase(title: 'Fluid Splash'),
    );
  }
}
