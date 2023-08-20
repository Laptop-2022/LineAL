import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

class DetWs extends StatelessWidget {
  const DetWs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Stateless Page of the Determinant page",
        home: Scaffold(
          appBar: AppBar(
            leading: const Icon(Icons.calculate, color: Colors.white),
            title: const Text(
              "Determinant of a matrix",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 30),
            ),
            backgroundColor: Colors.black,
            centerTitle: true
          ),
          backgroundColor: Colors.black,
          body: const Det(),
        ));
  }
}

class Det extends StatefulWidget {
  const Det({Key? key}) : super(key: key);

  @override
  State<Det> createState() => DetState();
}

class DetState extends State<Det> {
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
                setmatrix = true;
                rows = int.tryParse(rc.text) ?? 0;
                columns = int.tryParse(cc.text) ?? 0;
                if (rows != columns) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "Determinant of a matrix is defined only for square matrices i.e. No. of rows = No. of columns"),
                    dismissDirection: DismissDirection.down,
                  ));
                  return;
                }
                else if(rows==columns && rows>5){
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
        if (rows > 0 && columns > 0 && rows == columns && rows<5)
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: build2DArray(rows, columns, m1),
          ),
        if (setmatrix == true && rows==columns)
          Padding(
            padding: const EdgeInsets.fromLTRB(150, 0, 150, 5),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  ans = determinant(m1);
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
          width: 20,
        ),
        if (ans != 0)
          Expanded(
            child: showNumber(ans, "determinant"),
          ),
      ],
    );
  }
}


