# Tugas 7 Assignment PBP

##  *Stateless Widget* dan *Stateful Widget* Beserta Perbedaan
*Stateless widget* adalah widget yang tidak dapat diubah atau *immutable* sehingga properti dan penampilan tetap. Contohnya adalah widget `Text()` dan `Icon()`.

*Stateful widget* adalah widget yang dapat diubah atau *mutable* sehingga properti dapat berubah saat runtime. Perubahan terjadi ketika app merespons event yg dipicu interaksi user. Contohnya adalah widget `Checkbox()`, `Radio()`, dan `Slider()`.

Perbedaan *Stateless Widget* dan *Stateful Widget*:
| *Stateless Widget* | *Stateful Widget* |
| --- | --- |
| Widget statik | Widget dinamik |
| Tidak berubah ketika user interaksi | Dapat berubah ketika user berinteraksi |
| Hanya di-*render* sekali dan berubah hanya ketika data eksternal berubah juga | Dapat di-*render* berulang kali apabila data yang dimasukkan berubah atau *state* widget berubah |

***

## Widget yang Digunakan

| Widget | Deskripsi |
| --- | --- |
| `Stack()` | Widget yang memposisikan `children` relatif terhadap tepian kotak. |
| `Positioned()` | Widget yang mengatur posisi `child` di `Stack()`. |
| `FloatingActionButton()` | Widget berupa tombol sirkular di atas konten. |
| `Icon()` | Widget berupa ikon yang dijelaskan di `IconData`. |
| `Center()` | Widget yang meletakkan `child` di tengah. |
| `Column()` | Widget yang menampilkan `children` di array vertikal. |
| `Text()` | Widget yang menampilkan teks dengan `style` tertentu. |

***

## Fungsi dari `setState()`

Fungsi setState() memberi notifikasi ke *framework* ketika *state* objek tersebut berubah dan menyebabkan *user interface* harus diperbarui. *Framework* akan membangun kembali objek dengan *state* baru tersebut. Variabel yang berdampak pada `setState()` adalah variabel di fungsi yang di-*pass* sebagai argumen setState(). 

***

## Perbedaan `const` dan `final`

| `const` | `final` |
| --- | --- |
| Diinisiasi saat *compile time* dan sudah ditetapkan saat *runtime* sehingga tidak dapat diubah | Diinisiasi saat *runtime* dan dapat ditetapkan sekali |
| Dapat ditentukan dalam *class* dan fungsi | Dapat ditentukan dalam fungsi saja |
| Jika *state* di-*update*, variabel akan diinisiasi lagi | Jika *state* di-*update*, variabel tidak diinisiasi | 
| Digunakan jika *value* tidak diubah saat kode dijalankan | Digunakan jika *value* tidak diketahui satt *compile time* | 

***

## Implementasi

1. Membuat program Flutter baru dengan menjalankan kode ```flutter create counter_7``` di command line.

2. Mengubah tampilan

    Mengubah `title` di widget `MaterialApp()` dan `MyHomePage()` menjadi 
    "Program Counter".

    ```shell
    Widget build(BuildContext context) {
        return MaterialApp(
        title: 'Program Counter',
        theme: ThemeData(
            primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Program Counter'),
        );
    }
    ```

     Mengatur lokasi dari *floating action button* ke tengah di properti `floatingActionButtonLocation`.
    
    ```shell
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ```

    Di properti `floatingActionButton`, menambahkan widget `Stack()` agar app dapat menggunakan lebih dari satu widget `FloatingActionButton()`. Kemudian, masukkan list widget di properti `child` `Stack()` yang berisi widget `Positioned()` untuk mengatur posisi dari tombol - di layar, yaitu 20dp dari kiri dan 10 dp dari bawah. Kemudian, `child` dari widget tersebut adalah `FloatingActionButton()`. Isi propertinya adalah `child` berupa ikon -, `heroTag` serta `tooltip` sebuah string "Decrement", dan akan menjalankan fungsi `_decrementCounter` saat di klik.

    Dalam list widget di properti `child` `Stack()` tambahkan lagi widget `Positioned()` untuk mengatur posisi dari tombol + di layar, yaitu 20dp dari kanan dan 10 dp dari bawah. Selanjutnya, `child` dari widget tersebut adalah `FloatingActionButton()`. Isi propertinya adalah `child` berupa ikon +, `heroTag` serta `tooltip` sebuah string "Increment", dan akan menjalankan fungsi `_incrementCounter` saat di klik.

    ```shell
    floatingActionButton: Stack(
        children: <Widget>[
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
    ```

3. Implementasi logika
    * Untuk tombol + akan menjalankan fungsi `_incrementCounter` yang akan *increment* variabel `_counter` dan menampilkannya.

        ```shell
        void _incrementCounter() {
            setState(() {
            _counter++;
            });
        }
        ```

    * Untuk tombol - akan menjalankan fungsi `_decrementCounter` yang akan *decrement* variabel `_counter` dan menampilkannya sampai bernilai 0. Apabila lebih dari nilai 0, tidak memiliki efek apapun pada `_counter`.

        ```shell
        void _decrementCounter() {
        setState(() {
            _counter--;
            if (_counter < 0) {
                _counter = 0;
            }
            });
        }
        ```

    * Untuk menampilkan counter yang berubah apabila bernilai ganjil dan genap, di `children` widget `Column()` dari body app, tambahkan sebuah *if statement*. *If statement* tersebut memiliki kondisi `_counter % 2 == 0` sehingga akan memilih widget `Text()` bertulisan "GENAP" yang berwarna merah apabila `_counter` genap dan memilih widget `Text()` bertulisan "GANJIL" yang berwarna biru apabila `_counter` ganjil.

        ```shell
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
        ```

***

## Bonus
Untuk menghilangkan tombol - apabila counter bernilai 0, tambahkan *if statement* pada widget tombol tersebut. Apabila `_counter` lebih dari 0, maka tampilkan widget `Positioned()` tombol - dan jika kurang dari 0 dihilangkan.

```shell
...
if(_counter > 0)
    Positioned(
        left: 20,
        bottom: 10,
        child: FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            heroTag: null,
            child: const Icon(Icons.remove),
            ),
        ),
...
```

***

## Credits

Sumber jawaban nomor 1 adalah [Difference Between Stateless and Stateful Widget in Flutter](https://www.geeksforgeeks.org/difference-between-stateless-and-stateful-widget-in-flutter/?ref=rp)

Sumber jawaban nomor 2 adalah [material library](https://api.flutter.dev/flutter/material/material-library.html)

Sumber jawaban nomor 3 adalah [setState() method](https://api.flutter.dev/flutter/widgets/State/setState.html)

Sumber jawaban nomor 4 adalah [Difference between Const and Final in Dart](https://itnext.io/difference-between-const-and-final-in-dart-78c129d0c573)