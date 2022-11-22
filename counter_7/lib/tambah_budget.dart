import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../widgets/custom_drawer.dart';
import 'models/budgets.dart';
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
      title: 'Tambah Budget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyTambahBudgetPage(),
    );
  }
}

class MyTambahBudgetPage extends StatefulWidget {
  final String title = 'Tambah Budget';
  const MyTambahBudgetPage({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<MyTambahBudgetPage> createState() => MyTambahBudgetPageState();
}

class MyTambahBudgetPageState extends State<MyTambahBudgetPage> {
  final _formKey = GlobalKey<FormState>();
  String _judul = "";
  int? _nominal = 0;
  String? _jenis;
  final List<String> _listJenis = ['Pemasukan', 'Pengeluaran'];
  String _dateTime = "";
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // Menambahkan drawer menu
      drawer: const CustomDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height,
            child: Column(
              children: [
                Padding(
                  // Menggunakan padding 10 pixels
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Contoh: Keperluan kuliah",
                      labelText: "Judul",
                      // Menambahkan circular border
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),

                    // Update variabel judul saat diketik
                    onChanged: (String? value) {
                      setState(() {
                        _judul = value!;
                      });
                    },
                    // Update variabel judul saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _judul = value!;
                      });
                    },

                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Judul tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  // Menggunakan padding 10 pixels
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Contoh: 20000",
                      labelText: "Nominal",
                      // Menambahkan circular border
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),

                    // Update variabel nominal saat diketik
                    onChanged: (String? value) {
                      setState(() {
                        _nominal = int.tryParse(value!);
                      });
                    },
                    // Update variabel nominal saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _nominal = int.tryParse(value!);
                      });
                    },

                    // Validator sebagai validasi form
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Nominal tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                DropdownButton(
                  underline: const SizedBox(),
                  value: _jenis,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: _listJenis.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  hint: const Text('Pilih Jenis'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _jenis = newValue!;
                    });
                  },
                ),
                Padding(
                  // Menggunakan padding 10 pixels
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "Contoh: 2022-11-14",
                      labelText: "Tanggal",
                      // Menambahkan circular border
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),

                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2099),
                      ).then((value) {
                        if (value != null) {
                          setState(() {
                            _dateTime = DateFormat('yyyy-MM-dd').format(value);
                            dateController.text = _dateTime;
                          });
                        }
                      });
                    },

                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Tanggal tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                const Spacer(),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Menambah budget
                      if (_jenis != null) {
                        budgets.add(Budget(_judul, _nominal!, _jenis!, _dateTime));
                      }
                    }
                  },
                  child: const Text(
                    "Simpan",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
