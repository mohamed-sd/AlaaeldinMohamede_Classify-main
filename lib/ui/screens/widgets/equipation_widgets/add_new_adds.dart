import 'package:eClassify/ui/theme/theme.dart';
import 'package:eClassify/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
class AddNewAdds extends StatelessWidget {
  const AddNewAdds({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.only(top: 5, right: 10 , left: 10),
        padding: EdgeInsets.symmetric(vertical: 6 , horizontal: 10),
        decoration: BoxDecoration(
          color: context.color.mainGold,
          borderRadius: BorderRadius.circular(10)
        ),
        child:Row(
          children: [
            Expanded(child: Container(
              height: 30,
              alignment: Alignment.center,
              child: Text(' اضف إعلانك ' , style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),),
            )),
            Icon(Icons.add_circle_outline),
          ],
        ),
      ),
    );
  }
}
