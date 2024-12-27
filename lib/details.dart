import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'addNewContact.dart';
import 'contactprovider.dart';
import 'theme.dart';
import 'utils.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
  int id;
  Details(this.id, {super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    var allcontact = context.watch<ContactProvider>().allContacts;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(
          child: Text(
            'Details',
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(125),
                child: Icon(
                  Icons.person,
                  color: primaryColor,
                  size: 100,
                )),
            Text(
              allcontact[widget.id].name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(allcontact[widget.id].email),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      makingPhoneCall(allcontact[widget.id].numb['phone']);
                    },
                    icon: Icon(
                      Icons.call,
                      color: primaryColor,
                    )),
                IconButton(
                    onPressed: () {
                      sendingMails(allcontact[widget.id].email);
                    },
                    icon: Icon(
                      Icons.email,
                      color: primaryColor,
                    )),
                IconButton(
                    onPressed: () {
                      sendingSMS(allcontact[widget.id].numb['phone']);
                    },
                    icon: Icon(
                      Icons.message,
                      color: primaryColor,
                    )),
                IconButton(
                    onPressed: () {
                      allcontact[widget.id].isFavorite
                          ? (context
                              .read<ContactProvider>()
                              .removeFromFavorite(allcontact[widget.id]))
                          : (context
                              .read<ContactProvider>()
                              .addToFavorite(allcontact[widget.id]));
                    },
                    icon: allcontact[widget.id].isFavorite
                        ? Icon(
                            Icons.favorite,
                            color: primaryColor,
                          )
                        : Icon(
                            Icons.favorite_border_outlined,
                            color: primaryColor,
                          )),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AddNewContact(allcontact[widget.id].id!)));
                    },
                    icon: Icon(
                      Icons.edit,
                      color: primaryColor,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
