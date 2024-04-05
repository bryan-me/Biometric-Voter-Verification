import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/barcode_scanner.dart';
import 'package:flutter_application_1/screens/camera_page.dart';
import 'package:flutter_application_1/screens/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  


  @override
  Widget build(BuildContext context) {
    var selectedIndex = 0;
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const barcode();
        break;
      case 1:
        page = const LoginPage(title: 'Fingerprint Verification');
        break;
      case 2:
        page = const Camera();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    // The container for the current page, with its background color
    // and subtle switching animation.
    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: page,
      ),
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 450) {
            // Use a more mobile-friendly layout with BottomNavigationBar
            // on narrow screens.
            return Column(
              children: [
                Expanded(child: mainArea),
                //SafeArea(
                   BottomNavigationBar(
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.barcode_reader),
                        label: 'Barcode Scanner',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.fingerprint),
                        label: 'Fingerprint',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.face),
                        label: 'Facial Recognition',
                      ),
                    ],
                    currentIndex: selectedIndex,
                    onTap: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                //)
              ],
            );
          } else {
            return Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    extended: constraints.maxWidth >= 600,
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.barcode_reader),
                        label: Text('Barcode Scanner'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.fingerprint),
                        label: Text('Fingerprint'),
                      ),
                       NavigationRailDestination(
                        icon: Icon(Icons.face),
                        label: Text('Facial Recognition'),
                      ),
                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                ),
                Expanded(child: mainArea),
              ],
            );
          }
        },
      ),
    );
  }



}
