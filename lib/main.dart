import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:hive/hive.dart';
import 'package:hivedatabase/hoveclass/contect_classs.dart';
import 'package:path_provider/path_provider.dart';

import 'hoveclass/database_class.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Directory dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  Hive.registerAdapter(contectAdapter());
  Box box=await Hive.openBox("cont");

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HiveDataBase(),
  ));
}

class HiveDataBase extends StatefulWidget {
  const HiveDataBase({super.key});

  @override
  State<HiveDataBase> createState() => _HiveDataBaseState();
}

class _HiveDataBaseState extends State<HiveDataBase>{
  TextEditingController namecontroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();
  Box box = Hive.box("cont");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(itemCount: box.length,itemBuilder: (context, index) {
        return ListTile(title: Text("${box.getAt(index).name}"),trailing:Wrap(
          children: [
            IconButton(onPressed: () {
              FlutterPhoneDirectCaller.callNumber("+91${box.getAt(index).number}");
            }, icon: Icon(Icons.call)),
            IconButton(onPressed: () {

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(// elevation: 250,
                    title: Text(" add data in hive data base "),
                    content: SizedBox(
                      width: 250,
                      height: 200,
                      child: ListView(
                        children: [
                          TextField(
                            controller: namecontroller,
                            decoration: InputDecoration(hintText: " enter a name "),
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: numbercontroller,
                            decoration: InputDecoration(hintText: " enter a number "),
                          )
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(onPressed: () {
                        // contect data = contect(namecontroller.text, numbercontroller.text);
                        contect data = box.getAt(index);
                        print(box.getAt(index));
                        data.name = namecontroller.text;
                        data.number = numbercontroller.text;
                        // final box = boxes.getdata();

                        data.save().then((value) {
                          Navigator.pop(context);
                        });
                        setState(() {

                        });
                      }, child: Text("add"))
                    ],
                  );
                },
              );
            }, icon: Icon(Icons.edit)),
            IconButton(onPressed: () {
              contect data = box.getAt(index);
              // box.deleteAt(index);
              data.delete();
              setState(() {

              });
            }, icon: Icon(Icons.delete))
          ],
        ),subtitle: Text("${box.getAt(index).number}"),);
      },),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(" add data in hive data base "),
                content: SizedBox(
                  height: MediaQuery.of(context).size.height/8,
                  // width: MediaQuery.of(context).size.width/,

                  child: ListView(
                    children: [
                      TextField(
                        controller: namecontroller,
                        decoration: InputDecoration(hintText: " enter a name "),
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: numbercontroller,
                        decoration: InputDecoration(hintText: " enter a number "),
                      )
                    ],
                  ),
                ),
                actions: [
                  TextButton(onPressed: () {
                   contect data = contect(namecontroller.text, numbercontroller.text);

                   // final box = boxes.getdata();

                   box.add(data);
                   Navigator.pop(context);
                   print(box);

                   // print(box.values.length);
                   // print(box.getAt(2)!.name);
                   data.save();
                   setState(() {

                   });
                  }, child: Text("add"))
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
