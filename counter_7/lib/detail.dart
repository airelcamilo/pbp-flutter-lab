import 'package:intl/intl.dart';

import '../widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:counter_7/mywatchlist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final data;
  const MyApp({super.key, this.data});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detail',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyDetailPage(data: data),
    );
  }
}

class MyDetailPage extends StatefulWidget {
  final data;
  const MyDetailPage({super.key, required this.data});
  final String title = 'Detail';

  @override
  State<MyDetailPage> createState() => _MyDetailPageState();
}

class _MyDetailPageState extends State<MyDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        // Menambahkan drawer menu
        drawer: const CustomDrawer(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            tooltip: 'Back',
            heroTag: 'Back',
            label: const Text("Back"),
            onPressed: () => Navigator.pop(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyWatchlistPage()))),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text('${widget.data.fields.title}',
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                )),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text.rich(
                  TextSpan(
                    text: 'Release Date: ',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                    children: <TextSpan>[
                      TextSpan(
                          text: DateFormat('MMM d, y')
                              .format(widget.data.fields.releaseDate),
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 18)),
                    ],
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text.rich(
                  TextSpan(
                    text: 'Rating: ',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                    children: <TextSpan>[
                      TextSpan(
                          text: '${widget.data.fields.rating}/5',
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 18)),
                    ],
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text.rich(
                  TextSpan(
                    text: 'Status: ',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                    children: <TextSpan>[
                      if (widget.data.fields.watched) ...[
                        const TextSpan(
                            text: 'Watched',
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 18)),
                      ] else ...[
                        const TextSpan(
                            text: 'Haven\'t Watched',
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 18)),
                      ]
                    ],
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text.rich(
                  TextSpan(
                    text: 'Review:\n',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                    children: <TextSpan>[
                      TextSpan(
                          text: '${widget.data.fields.review}',
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 18)),
                    ],
                  ),
                )),
          ],
        ));
  }
}
