import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

class RrEfWs extends StatelessWidget {
  const RrEfWs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Stateless Page of the scalar multiplication page",
        home: Scaffold(
          appBar: AppBar(
            leading: const Icon(Icons.linear_scale, color: Colors.white),
            title: const Text(
              "Scalar multiplication of a matrix",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 30),
            ),
            backgroundColor: Colors.black,
            centerTitle: true
          ),
          backgroundColor: Colors.black,
          body: const RrEf(),
        ));
  }
}

class RrEf extends StatefulWidget {
  const RrEf({Key? key}) : super(key: key);

  @override
  State<RrEf> createState() => RrEfState();
}

class RrEfState extends State<RrEf> {
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
                m1 = List.generate(
                    rows, (i) => List.generate(columns, (j) => 0));
                ans = List.generate(
                    rows, (i) => List.generate(columns, (j) => 0));
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
        if (rows > 0 && columns > 0)
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: build2DArray(rows, columns, m1),
          ),
        if (setmatrix == true)
          Padding(
            padding: const EdgeInsets.fromLTRB(150, 0, 150, 5),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  ans = rref(m1);
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: const Text(
                "Find RREF",
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

List<List<num>> rref(List<List<num>> matrix) {
  int r = matrix.length; // Number of rows
  int c = matrix[0].length; // Number of columns

  int h = 0; // Pivot row index
  int k = 0; // Pivot column index
  List<List<num>> m = matrix;
  while (h < r && k < c) {
    // Find the index of the maximum absolute value in the k-th column
    int imax = h;
    for (int i = h + 1; i < r; i++) {
      if (m[i][k].abs() > m[imax][k].abs()) {
        imax = i;
      }
    }

    if (m[imax][k] == 0) {
      // No pivot in this column, move to the next column
      k++;
    } else {
      // Swap the rows to make the pivot non-zero
      List<num> temp = m[h];
      m[h] = m[imax];
      m[imax] = temp;

      // Perform row operations to make elements below the pivot column zero
      for (int i = h + 1; i < r; i++) {
        double f = m[i][k] / m[h][k];
        m[i][k] = 0; // Lower part of pivot column
        for (int j = k + 1; j < c; j++) {
          m[i][j] -= m[h][j] * f; // Update remaining elements in the row
        }
      }

      // Move to the next pivot row and column
      h++;
      k++;
    }
  }
  return m;
}
