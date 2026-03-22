import 'dart:io';

class BankingSystem {
  double _accoutBalance = 0.0;

  BankingSystem(this._accoutBalance);

  void deposit() {
    print("Please enter the amount");
    String? strAmount = stdin.readLineSync();
    double amount = double.parse(strAmount!);

    if (amount <= 0) {
      print("Invalid amount");
      return;
    }

    _accoutBalance += amount;
    print("Amount deposit successfull");
  }

  void withdraw() {
    print("Please enter the amount");
    String? strAmount = stdin.readLineSync();
    double amount = double.parse(strAmount!);

    if (amount > _accoutBalance) {
      print("Insufficent amount");
      return;
    }

    _accoutBalance -= amount;

    print("$amount withdrawl successfull... remaining amount $_accoutBalance");
  }
}

void main() {
  BankingSystem bank = BankingSystem(5000.69);

  print("---------------Bank--------------");
  print("Please select any one of the options to proceed");

  print("1: Deposit Balance");
  print("2: withdraw Balance");
  print("3: Exit");

  String? choice = stdin.readLineSync();
  int idx = int.parse(choice!);

  switch (idx) {
    case 1:
      bank.deposit();
      break;
    case 2:
      bank.withdraw();
      break;
    default:
      exit(0);
  }
}
