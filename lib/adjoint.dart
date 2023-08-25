import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

class AdjWs extends StatelessWidget {
  const AdjWs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Stateless Page of the adjoint page",
        home: Scaffold(
          appBar: AppBar(
            leading:
                const Icon(Icons.format_indent_increase, color: Colors.white),
            title: const Text(
              "Adjoint of a matrix",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 30),
            ),
            backgroundColor: Colors.black,
            centerTitle: true
          ),
          backgroundColor: Colors.black,
          body: const Adj(),
        ));
  }
}

class Adj extends StatefulWidget {
  const Adj({Key? key}) : super(key: key);

  @override
  State<Adj> createState() => AdjState();
}

class AdjState extends State<Adj> {
  TextEditingController rc = TextEditingController();
  TextEditingController cc = TextEditingController();
  int rows = 0;
  int columns = 0;
  List<List<num>> m1 = [];
  List<List<num>> ans = [];
  bool setmatrix = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: TextField(
                controller: rc,
                decoration: const InputDecoration(
                  labelText: "Rows",
                  filled: true,
                  fillColor: Colors.grey,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: cc,
                decoration: const InputDecoration(
                  labelText: "Columns",
                  filled: true,
                  fillColor: Colors.grey,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(150, 5, 150, 5),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                setmatrix = true;
                rows = int.tryParse(rc.text) ?? 0;
                columns = int.tryParse(cc.text) ?? 0;
                if (rows != columns) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "Adjoint of a matrix is defined only for square matrices i.e. No. of rows = No. of columns"),
                    dismissDirection: DismissDirection.down,
                  ));
                  return;
                } else if (rows == columns && rows >= 5 && columns >= 5) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "The number of rows and columns should be less than 5"),
                    dismissDirection: DismissDirection.down,
                  ));
                  return;
                }
                if (rows == columns) {
                  m1 = List.generate(
                      rows, (i) => List.generate(columns, (j) => 0));
                  ans = List.generate(
                      rows, (i) => List.generate(columns, (j) => 0));
                }
              });
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: const Text(
              "Set Matrix",
              style:
                  TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
            ),
          ),
        ),
        if (rows > 0 && columns > 0 && rows == columns && rows < 5)
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: build2DArray(rows, columns, m1),
          ),
        if (setmatrix == true && rows == columns && rows < 5)
          Padding(
            padding: const EdgeInsets.fromLTRB(150, 0, 150, 5),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  ans = adjoint(m1);
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: const Text(
                "Find Adjoint",
                style:
                    TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
              ),
            ),
          ),
        const SizedBox(
          width: 20,
        ),
        if (ans.isNotEmpty)
          Expanded(
            child: showMatrix(ans),
          ),
      ],
    );
  }
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
