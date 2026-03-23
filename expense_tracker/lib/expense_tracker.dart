import 'dart:convert';
import 'dart:io';

class ExpenseTracker {
  String? expenseTitle;
  DateTime date = DateTime.now();
  double? amount;
  List<dynamic> oldExpenses = [];
  File expenseFile = File("./expense.json");

  ExpenseTracker() {
    createFile();
    loadOldExpenses();
  }

  void addExpense() {
    print("Enter the name of the exppense");
    expenseTitle = stdin.readLineSync();

    print("Enter the amount");
    String? strAmount = stdin.readLineSync();
    amount = double.parse(strAmount!);

    saveToFile({
      "expenseTitle": expenseTitle,
      "amount": amount,
      "date": date.toString(),
    });

    print("Expense added successfully");
  }

  void filter() {
    print("Enter the expense title to filter");
    String? filter = stdin.readLineSync();

    for (var e in oldExpenses) {
      if (e["date"] == filter || e["expenseTitle"] == filter) {
        print("Match found!");
        print(
          "Expense: ${e["expenseTitle"]}\n Amount: ${e["amount"]}\n Date: ${e["date"]}",
        );
        return;
      }
    }

    print("No match found!");
  }

  void saveToFile(dynamic data) async {
    oldExpenses.add(data);
    await expenseFile.writeAsString(json.encode(oldExpenses));
  }

  void loadOldExpenses() async {
    String fileContent = await expenseFile.readAsString();
    dynamic data = json.decode(fileContent);

    for (var d in data) {
      oldExpenses.add(d);
    }
  }

  void showExpenses() async {
    for (var exp in oldExpenses) {
      print(
        "Expense: ${exp["expenseTitle"]}\n Amount: ${exp["amount"]}\n Date: ${exp["date"]}",
      );
    }
  }

  void createFile() async {
    if (!await expenseFile.exists()) {
      expenseFile.writeAsString("[]");
      return;
    }
  }
}

void main() {
  ExpenseTracker expTracker = ExpenseTracker();

  print("------------- Expense Tracker ----------------");

  print("Please select an option");
  print("1: Add expense");
  print("2: Show expense");
  print("3: filter expense");
  print("4: Exit");

  String? choice = stdin.readLineSync();

  switch (choice) {
    case "1":
      expTracker.addExpense();
      break;
    case "2":
      expTracker.showExpenses();
    case "3":
      expTracker.filter();
    default:
      exit(0);
  }
}
