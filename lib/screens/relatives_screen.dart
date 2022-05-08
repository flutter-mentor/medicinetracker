import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';

class RelativesScreen extends StatelessWidget {
  const RelativesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Container(
            child: Column(
              children: [
                Text(
                  'Profile',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          );
        },
        listener: (context, state) {});
  }
}
