// ignore: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contactprovider.dart';
import 'data.dart';
import 'theme.dart';

class AddNewContact extends StatelessWidget {
  final int? id;
  const AddNewContact(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    var allcontact = context.watch<ContactProvider>().allContacts;

    final PersonInfo? existingContact = id != null
        ? allcontact.firstWhere((contact) => contact.id == id,
            orElse: () => PersonInfo(
                  id: null,
                  email: '',
                  numb: {'phone': '', 'home': ''},
                  name: '',
                  isFavorite: false,
                  imageUrl: '',
                ))
        : null;

    final TextEditingController emailController =
        TextEditingController(text: existingContact?.email ?? '');
    final TextEditingController nameController =
        TextEditingController(text: existingContact?.name ?? '');
    final TextEditingController phoneController =
        TextEditingController(text: existingContact?.numb['phone'] ?? '');
    final TextEditingController homeController =
        TextEditingController(text: existingContact?.numb['home'] ?? '');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(
          child: Text(
            'Add new contact',
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              style: TextStyle(color: primaryColor),
              decoration: InputDecoration(
                filled: true,
                fillColor: secendery,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                hintText: "Name",
                prefixIcon: Icon(
                  Icons.person,
                  color: primaryColor,
                ),
                prefixIconColor: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: primaryColor),
              decoration: InputDecoration(
                filled: true,
                fillColor: secendery,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                hintText: "Email",
                prefixIcon: Icon(
                  Icons.email,
                  color: primaryColor,
                ),
                prefixIconColor: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              style: TextStyle(color: primaryColor),
              decoration: InputDecoration(
                filled: true,
                fillColor: secendery,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                hintText: "phone number",
                prefixIcon: Icon(
                  Icons.call,
                  color: primaryColor,
                ),
                prefixIconColor: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: homeController,
              keyboardType: TextInputType.phone,
              style: TextStyle(color: primaryColor),
              decoration: InputDecoration(
                filled: true,
                fillColor: secendery,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                hintText: "home number",
                prefixIcon: Icon(
                  Icons.home,
                  color: primaryColor,
                ),
                prefixIconColor: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(secendery),
                ),
                onPressed: () {
                  context.read<ContactProvider>().addToList(PersonInfo(
                      id: (id != null) ? id : null,
                      email: emailController.text,
                      numb: {
                        'phone': phoneController.text,
                        'home': homeController.text,
                      },
                      name: nameController.text,
                      isFavorite: false,
                      imageUrl: 'images/harry.jpeg'));

                  Navigator.pop(
                    context,
                  );
                },
                child: id == null
                    ? const Icon(Icons.add)
                    : const Icon(Icons.check)),
          ],
        ),
      ),
    );
  }
}
