import 'package:contanct_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'allContacts.dart';
import 'contactprovider.dart';
import 'details.dart';
import 'favorite.dart';
import 'setting.dart';
import 'theme.dart';

class Recents extends StatefulWidget {
  const Recents({
    super.key,
  });

  @override
  State<Recents> createState() => _RecentsState();
}

class _RecentsState extends State<Recents> {
  @override
  Widget build(BuildContext context) {
    var allcontact = context.watch<ContactProvider>().allContacts;
    var dark = context.watch<ThemeProvider>().dark;
    Color textColor = dark ? secendery : gray;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        color: primaryColor,
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     OutlinedButton(
            //         style: ButtonStyle(
            //           backgroundColor:
            //               WidgetStateProperty.all<Color>(secendery),
            //         ),
            //         onPressed: () {},
            //         child: const Text('All')),
            //     const SizedBox(
            //       width: 20,
            //     ),
            //     OutlinedButton(
            //         onPressed: () {},
            //         child: Text(
            //           'Missed',
            //           style: TextStyle(color: secendery),
            //         )),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recents',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: secendery),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        context.read<ContactProvider>().removeAll();
                      });
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      color: secendery,
                    ))
              ],
            ),
            SizedBox(
              height: 45,
              width: 380,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: secendery,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  prefixIconColor: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: allcontact.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var person = allcontact[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Details(index)));
                    },
                    child: Dismissible(
                        key: UniqueKey(),
                        background: Container(
                            color: const Color.fromARGB(255, 239, 68, 68)),
                        secondaryBackground: Container(
                            color: const Color.fromARGB(255, 34, 197, 94)),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                            context
                                .read<ContactProvider>()
                                .removeFromList(allcontact[index]);
                          } else {
                            makingPhoneCall(allcontact[index].numb['phone']);
                          }
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(
                              person.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: textColor),
                            ),
                            subtitle: Text(
                              person.numb['phone'].toString(),
                              style: TextStyle(color: textColor),
                            ),
                            leading: Icon(
                              Icons.person,
                              color: primaryColor,
                            ),
                            trailing: Column(
                              children: [
                                Icon(
                                  Icons.call,
                                  color: primaryColor,
                                ),
                                Text(
                                  '12:45',
                                  style: TextStyle(color: textColor),
                                )
                              ],
                            ),
                          ),
                        )),
                  );
                },
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: secendery),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FavoritePage()),
                        );
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: primaryColor,
                      )),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Setting()),
                        );
                      },
                      icon: Icon(
                        Icons.settings,
                        color: primaryColor,
                      )),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AllContacts()),
                        );
                      },
                      icon: Icon(
                        Icons.person,
                        color: primaryColor,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
