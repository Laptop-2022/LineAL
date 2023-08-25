import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

class InvWs extends StatelessWidget {
  const InvWs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Stateless Page of the inverse page",
        home: Scaffold(
          appBar: AppBar(
            leading:
                const Icon(Icons.swap_vert, color: Colors.white),
            title: const Text(
              "Inverse of a matrix",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 30),
            ),
            backgroundColor: Colors.black,
            centerTitle: true
          ),
          backgroundColor: Colors.black,
          body: const Inv(),
        ));
  }
}

class Inv extends StatefulWidget {
  const Inv({Key? key}) : super(key: key);

  @override
  State<Inv> createState() => InvState();
}

class InvState extends State<Inv> {
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
                if (rows != columns) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "Adjoint of a matrix is defined only for square matrices i.e. No. of rows = No. of columns"),
                    dismissDirection: DismissDirection.down,
                  ));
                  return;
                } else if (rows == columns && rows >= 5) {
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
                  ans = inverse(m1);
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: const Text(
                "Find Inverse",
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
        if(ans.isEmpty && setmatrix == true)
          const Expanded(child:Text("The inverse of the matrix doesn't exist",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),)
      ],
    );
  }
}

List<List<num>> inverse(List<List<num>> m) {
  List<List<num>> inverseMatrix = [];

  num det = determinant(m);

  if (det == 0) {
    return inverseMatrix;
  }

  List<List<num>> adj = [];

  adj = adjoint(m);

  inverseMatrix = scalarmultiply(adj, (1 / det));

  return inverseMatrix;
}
