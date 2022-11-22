import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/watchlist.dart';

Future<List<Watchlist>> fetchWatchlist() async {
  var url =
      Uri.parse('https://tugas-2-pbp-airel.herokuapp.com/mywatchlist/json');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object Watchlist
  List<Watchlist> listWatchlist = [];
  for (var d in data) {
    if (d != null) {
      listWatchlist.add(Watchlist.fromJson(d));
    }
  }

  return listWatchlist;
}
