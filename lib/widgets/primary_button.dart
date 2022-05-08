import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  String text;
  double height;
  double width;
  IconData? icon;
  Color? color;
  GestureTapCallback? onPressed;
  PrimaryButton({
    Key? key,
    required this.text,
    this.color,
    this.icon,
    required this.width,
    required this.height,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          width: width,
          height: height,
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              // const SizedBox(
              //   width: 10,
              // ),
              Text(
                text,
                style: Theme.of(context).textTheme.button,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ),
    );
    // return InkWell(
    //   onTap: onPressed,
    //   splashColor: Colors.red,
    //   child: Container(
    //     height: height,
    //     alignment: Alignment.center,
    //     width: width,
    //     color: Colors.black,
    //     child: Text(
    //       text,
    //       style: Theme.of(context).textTheme.button,
    //     ),
    //   ),
    // );
  }
}
