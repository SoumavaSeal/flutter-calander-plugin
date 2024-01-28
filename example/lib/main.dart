import 'package:calander/calander.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage() 
    );
  }
}

class HomePage extends StatefulWidget {
  
  const HomePage({super.key});

    @override
    State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
    
    DateTime selDate = DateTime.now();
    int selYear = DateTime.now().year;

    @override
    Widget build(BuildContext context){
        return Scaffold(
           appBar: AppBar(
                title: const Text("Plugin Example"),
                actions: [
                    ElevatedButton(
                        onPressed: (){
                            setState(() {
                                selYear = selYear - 1;                            
                            });
                        },
                        child: const Text("Prev")
                    ),
                    const SizedBox(width: 20,),
                    ElevatedButton(
                        onPressed: (){
                            setState(() {
                                selYear = selYear + 1;                              
                            });
                        },
                        child: const Text("Next")
                    ),
                ], 
           ),
           body: Calander(
                focusedDate: selDate,
                year: selYear,
                onDaySelect: (DateTime date){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewPage(date: date,))
                    );
                },
            ),
        );
    }
}

class NewPage extends StatelessWidget{
    

  final DateTime date;    
  const NewPage({super.key, required this.date});

  
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            title: const Text("Plugin Example"),
            leading: IconButton(
                onPressed: (){Navigator.pop(context);}, 
                icon: const Icon(Icons.arrow_back)
            ),
        ),
        body: Center(
            child: Text(DateFormat('dd/MM/yyyy').format(date)),
        ),
    );
  }

}


