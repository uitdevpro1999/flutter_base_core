import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}): super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () => context.go('/weather'), child: Text("Lets goooo"),
        ),
      ),
    );
  }
}