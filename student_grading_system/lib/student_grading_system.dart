import 'dart:io';

var students = [];

void addStudent() {
  print("Enter the name of the Student");
  String studentName = stdin.readLineSync()!;

  print("Enter the marks of the student");
  int marks = int.parse(stdin.readLineSync()!);

  students.add({"name": studentName, "marks": marks});
  print("$studentName added successfully");
}

void calculateAverage() {
  if (students.isEmpty) {
    print("No students available");
    return;
  }

  double totalMarks = 0;

  for (int i = 0; i < students.length; i++) {
    totalMarks += students[i]["marks"];
  }

  double avg = totalMarks / students.length;
  print("The average is $avg");
}

void findHighestScore() {
  if (students.isEmpty) {
    print("No students available");
    return;
  }

  var topStudent = students[0];

  for (var std in students) {
    if (std["marks"] > topStudent["marks"]) {
      topStudent = std;
    }
  }

  print(
    "The highest scoring student is ${topStudent["name"]} with ${topStudent["marks"]}",
  );
}

void showStudentsGrade() {
  if (students.isEmpty) {
    print("No students available");
    return;
  }

  for (var std in students) {
    int marks = std["marks"];

    if (marks >= 70) {
      print("${std["name"]} Grade: A");
    } else if (marks >= 50) {
      print("${std["name"]} Grade: B");
    } else {
      print("${std["name"]} Grade: C");
    }
  }
}

void main() {
  print("------------------------ Student Grader ------------------------");

  while (true) {
    print("\nPlease select one of the options");
    print("1: Add student");
    print("2: Calculate average");
    print("3: Print Student Grade");
    print("4: Find Highest Score");
    print("5: Exit");

    print("Enter your choice:");
    int choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        addStudent();
        break;
      case 2:
        calculateAverage();
        break;
      case 3:
        showStudentsGrade();
        break;
      case 4:
        findHighestScore();
        break;
      case 5:
        exit(0);
    }
  }
}
