import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Program Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Program Counter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      if (_counter < 0) {
        _counter = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_counter % 2 == 0) ...[
              const Text(
                'GENAP',
                style: TextStyle(color: Colors.red),
              ),
            ] else ...[
              const Text(
                'GANJIL',
                style: TextStyle(color: Colors.blue),
              ),
            ],
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        children: <Widget>[
          if(_counter > 0)
          Positioned(
            left: 20,
            bottom: 10,
            child: FloatingActionButton(
                onPressed: _decrementCounter,
                tooltip: 'Decrement',
                heroTag: 'Decrement',
                child: const Icon(Icons.remove),
              ),
          ),
          Positioned(
            right: 20,
            bottom: 10,
            child: FloatingActionButton(
                onPressed: _incrementCounter,
                tooltip: 'Increment',
                heroTag: 'Increment',
                child: const Icon(Icons.add),
              ),
          ),
        ],
      ),
    );
  }
}
