import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/cubit/cubit.dart';
import 'package:medicine_tracker/cubit/states.dart';
import 'package:medicine_tracker/widgets/adabtive_simple_dialogue.dart';

import '../../../const/const.dart';
import '../../../widgets/custom_text_filled.dart';
import '../../../widgets/primary_button.dart';

class PickMedName extends StatelessWidget {
  PickMedName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();

    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Create a reminder'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Give your treatment a name ',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextFilled(
                      label: 'Name',
                      readOnly: false,
                      isPasword: false,
                      height: 45,
                      controller: nameController,
                      validator: (v) {}),
                  const SizedBox(
                    height: 30,
                  ),
                  PrimaryButton(
                    text: 'Next',
                    width: double.infinity,
                    height: 45,
                    color: AppColors.primColor,
                    onPressed: () {
                      if (nameController.text.isNotEmpty) {
                        MedCubit.get(context).nestStep();
                        MedCubit.get(context).mediceneNAme =
                            nameController.text;
                        MedCubit.get(context).addIntakes(
                            time: MedCubit.get(context).intakeTime, dose: 1);
                      } else if (MedCubit.get(context)
                          .nameController
                          .text
                          .isEmpty) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AdabtiveSimpleDialogue(
                                  title: Text('Please add medicine name '));
                            });
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
