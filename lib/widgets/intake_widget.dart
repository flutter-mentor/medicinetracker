import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:medicine_tracker/componenets/componenets.dart';
import 'package:medicine_tracker/const/const.dart';
import 'package:medicine_tracker/models/intake_model.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';

class IntakeWidget extends StatefulWidget {
  IntakeModel intake;
  int index;
  IntakeWidget({
    Key? key,
    required this.intake,
    required this.index,
  }) : super(key: key);

  @override
  State<IntakeWidget> createState() => _IntakeWidgetState();
}

class _IntakeWidgetState extends State<IntakeWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
              boxShadow: [
                // BoxShadow(
                //   color: Colors.grey.withOpacity(0.1),
                //   spreadRadius: 10,
                //   blurRadius: 10,
                //   offset: Offset(3, 3), // changes position of shadow
                // ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${intToString(widget.index)} intake',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Row(
                      children: [
                        MedCubit.get(context).intakes.length - 1 == widget.index
                            ? GestureDetector(
                                onTap: () {
                                  MedCubit.get(context).addIntakes(
                                      time: widget.intake.time,
                                      dose: widget.intake.dose);
                                },
                                child: Icon(
                                  Icons.add_circle_outline,
                                  size: 16,
                                  color: AppColors.primColor,
                                ),
                              )
                            : SizedBox(),
                        const SizedBox(
                          width: 10,
                        ),
                        widget.index > 0
                            ? GestureDetector(
                                onTap: () {
                                  MedCubit.get(context)
                                      .removeIntake(widget.index);
                                },
                                child: Icon(
                                  Icons.remove_circle_outline_sharp,
                                  size: 16,
                                  color: Colors.red,
                                ),
                              )
                            : SizedBox(),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Time',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    GestureDetector(
                      onTap: () {
                        _showDatePicker(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.2),
                            )),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.clock,
                              size: 16,
                              color: AppColors.primColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              DateFormat("h:mma")
                                  .format(widget.intake.time)
                                  .toString(),
                              style: Theme.of(context).textTheme.caption,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dose',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.2),
                          )),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.pills,
                            size: 16,
                            color: AppColors.primColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${widget.intake.dose} pills',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
        listener: (context, state) {});
  }

  void _showDatePicker(context) {
    // Platform.isIOS == false
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 500,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  mode: CupertinoDatePickerMode.time,
                  onDateTimeChanged: (val) {
                    setState(() {
                      widget.intake.time = val;
                    });
                  }),
            ),

            // Close the modal
            CupertinoButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        ),
      ),
    );
    // : androidTime(context);
    // : showTimePicker(
    //     context: context,
    //     initialTime: TimeOfDay.now(),
    //     onEntryModeChanged: (v) {
    //       print(v);
    //       // CairoCubit.get(context).chooseDateTime(v);
    //     });
  }
}
