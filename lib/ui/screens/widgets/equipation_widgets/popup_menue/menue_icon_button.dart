import 'package:eClassify/ui/screens/guide/detailes.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

class MenueIconButton extends StatelessWidget {
  const MenueIconButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: const Center(child: Icon(Icons.settings)),
        onTap: () {
          showPopover(
              context: context,
              bodyBuilder: (context) => const MenueItems(),
              direction: PopoverDirection.bottom,
              width: 200,
              height: 260,
              arrowHeight: 15,
              arrowWidth: 30,
              backgroundColor: Color.fromARGB(255, 239, 199, 79));
        },
      ),
    );
  }
}
