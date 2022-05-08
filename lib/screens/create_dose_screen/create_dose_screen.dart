import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';

class CreateReminderScreen extends StatelessWidget {
  const CreateReminderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return MedCubit.get(context)
              .stepsScreens[MedCubit.get(context).currentPageViewIndex];
        },
        listener: (context, state) {});
  }
}
