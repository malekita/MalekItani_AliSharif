import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String _baseURL = 'malekitanialisharif.atwebpages.com';

class Students {
  final int _pid;
  final String _name;
  final int _grades;
  final String _major;
  final double _gpa;

  Students(this._pid, this._name, this._grades, this._major, this._gpa);

  @override
  String toString() {
    return 'ID: $_pid\n Name: $_name\nGrades: $_grades \nMajor: $_major\nGPA: $_gpa';
  }


}
List<Students> _students = [];
void updateStudents(Function(bool success) update) async {
  try {
    final url = Uri.http(_baseURL, 'getStudents.php');
    final response = await http.get(url).timeout(const Duration(seconds: 5));
    _students.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        Students student = Students(
            int.parse(row['pid']),
            row['name'],
            int.parse(row['grades']),
            row['major'],
            double.parse(row['gpa']));
        _students.add(student);
      }
      update(true);
    }
  }
  catch(e) {
    update(false);
  }
}
void searchStudents(Function(String text) update, int pid) async {
  try {
    final url = Uri.http(_baseURL, 'searchStudents.php', {'pid':'$pid'});
    final response = await http.get(url)
        .timeout(const Duration(seconds: 5));
    _students.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      var row = jsonResponse[0];
      Students student = Students(
          int.parse(row['pid']),
          row['name'],
          int.parse(row['grades']),
          row['major'],
          double.parse(row['gpa']));
      _students.add(student);
      update(student.toString());
    }
  }
  catch(e) {
    update("Student not found");
  }
}

class ShowStudents extends StatelessWidget {
  const ShowStudents({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: _students.length,
        itemBuilder: (context, index) => Column(
            children: [
          const SizedBox(height: 10),
          Container(
              color: Colors.amber,
              padding: const EdgeInsets.all(5),
              width: width * 0.9, child: Row(children: [
            SizedBox(width: width * 0.15),
            Flexible(
                child: Text(_students[index].toString(),
                style: TextStyle(fontSize: width * 0.045)))
          ]))
        ])
    );
  }
}