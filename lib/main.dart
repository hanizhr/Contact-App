import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contactprovider.dart';
import 'recent.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final fonstProvider = FonstProvider();
  await fonstProvider.loadFont();

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  runApp(MainPage(
    fonstProvider: fonstProvider,
    themeProvider: themeProvider,
  ));
}

class MainPage extends StatelessWidget {
  final FonstProvider fonstProvider;
  final ThemeProvider themeProvider;

  const MainPage({
    super.key,
    required this.fonstProvider,
    required this.themeProvider,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContactProvider()),
        ChangeNotifierProvider(create: (_) => fonstProvider),
        ChangeNotifierProvider(create: (_) => themeProvider),
      ],
      child: Consumer<ThemeProvider>(
        builder: (BuildContext context, themeProvider, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness:
                  themeProvider.dark ? Brightness.dark : Brightness.light,
              fontFamily: context.watch<FonstProvider>().font,
            ),
            home: const SafeArea(child: Recents()),
          );
        },
      ),
    );
  }
}
