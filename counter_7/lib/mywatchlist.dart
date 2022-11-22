import '../widgets/custom_drawer.dart';
import '../widgets/fetch_watchlist.dart';
import 'package:flutter/material.dart';
import 'package:counter_7/detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Watch List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyWatchlistPage(),
    );
  }
}

class MyWatchlistPage extends StatefulWidget {
  const MyWatchlistPage({super.key});
  final String title = 'My Watch List';

  @override
  State<MyWatchlistPage> createState() => _MyWatchlistPageState();
}

class _MyWatchlistPageState extends State<MyWatchlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        // Menambahkan drawer menu
        drawer: const CustomDrawer(),
        body: FutureBuilder(
            future: fetchWatchlist(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return Column(
                    children: const [
                      Text(
                        "Tidak ada watchlist.",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => InkWell(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow:
                                      (snapshot.data![index].fields.watched)
                                          ? const [
                                              BoxShadow(
                                                  color: Colors.green,
                                                  blurRadius: 2.0)
                                            ]
                                          : const [
                                              BoxShadow(
                                                  color: Colors.red,
                                                  blurRadius: 2.0)
                                            ]),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${snapshot.data![index].fields.title}",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    Checkbox(
                                      checkColor: Colors.white,
                                      value:
                                          snapshot.data![index].fields.watched,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          snapshot.data![index].fields.watched =
                                              value!;
                                        });
                                      },
                                    ),
                                  ]),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyDetailPage(
                                        data: snapshot.data![index])),
                              );
                            },
                          ));
                }
              }
            }));
  }
}
