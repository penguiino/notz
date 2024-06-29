import 'package:flutter/material.dart';

import 'NotePage.dart';


class HomePage extends StatefulWidget {
  const HomePage({ super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        title: Column(
          children: const [
            SizedBox(
              width: 120,
              height: 0,
            ),
            Text(
              'hend',
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
      body:SingleChildScrollView(
        child: Container(
          height: 50,
          width: 250,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20)),
          child: ElevatedButton(
            onPressed:() {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => NotePage()));
            },
            child: Text('Reset password'),
          ),
        ),
      ),
    );
  }

}