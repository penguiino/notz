import 'package:flutter/material.dart';


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
                'Contacts',
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
      body:SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Container(
              width: 390,
              height: 700,

            ),
          ),
        ),
      ),
    );
  }

}