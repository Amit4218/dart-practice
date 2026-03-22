import 'dart:convert';
import 'dart:io';
import "package:intl/intl.dart";

List<String> todoOptions = [
  "Add a todo",
  "List all todo",
  "delete a todo",
  "Exit the application",
];

const String fileName = "todo.json";

// Read the file
File todoFile = File(fileName);

Future<void> createFile() async {
  if (!await todoFile.exists()) {
    await todoFile.writeAsString("[]");
  } else {
    var content = await todoFile.readAsString();
    if (content.trim().isEmpty) {
      await todoFile.writeAsString("[]");
    }
  }
}

void addTodo() async {
  print("Enter a title for the todo");
  String? todoTitle = stdin.readLineSync();

  print("Enter a small description");
  String? todoDescription = stdin.readLineSync();

  String createdTime = DateFormat('EEEE d: H:mm').format(DateTime.now());

  Map<String, dynamic> newTodo = {
    "title": todoTitle,
    "description": todoDescription,
    "createdDate": createdTime,
  };

  var fileContent = await todoFile.readAsString();

  if (fileContent.trim().isEmpty) {
    fileContent = "[]";
  }

  List<dynamic> data = json.decode(fileContent);
  data.add(newTodo);
  await todoFile.writeAsString(json.encode(data));
}

void viewTodo() async {
  // Read all the content
  var filecontent = await todoFile.readAsString();
  List<dynamic> data = json.decode(filecontent);

  for (var t in data) {
    print("Title: ${t['title']}");
    print("Description: ${t['description']}");
    print("Created At: ${t['createdDate']}");
    print("");
  }
}

void deleteTodo() async {
  var filecontent = await todoFile.readAsString();
  List<dynamic> data = json.decode(filecontent);

  for (var i = 0; i < data.length; i++) {
    print("id: $i");
    print("Title: ${data[i]['title']}");
    print("Description: ${data[i]['description']}");
    print("Created At: ${data[i]['createdDate']}");
    print("");
  }

  print("Enter the id of the todo to delete");
  var choice = stdin.readLineSync();
  var idx = int.parse(choice!);

  if (idx > data.length) {
    print("Id not found!");
    exit(0);
  }

  data.removeAt(idx);
  print("todo deleted...");

  await todoFile.writeAsString(json.encode(data));
}

void main() async {
  print("Welcome to todo app");

  await createFile();

  // print todo todoOptions

  print("\nPlease select any one options\n");
  for (int i = 0; i < todoOptions.length; i++) {
    print("$i : ${todoOptions[i]}");
  }

  var choice = stdin.readLineSync();
  num idx = int.parse(choice!);

  if (idx > todoOptions.length) {
    print("Invalid option, Existing...");
    exit(0);
  }

  switch (idx) {
    case 0:
      addTodo();
      break;
    case 1:
      viewTodo();
      break;
    case 2:
      deleteTodo();
      break;
    default:
      exit(0);
  }
}
