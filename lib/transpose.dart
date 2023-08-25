import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

class TransposeWs extends StatelessWidget {
  const TransposeWs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Stateless Page of the Transpose page",
        home: Scaffold(
          appBar: AppBar(
              leading: const Icon(Icons.swap_horiz, color: Colors.white),
              title: const Text(
                "Transpose",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              backgroundColor: Colors.black,
              centerTitle: true),
          backgroundColor: Colors.black,
          body: const Transpose(),
        ));
  }
}

class Transpose extends StatefulWidget {
  const Transpose({Key? key}) : super(key: key);

  @override
  State<Transpose> createState() => TransposeState();
}

class TransposeState extends State<Transpose> {
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
          padding: const EdgeInsets.fromLTRB(150, 15, 150, 15),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                setmatrix = true;
                rows = int.tryParse(rc.text) ?? 0;
                columns = int.tryParse(cc.text) ?? 0;
                if (rows >= 5 || columns >= 5) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "The number of rows and columns should be less than 5 for practical purposes"),
                    dismissDirection: DismissDirection.down,
                  ));
                  return;
                }
                if (rows < 5 && columns < 5) {
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
        if (rows > 0 && columns > 0 && rows < 5 && columns < 5)
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: build2DArray(rows, columns, m1),
          ),
        if (setmatrix == true && rows < 5 && columns < 5)
          Padding(
            padding: const EdgeInsets.fromLTRB(150, 0, 150, 5),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  ans = transpose(m1);
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: const Text(
                "Find Transpose",
                style:
                    TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
              ),
            ),
          ),
        if (ans.isNotEmpty)
          Expanded(
            child: showMatrix(ans),
          ),
      ],
    );
  }
}

List<List<num>> transpose(List<List<num>> m1) {
  int rows = m1.length;
  int columns = m1[0].length;
  List<List<num>> ans =
      List.generate(rows, (i) => List.generate(columns, (j) => 0));
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < columns; j++) {
      ans[i][j] = m1[j][i];
    }
  }
  return ans;
}
