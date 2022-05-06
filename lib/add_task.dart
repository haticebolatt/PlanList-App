import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planlistapp/data_task.dart';
import 'package:provider/provider.dart';

class AdderTask extends StatelessWidget {
  final textCheck = TextEditingController();

  AdderTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffeee9e9),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(

                expands: false,
                minLines: 1,
                maxLines: 3,
                controller: textCheck,
                onChanged: (input) {
                  print(textCheck.text);
                },
                style: const TextStyle(color: Color(0xff571919), fontSize: 17,  fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder( borderSide: BorderSide(color:Color(0xff571919), width: 2.5),),
                  hintText: ('Yeni Plan Nedir?'),
                ),
                autofocus: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: const Color(0xff571919), // Background Color
                ),
                onPressed: () {
                  Provider.of<DataTask>(context, listen: false)
                      .adderTask(textCheck.text);
                  Navigator.pop(context);
                },
                child: const Text(
                  'EKLE',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
