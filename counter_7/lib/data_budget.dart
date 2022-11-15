import '../widgets/custom_drawer.dart';
import '../widgets/budgets.dart';
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
      home: const MyDataBudgetPage(),
    );
  }
}

class MyDataBudgetPage extends StatefulWidget {
  const MyDataBudgetPage({super.key});
  final String title = 'Program Counter';

  @override
  // ignore: no_logic_in_create_state
  State<MyDataBudgetPage> createState() => _MyDataBudgetPageState();
}

class _MyDataBudgetPageState extends State<MyDataBudgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // Menambahkan drawer menu
      drawer: const CustomDrawer(),
      body: budgets.isEmpty
          ? const Center()
          : ListView.builder(
              itemCount: budgets.length,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          budgets[index].judul,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          budgets[index].dateTime,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          budgets[index].nominal.toString(),
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          budgets[index].jenis,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ]),
                ));
              },
            ),
    );
  }
}
