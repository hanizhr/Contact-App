import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data.dart';

class ContactProvider with ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService.instace;
  List<PersonInfo> allContacts = [];
  ContactProvider() {
    _initializeProvider();
  }

  Future<void> _initializeProvider() async {
    await loadContacts();
  }

  Future<void> loadContacts() async {
    allContacts = await _databaseService.contacts();
    notifyListeners();
  }

  void addToList(PersonInfo newPerson) async {
    await _databaseService.insertPerson(newPerson);
    await loadContacts();
    notifyListeners();
  }

  void removeFromList(PersonInfo person) async {
    await _databaseService.deleteContact(person.id!);
    await loadContacts();
    notifyListeners();
  }

  void addToFavorite(PersonInfo person) async {
    person.isFavorite = true;
    await _databaseService.updateContact(person);
    await loadContacts();
    notifyListeners();
  }

  void removeFromFavorite(PersonInfo person) async {
    person.isFavorite = false;
    await _databaseService.updateContact(person);
    await loadContacts();
    notifyListeners();
  }

  void removeAll() async {
    for (var contact in allContacts) {
      await _databaseService.deleteContact(contact.id!);
    }
    await loadContacts();
    notifyListeners();
  }
}

class FonstProvider with ChangeNotifier {
  String _font = 'Schib';

  String get font => _font;

  Future<void> loadFont() async {
    final app = await SharedPreferences.getInstance();
    _font = app.getString('font') ?? 'Schib';
    notifyListeners();
  }

  Future<void> setFont(String fontName) async {
    _font = fontName;
    final app = await SharedPreferences.getInstance();
    await app.setString('font', _font);
    notifyListeners();
  }
}

class ThemeProvider with ChangeNotifier {
  bool _dark = false;

  bool get dark => _dark;

  Future<void> loadTheme() async {
    final app = await SharedPreferences.getInstance();
    _dark = app.getBool('darkTheme') ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _dark = !_dark;
    final app = await SharedPreferences.getInstance();
    await app.setBool('darkTheme', _dark);
    notifyListeners();
  }
}
