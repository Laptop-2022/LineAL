import 'package:flutter/material.dart';
import 'package:lineal/multiplication.dart';
import 'package:lineal/scalarmultiplicationn.dart';
import 'package:lineal/subtract.dart';
import 'package:lineal/trace.dart';
import 'package:lineal/transpose.dart';
import 'add.dart';

var black = Colors.black;
var white = Colors.white;
void main() {
  runApp(const MaterialApp(home: Home()));
}

var icon = const IconButton(
  onPressed: null,
  icon: Icon(Icons.article_rounded),
  enableFeedback: true,
  color: Colors.white,
);

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LineAL",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
                wordSpacing: 2.0)),
        backgroundColor: black,
      ),
      backgroundColor: black,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('What do you wanna do today ?',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold)),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OpsPage()),
                );
              },
              icon: const Icon(Icons.article_rounded),
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}

Widget listtile(String op, IconData icon, VoidCallback tap) {
  return ListTile(
      leading: Icon(icon, color: const Color.fromARGB(255, 255, 255, 255)),
      title: Text(
        op,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      onTap: tap);
}

class OpsPage extends StatelessWidget {
  const OpsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Operations',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          listtile('Addition of two matrices', Icons.add, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddWs()));
          }),

          listtile('Subtraction of two matrices', Icons.remove, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SubWs()),
            );
          }),

          listtile(
              'Scalar Multiplication of a matrix', Icons.clear_all_outlined,
              () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const KMulWs()));
          }),

          listtile('Multiplication of two matrices', Icons.close, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MulWs()),
            );
          }),

          listtile("Trace of a matrix", Icons.timeline, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const TraceWs()));
          }),

          // listtile('Determinant of a matrix',Icons.calculate,
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) =>const Det()),
          //     );),

          listtile("Transpose of a matrix", Icons.swap_horiz, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>const TransposeWs())
            );
          })

          // listtile('Co-Factor matrix',Icons.content_copy,Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) =>const Co_factor),
          //     );),

          // listtile('Adjoint of a matrix',Icons.format_indent_increase,Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) =>const Adjoint()),
          //     );
          // ),

          // listtile('RREF of a matrix',Icons.linear_scale,Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) =>const RREF()),
          //     );),

          // listtile('Rank of a matrix',Icons.trending_up,Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) =>const Rank()),
          //     );
          // ),

          // listtile('Invertibility of a matrix',Icons.swap_vert,Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) =>const Invert()),
          //     );),

          // listtile('Linear Independence of given vectors',Icons.compare_arrows,Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) =>const LID()),
          //     );
          // ),

          // listtile('Basis of row space',Icons.view_carousel,Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) =>const RS()),
          //     );),

          // listtile('Basis of column space',Icons.view_carousel,Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) =>const CS()),
          //     );),

          // listtile('Basis fo null space',Icons.view_carousel,Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) =>const NS()),
          //     );
          // )
          // Add more operations with icons
        ],
      ),
    );
  }
}

Widget build2DArray(int rows, int columns, List<List<num>> array) {
  return SingleChildScrollView(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
      rows,
      (r) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          columns,
          (c) => Container(
            margin: const EdgeInsets.all(8),
            width: 50,
            height: 50,
            color: Colors.white,
            child: Center(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    label: Text("${r + 1},${c + 1}"),
                    filled: true,
                    fillColor: Colors.grey),
                onChanged: (value) {
                  array[r][c] = num.parse(value);
                },
              ),
            ),
          ),
        ),
      ),
    ),
  ));
}

Widget showMatrix(List<List<num>> ans) {
  int rows = ans.length;
  int columns = ans[0].length;
  return SingleChildScrollView(
    child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          rows,
          (r) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              columns,
              (c) => Container(
                margin: const EdgeInsets.all(8),
                width: 50,
                height: 50,
                color: Colors.grey,
                child: Center(
                  child: Text(ans[r][c].toString(),
                      style: const TextStyle(
                          color: Colors.black, fontStyle: FontStyle.italic)),
                ),
              ),
            ),
          ),
        )),
  );
}

Widget showNumber(num ans) {
  return SingleChildScrollView(
      child: Text("The trace of the matrix is $ans",
          style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 35)));
}
