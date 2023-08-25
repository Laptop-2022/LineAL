import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

class TraceWs extends StatelessWidget {
  const TraceWs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Stateless Page of the Trace page",
        home: Scaffold(
          appBar: AppBar(
              leading: const Icon(Icons.remove, color: Colors.white),
              title: const Text(
                "Trace of a matrix",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              backgroundColor: Colors.black,
              centerTitle: true),
          backgroundColor: Colors.black,
          body: const Trace(),
        ));
  }
}

class Trace extends StatefulWidget {
  const Trace({Key? key}) : super(key: key);

  @override
  State<Trace> createState() => TraceState();
}

class TraceState extends State<Trace> {
  TextEditingController rc = TextEditingController();
  TextEditingController cc = TextEditingController();
  int rows = 0;
  int columns = 0;
  List<List<num>> m1 = [];
  num ans = 0;
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
          padding: const EdgeInsets.fromLTRB(150, 15, 150, 15),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                rows = int.tryParse(rc.text) ?? 0;
                columns = int.tryParse(cc.text) ?? 0;
                if (rows == 0 || columns == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "The number of rows and columns should not be zero or empty"),
                    dismissDirection: DismissDirection.down,
                  ));
                  return;
                }
                if (rows >= 5 || columns >= 5) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "The number of rows and columns should be less than 5 for practical purposes"),
                    dismissDirection: DismissDirection.down,
                  ));
                  return;
                }
                if(rows != columns){
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "Trace is defined only for square matrices"),
                    dismissDirection: DismissDirection.down,
                  ));
                  return;
                }
                if ((rows == columns) && (rows < 5 && columns < 5) && (rows > 0 && columns > 0)) {
                  m1 = List.generate(
                      rows, (i) => List.generate(columns, (j) => 0));
                  setmatrix = true;
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
        if ((rows == columns) && (rows < 5 && columns < 5) && (rows > 0 && columns > 0))
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: build2DArray(rows, columns, m1),
          ),
        if (setmatrix == true && (rows == columns) && (rows < 5 && columns < 5) && (rows > 0 && columns > 0))
          Padding(
            padding: const EdgeInsets.fromLTRB(150, 0, 150, 5),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  ans = traceMatrix(m1);
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: const Text(
                "Calculate",
                style:
                    TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
              ),
            ),
          ),
        const SizedBox(
          width: 10,
        ),
        if (ans != 0&& (rows == columns) && (rows < 5 && columns < 5) && (rows > 0 && columns > 0))
          Expanded(
            child: showNumber(ans, "trace"),
          ),
      ],
    );
  }
}

num traceMatrix(List<List<num>> m1) {
  int rows = m1.length;
  int columns = m1[0].length;
  num ans = 0;
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < columns; j++) {
      if (i == j) {
        ans += m1[i][j];
      }
    }
  }
  return ans;
}
