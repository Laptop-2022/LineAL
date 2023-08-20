import 'package:flutter/material.dart';
import 'package:lineal/adjoint.dart';
import 'package:lineal/determinant.dart';
import 'package:lineal/inverse.dart';
import 'package:lineal/multiplication.dart';
import 'package:lineal/rref.dart';
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
        title: const Text("LineAL.",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                wordSpacing: 2.0)),
              centerTitle: true,
        backgroundColor: black,
      ),
      backgroundColor: black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('''What do you wanna do today ?''',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                      )),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OpsPage()),
                );
              },
              icon: const Icon(Icons.article_rounded,size: 35,),
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
      titleAlignment: ListTileTitleAlignment.center,
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
          style: TextStyle(fontWeight: FontWeight.bold,fontSize:30 ),
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

           listtile("Transpose of a matrix", Icons.swap_horiz, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const TransposeWs()));
          }),

          listtile('Determinant of a matrix', Icons.calculate, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DetWs()),
            );
          }),

          listtile('Adjoint of a matrix', Icons.format_indent_increase, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdjWs()),
            );
          }),

          listtile('Inverse of a matrix', Icons.swap_vert, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const InvWs()),
            );
          }),

          listtile('RREF of a matrix',Icons.linear_scale,(){Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>const RrEfWs()),
              );}),

          
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
                  child: Text(ans[r][c].toStringAsFixed(4),
                      style: const TextStyle(
                          color: Colors.black, fontStyle: FontStyle.italic)),
                ),
              ),
            ),
          ),
        )),
  );
}

Widget showNumber(num ans, String op) {
  return SingleChildScrollView(
      child: Text("The $op of the matrix is $ans",
          style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 35)));
}

num determinant(List<List<num>> m) {
  if (m.length == 1 && m[0].length == 1) {
    return m[0][0];
  }

  if (m.length == 2 && m[0].length == 2) {
    return (m[0][0] * m[1][1]) - (m[0][1] * m[1][0]);
  }

  num det = 0;
  int rows = m.length;
  int columns = m[0].length;
  int r = 0;

  for (int c = 0; c < columns; c++) {
    List<List<num>> sm = [];

    for (int i = 1; i < rows; i++) {
      List<num> v = [];

      for (int j = 0; j < columns; j++) {
        if (j == c) {
          continue;
        }
        v.add(m[i][j]);
      }
      sm.add(v);
    }
    if ((r + c) % 2 == 0) {
      det += m[r][c] * determinant(sm);
    } else {
      det -= m[r][c] * determinant(sm);
    }
  }
  return det;
}

List<List<num>> adjoint(List<List<num>> m) {
  List<List<num>> adj = [];
  adj = List.generate(
      m.length, (index) => List.generate(m.length, (indexx) => 0));

  for (int r = 0; r < m.length; r++) {
    for (int c = 0; c < m.length; c++) {
      List<List<num>> sm = [];

      for (int i = 0; i < m.length; i++) {
        if (i == r) {
          continue;
        }

        List<num> v = [];
        for (int j = 0; j < m.length; j++) {
          if (j == c) {
            continue;
          }

          v.add(m[i][j]);
        }
        sm.add(v);
      }

      adj[c][r] = ((r + c) % 2 == 0) ? determinant(sm) : -1 * determinant(sm);
    }
  }
  return adj;
}

List<List<num>> scalarmultiply(List<List<num>> m1, num k) {
  int rows = m1.length;
  int columns = m1[0].length;
  List<List<num>> ans =
      List.generate(rows, (i) => List.generate(columns, (j) => 0));
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < columns; j++) {
      ans[i][j] = m1[i][j] * k;
    }
  }
  return ans;
}
