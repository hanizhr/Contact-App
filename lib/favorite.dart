import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contactprovider.dart';
import 'theme.dart';

// ignore: must_be_immutable
class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    var allcontact = context.watch<ContactProvider>().allContacts;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(
          child: Text(
            'Favorite',
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
      body: Container(
        color: secendery,
        child: ListView.builder(
          itemCount: allcontact.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var person = allcontact[index];
            return Column(
              children: [
                allcontact[index].isFavorite
                    ? ListTile(
                        title: Text(
                          person.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: primaryColor),
                        ),
                        subtitle: Text(person.numb['phone'].toString()),
                        leading: Icon(
                          Icons.person,
                          color: primaryColor,
                        ),
                        trailing: Icon(
                          Icons.favorite,
                          color: primaryColor,
                        ))
                    : const SizedBox(),
                allcontact[index].isFavorite
                    ? const Divider()
                    : const SizedBox(),
              ],
            );
          },
        ),
      ),
    );
  }
}
