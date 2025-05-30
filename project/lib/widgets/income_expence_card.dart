import 'package:flutter/material.dart';
import 'package:project/constant/colors.dart';
import 'package:project/constant/constants.dart';

class IncomeExpenceCard extends StatefulWidget {

  final String title;
  final double amount;
  final String imageUrl;
  final Color bgColor;

  const IncomeExpenceCard({super.key, required this.title, required this.amount, required this.imageUrl, required this.bgColor});

  @override
  State<IncomeExpenceCard> createState() => _IncomeExpenceCardState();
}

class _IncomeExpenceCardState extends State<IncomeExpenceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.width * 0.22,
      decoration: BoxDecoration(
        color: widget.bgColor,
        borderRadius: BorderRadius.circular(20)
      ),

      child: Padding(
        padding: const EdgeInsets.all(kDefalutPadding),
        child: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.065,
              width: MediaQuery.of(context).size.height * 0.12/2,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 245, 245, 245),
                borderRadius: BorderRadius.circular(20)
              ),

              child: Center(
                child: Image.asset(
                  widget.imageUrl,
                  width: 60,
                  height: 60,
                ),
              ),
              
            ),

            SizedBox(width: 10,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title,
                style: TextStyle(
                  color: kWhite,
                  fontSize: 17,
                  fontWeight: FontWeight.w500
                ),),

                Text("\$${widget.amount.toStringAsFixed(0)}",
                style: TextStyle(
                  color: kWhite,
                  fontSize: 23,
                  fontWeight: FontWeight.bold
                ),)
              ],
            )
        
          ],
        ),
      ),


    );
  }
}