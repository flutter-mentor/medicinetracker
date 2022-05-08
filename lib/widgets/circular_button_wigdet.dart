import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/cubit/cubit.dart';
import 'package:medicine_tracker/cubit/states.dart';

class CircularButtonWidget extends StatelessWidget {
  GestureTapCallback onTap;
  IconData icon;
  Color color;
  CircularButtonWidget({
    Key? key,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return GestureDetector(
            child: CircleAvatar(
              backgroundColor: color,
              child: Icon(
                icon,
                size: 20,
              ),
              foregroundColor: Colors.white,
            ),
            onTap: onTap,
          );
        },
        listener: (context, state) {});
  }
}
