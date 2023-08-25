import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

class MulWs extends StatelessWidget {
  const MulWs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Stateless Page of the Multiplication page",
        home: Scaffold(
          appBar: AppBar(
              leading: const Icon(Icons.close, color: Colors.white),
              title: const Text(
                "Multiplication",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              backgroundColor: Colors.black,
              centerTitle: true),
          backgroundColor: Colors.black,
          body: const Mul(),
        ));
  }
}

class Mul extends StatefulWidget {
  const Mul({Key? key}) : super(key: key);

  @override
  State<Mul> createState() => MulState();
}

class MulState extends State<Mul> {
  TextEditingController rc_1 = TextEditingController();
  TextEditingController cc_1 = TextEditingController();
  TextEditingController rc_2 = TextEditingController();
  TextEditingController cc_2 = TextEditingController();
  int rows_1 = 0;
  int columns_1 = 0;
  int rows_2 = 0;
  int columns_2 = 0;
  List<List<num>> m1 = [];
  List<List<num>> m2 = [];
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
                controller: rc_1,
                decoration: const InputDecoration(
                  labelText: "Rows-Matrix-1",
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
                controller: cc_1,
                decoration: const InputDecoration(
                  labelText: "Columns-Matrix-1",
                  filled: true,
                  fillColor: Colors.grey,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: TextField(
                controller: rc_2,
                decoration: const InputDecoration(
                  labelText: "Rows-Matrix-2",
                  filled: true,
                  fillColor: Colors.grey,
                ),
                keyboardType: TextInputType.number,
                // inputFormatters: [
                //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                // ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: cc_2,
                decoration: const InputDecoration(
                  labelText: "Columns-Matrix-2",
                  filled: true,
                  fillColor: Colors.grey,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(150, 15, 150, 15),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                rows_1 = int.tryParse(rc_1.text) ?? 0;
                columns_1 = int.tryParse(cc_1.text) ?? 0;
                rows_2 = int.tryParse(rc_2.text) ?? 0;
                columns_2 = int.tryParse(cc_2.text) ?? 0;
                if (rows_1 == 0 ||
                    rows_2 == 0 ||
                    columns_1 == 0 ||
                    columns_2 == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "The number of rows and columns should not be zero or empty"),
                    dismissDirection: DismissDirection.down,
                  ));
                  return;
                }
                if (rows_1 >= 5 ||
                    columns_1 >= 5 ||
                    rows_2 >= 5 ||
                    columns_2 >= 5) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "The number of rows and columns should be less than 5 for practical purposes"),
                    dismissDirection: DismissDirection.down,
                  ));
                  return;
                }
                if (columns_1 != rows_2) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "The number of columns in the first matrix should be equal to the number of rows in the second matrix"),
                    dismissDirection: DismissDirection.down,
                  ));
                  return;
                }
                if (columns_1 == rows_2 && rows_1 < 5 ||
                    columns_1 < 5 ||
                    rows_2 < 5 ||
                    columns_2 < 5 &&
                        (rows_1 > 0 &&
                            rows_2 > 0 &&
                            columns_2 > 0 &&
                            columns_1 > 0)) {
                  m1 = List.generate(
                      rows_1, (i) => List.generate(columns_1, (j) => 0));
                  m2 = List.generate(
                      rows_2, (i) => List.generate(columns_2, (j) => 0));
                  ans = List.generate(
                      rows_2, (i) => List.generate(columns_2, (j) => 0));
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
        if (rows_1 > 0 &&
            columns_1 > 0 &&
            columns_1 == rows_2 &&
            (rows_1 < 5 || columns_1 < 5 || rows_2 < 5 || columns_2 < 5) &&
            (rows_1 > 0 && rows_2 > 0 && columns_2 > 0 && columns_1 > 0) &&
            (columns_1 == rows_2))
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: build2DArray(rows_1, columns_1, m1),
          ),
        if (rows_2 > 0 &&
            columns_2 > 0 &&
            columns_1 == rows_2 &&
            (rows_1 < 5 || columns_1 < 5 || rows_2 < 5 || columns_2 < 5) &&
            (rows_1 > 0 && rows_2 > 0 && columns_2 > 0 && columns_1 > 0) &&
            (columns_1 == rows_2))
          Expanded(
            flex: 1,
            child: build2DArray(rows_2, columns_2, m2),
          ),
        if (setmatrix == true &&
            columns_1 == rows_2 &&
            (rows_1 < 5 || columns_1 < 5 || rows_2 < 5 || columns_2 < 5) &&
            (rows_1 > 0 && rows_2 > 0 && columns_2 > 0 && columns_1 > 0) &&
            (columns_1 == rows_2))
          Padding(
            padding: const EdgeInsets.fromLTRB(150, 0, 150, 5),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  ans = mul(m1, m2);
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: const Text(
                "Multiply",
                style:
                    TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
              ),
            ),
          ),
        if (ans.isNotEmpty &&
            (rows_1 > 0 && rows_2 > 0 && columns_2 > 0 && columns_1 > 0) &&
            (columns_1 == rows_2))
          Expanded(
            child: showMatrix(ans),
          ),
      ],
    );
  }
}

List<List<num>> mul(List<List<num>> m1, List<List<num>> m2) {
  int rows_1 = m1.length;
  int columns_1 = m1[0].length;
  int rows_2 = m2.length;
  int columns_2 = m2[0].length;
  List<List<num>> ans =
      List.generate(rows_1, (i) => List.generate(columns_2, (j) => 0));
  for (int i = 0; i < columns_1; i++) {
    for (int j = 0; j < rows_2; j++) {
      for (int k = 0; k < columns_1; k++) {
        ans[i][j] += m1[i][k] * m2[k][j];
      }
    }
  }
  return ans;
}
