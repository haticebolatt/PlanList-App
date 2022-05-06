import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  final String title;
  final bool isDone;
  final Function(bool?) toggleStatus;
  final void Function(DismissDirection) deleteTask;

  const Cards({
    Key? key,
    required this.title,
    required this.isDone,
    required this.toggleStatus,
    required this.deleteTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: deleteTask,
      key: UniqueKey(),
      background: Container(
        decoration: const BoxDecoration(
          color: Color(0xff571919),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),

        alignment: Alignment.center,

        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Card(
        color: isDone ? const Color(0xfff7e5cf) : Colors.white,
        elevation: isDone ? 5 : 2,
        shadowColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
                color: const Color(0xff571919),
                fontFamily: "Quicksand-Medium",
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decorationThickness: 3.00,
                decoration: isDone ? TextDecoration.lineThrough : null),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround, //çok önemli
            children: [
              Checkbox(
          side: MaterialStateBorderSide.resolveWith(
          (states) => const BorderSide(width: 2.5, color: Color(0xff571919)),),

        onChanged: toggleStatus,
                value: isDone,
                activeColor: const Color(0xff571919),
              ),
              const Icon(Icons.swap_horiz,color:  Color(0xff571919),size: 30,),
            ],
          ),
        ),
      ),
    );
  }
}
