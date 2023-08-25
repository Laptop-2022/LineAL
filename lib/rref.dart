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
                "RREF of a matrix",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              backgroundColor: Colors.black,
              centerTitle: true),
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
  int numRows = matrix.length;
  int numCols = matrix[0].length;

  for (int pivotRow = 0; pivotRow < numRows; pivotRow++) {
    // Find the pivot column for the current row
    int pivotCol = -1;
    for (int col = 0; col < numCols - 1; col++) {
      if (matrix[pivotRow][col] != 0) {
        pivotCol = col;
        break;
      }
    }

    if (pivotCol == -1) {
      // Skip if the pivot column is not found
      continue;
    }

    // Scale the pivot row so that the pivot element becomes 1
    num pivotValue = matrix[pivotRow][pivotCol];
    for (int col = 0; col < numCols; col++) {
      matrix[pivotRow][col] /= pivotValue;
    }

    // Eliminate other elements in the pivot column
    for (int row = 0; row < numRows; row++) {
      if (row != pivotRow) {
        num scale = matrix[row][pivotCol];
        for (int col = 0; col < numCols; col++) {
          matrix[row][col] -= scale * matrix[pivotRow][col];
        }
      }
    }
  }

  return matrix;
}
