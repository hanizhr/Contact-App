import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'contactprovider.dart';
import 'theme.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    bool thm = context.read<ThemeProvider>().dark;
    String f = context.read<FonstProvider>().font;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(
          child: Text(
            'Setting',
            style: TextStyle(color: secendery, fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            icon: Icon(
              Icons.arrow_back,
              color: secendery,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      thm ? Icons.nightlight : Icons.sunny,
                      color: primaryColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    thm ? const Text('Dark') : const Text('Light'),
                  ],
                ),
                Switch(
                  value: thm,
                  activeColor: primaryColor,
                  onChanged: (value) {
                    context.read<ThemeProvider>().toggleTheme();
                  },
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.abc,
                      color: primaryColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text('Shadow'),
                  ],
                ),
                Switch(
                  value: f == 'Shadow' ? true : false,
                  activeColor: primaryColor,
                  onChanged: (value) {
                    f = 'Shadow';
                    context.read<FonstProvider>().setFont('Shadow');
                  },
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.abc,
                      color: primaryColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text('Edu'),
                  ],
                ),
                Switch(
                  value: f == 'Edu' ? true : false,
                  activeColor: primaryColor,
                  onChanged: (value) {
                    f = 'Edu';
                    context.read<FonstProvider>().setFont('Edu');
                  },
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.abc,
                      color: primaryColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text('Pacf'),
                  ],
                ),
                Switch(
                  value: f == 'Pacf' ? true : false,
                  activeColor: primaryColor,
                  onChanged: (value) {
                    f = 'Pacf';
                    context.read<FonstProvider>().setFont('Pacf');
                  },
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.abc,
                      color: primaryColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text('Schib'),
                  ],
                ),
                Switch(
                  value: f == 'Schib' ? true : false,
                  activeColor: primaryColor,
                  onChanged: (value) {
                    f = 'Schib';
                    context.read<FonstProvider>().setFont('Schib');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
