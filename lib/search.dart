import 'package:flutter/material.dart';
import 'students.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // controller to store product pid
  final TextEditingController _controllerID = TextEditingController();
  String _text = '';

  @override
  void dispose() {
    _controllerID.dispose();
    super.dispose();
  }

  void update(String text) {
    setState(() {
      _text = text;
    });
  }

  void getStudents() {
    try {
      int pid = int.parse(_controllerID.text);
      searchStudents(update, pid);
    }
    catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Wrong Arguments!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        title: const Text('Information for Student', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.white10,
        centerTitle: true,
      ),
      body: Center(child: Column(
        children: [
        const SizedBox(height: 10,),
        SizedBox(
            width: 200,
            child: TextField(
                controller: _controllerID,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white) ,
            decoration: const InputDecoration(border: OutlineInputBorder(),
              hintText: 'Enter ID of Student',
              hintStyle: TextStyle(color: Colors.white),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white70),
              ),))),
        const SizedBox(height: 10),
        ElevatedButton(onPressed: getStudents,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow, // Set button background color
            ),
            child: const Text('Find', style: TextStyle(fontSize: 18,))),
        const SizedBox(height: 10),
        Center(child: SizedBox(width: 200, child: Flexible(child: Text(_text,
            style: const TextStyle(fontSize: 18, color: Colors.white))))),
      ],

      ),

      ),
    );
  }
}