import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

class KMulWs extends StatelessWidget {
  const KMulWs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Stateless Page of the scalar multiplication page",
        home: Scaffold(
          appBar: AppBar(
              leading: const Icon(Icons.remove, color: Colors.white),
              title: const Text(
                "Scalar multiplication",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              backgroundColor: Colors.black,
              centerTitle: true),
          backgroundColor: Colors.black,
          body: const KMul(),
        ));
  }
}

class KMul extends StatefulWidget {
  const KMul({Key? key}) : super(key: key);

  @override
  State<KMul> createState() => KMulState();
}

class KMulState extends State<KMul> {
  TextEditingController rc = TextEditingController();
  TextEditingController cc = TextEditingController();
  TextEditingController kc = TextEditingController();
  int rows = 0;
  int columns = 0;
  List<List<num>> m1 = [];
  List<List<num>> ans = [];
  num k = 0;
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
        Expanded(
          child: TextField(
            controller: kc,
            decoration: const InputDecoration(
              labelText: "Scalar - Default value is 0",
              filled: true,
              fillColor: Colors.grey,
            ),
            keyboardType: TextInputType.number,
            // inputFormatters: [
            //   FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
            // ],
          ),
        ),
        const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.fromLTRB(150, 15, 150, 15),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                rows = int.tryParse(rc.text) ?? 0;
                columns = int.tryParse(cc.text) ?? 0;
                k = num.tryParse(kc.text) ?? 0;
                if (rows == 0 || columns == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "The number of rows or columns or scalar can't be zero or empty"),
                    dismissDirection: DismissDirection.down,
                  ));
                  setmatrix = false;
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
                if (rows < 5 && columns < 5 && (rows > 0 && columns > 0)) {
                  m1 = List.generate(
                      rows, (i) => List.generate(columns, (j) => 0));
                  ans = List.generate(
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
        if (rows > 0 && columns > 0 && rows < 5 && columns < 5)
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: build2DArray(rows, columns, m1),
          ),
        if (setmatrix == true &&
            rows < 5 &&
            columns < 5 && rows > 0 && columns > 0)
          Padding(
            padding: const EdgeInsets.fromLTRB(150, 0, 150, 5),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  ans = scalarmultiply(m1, k);
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: const Text(
                "Scalar Multiply",
                style:
                    TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
              ),
            ),
          ),
        if (ans.isNotEmpty && setmatrix == true)
          Expanded(
            child: showMatrix(ans),
          ),
      ],
    );
  }
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
