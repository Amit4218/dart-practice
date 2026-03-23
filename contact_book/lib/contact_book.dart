import 'dart:convert';
import 'dart:io';

class ContactBook {
  final File contactFile = File("contacts.json");

  ContactBook() {
    init();
  }

  Future<void> init() async {
    if (!await contactFile.exists()) {
      await contactFile.create();
      await contactFile.writeAsString("[]"); // initialize empty list
    }
  }

  Future<List<dynamic>> _readContacts() async {
    String content = await contactFile.readAsString();
    return json.decode(content);
  }

  Future<void> _writeContacts(List<dynamic> contacts) async {
    await contactFile.writeAsString(json.encode(contacts));
  }

  Future<void> addContact() async {
    print("Enter the contact name:");
    String? name = stdin.readLineSync();

    print("Enter phone number:");
    String? number = stdin.readLineSync();

    if (name == null || number == null || name.isEmpty || number.isEmpty) {
      print("Invalid input!");
      return;
    }

    List contacts = await _readContacts();

    contacts.add({"name": name, "phoneNumber": number});

    await _writeContacts(contacts);

    print("Contact added!");
  }

  Future<void> searchContact() async {
    List contacts = await _readContacts();

    print("Enter the name to search:");
    String? filter = stdin.readLineSync();

    if (filter == null || filter.isEmpty) {
      print("Invalid input!");
      return;
    }

    bool found = false;

    for (var c in contacts) {
      if (c["name"].toLowerCase() == filter.toLowerCase()) {
        print("\nContact found:");
        print("Name: ${c["name"]}");
        print("Number: ${c["phoneNumber"]}");
        found = true;
      }
    }

    if (!found) {
      print("No contact found");
    }
  }

  Future<void> deleteContact() async {
    List contacts = await _readContacts();

    if (contacts.isEmpty) {
      print("No contacts to delete.");
      return;
    }

    print("\nContact List:");
    for (int i = 0; i < contacts.length; i++) {
      print(
        "[$i] Name: ${contacts[i]["name"]}, Number: ${contacts[i]["phoneNumber"]}",
      );
    }

    print("Enter the index to delete:");
    String? input = stdin.readLineSync();

    if (input == null) return;

    int? index = int.tryParse(input);

    if (index == null || index < 0 || index >= contacts.length) {
      print("Invalid index!");
      return;
    }

    contacts.removeAt(index);

    await _writeContacts(contacts);

    print("Contact deleted!");
  }

  Future<void> showAllContacts() async {
    List contacts = await _readContacts();

    if (contacts.isEmpty) {
      print("No contacts found.");
      return;
    }

    print("\nAll Contacts:");
    for (var c in contacts) {
      print("Name: ${c["name"]}, Number: ${c["phoneNumber"]}");
    }
  }
}

Future<void> main() async {
  ContactBook ctBk = ContactBook();

  // wait for initialization
  await Future.delayed(Duration(milliseconds: 200));

  while (true) {
    print("\n====== Contact Book ======");
    print("1: Add contact");
    print("2: Search contact");
    print("3: Delete contact");
    print("4: Show all contacts");
    print("5: Exit");

    String? choice = stdin.readLineSync();

    switch (choice) {
      case "1":
        await ctBk.addContact();
        break;
      case "2":
        await ctBk.searchContact();
        break;
      case "3":
        await ctBk.deleteContact();
        break;
      case "4":
        await ctBk.showAllContacts();
        break;
      case "5":
        print("Goodbye!");
        exit(0);
      default:
        print("Invalid option!");
    }
  }
}
