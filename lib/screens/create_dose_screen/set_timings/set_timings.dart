import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_tracker/const/const.dart';
import 'package:medicine_tracker/helpers/notification_api.dart';
import 'package:medicine_tracker/widgets/intake_widget.dart';

import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../widgets/primary_button.dart';

class SetTimings extends StatelessWidget {
  const SetTimings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Create reminder'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.medication,
                          color: AppColors.primColor,
                        ),
                        Text(
                          MedCubit.get(context).mediceneNAme,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Spacer(),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Edit',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: AppColors.primColor),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.all(10),
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (context, index) {
                        return IntakeWidget(
                          index: index,
                          intake: MedCubit.get(context).intakes[index],
                        );
                      },
                      itemCount: MedCubit.get(context).intakes.length,
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.all(10),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: Colors.white,
                  //       border: Border.all(
                  //         color: Colors.grey.withOpacity(0.3),
                  //       )),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Icon(
                  //         FontAwesomeIcons.clock,
                  //         color: AppColors.primColor,
                  //         size: 20,
                  //       ),
                  //       const SizedBox(
                  //         width: 5,
                  //       ),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             'Schedule',
                  //             style: Theme.of(context).textTheme.subtitle1,
                  //           ),
                  //           Text(
                  //             'Here you can set reminders for medicine',
                  //             style: Theme.of(context).textTheme.caption,
                  //           ),
                  //           const SizedBox(
                  //             height: 10,
                  //           ),
                  //           Row(
                  //             children: [
                  //               Text('Frequency'),
                  //               SizedBox(
                  //                 width:
                  //                     MediaQuery.of(context).size.width / 2.2,
                  //               ),
                  //               GestureDetector(
                  //                 child: Text(
                  //                   MedCubit.get(context).freq + ' Daily',
                  //                   style: Theme.of(context)
                  //                       .textTheme
                  //                       .caption!
                  //                       .copyWith(color: AppColors.primColor),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     color: Colors.white,
                  //     border: Border.all(
                  //       color: Colors.grey.withOpacity(0.3),
                  //     ),
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       Container(
                  //         padding: EdgeInsets.all(10),
                  //         child: Row(
                  //           children: [
                  //             Text(
                  //               'Time',
                  //               style: Theme.of(context).textTheme.subtitle1,
                  //             ),
                  //             Spacer(),
                  //             GestureDetector(
                  //               onTap: () {
                  //                 _showDatePicker(context);
                  //               },
                  //               child: Text(
                  //                 DateFormat("h:mma")
                  //                     .format(
                  //                         MedCubit.get(context).firstDoseTime)
                  //                     .toString(),
                  //                 style: Theme.of(context)
                  //                     .textTheme
                  //                     .caption!
                  //                     .copyWith(color: AppColors.primColor),
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //       const SizedBox(
                  //         height: 5,
                  //       ),
                  //       Container(
                  //         padding: EdgeInsets.all(10),
                  //         child: Row(
                  //           children: [
                  //             Text(
                  //               'Dose',
                  //               style: Theme.of(context).textTheme.subtitle1,
                  //             ),
                  //             Spacer(),
                  //             GestureDetector(
                  //               onTap: () {},
                  //               child: Text(
                  //                 '${MedCubit.get(context).firstDose}',
                  //                 style: Theme.of(context)
                  //                     .textTheme
                  //                     .caption!
                  //                     .copyWith(color: AppColors.primColor),
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (state is AddReminderLoading)
                    LottieBuilder.asset(
                      'assets/loading.json',
                      width: 50,
                    ),
                  if (state is! AddReminderLoading)
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              MedCubit.get(context).previousStep();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: AppColors.primColor,
                                  )),
                              child: Text(
                                'Previous',
                                style: TextStyle(color: AppColors.primColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: PrimaryButton(
                              text: 'Save',
                              width: double.infinity,
                              height: 45,
                              color: AppColors.primColor,
                              onPressed: () {
                                MedCubit.get(context).saveReminder(
                                  medName: 'panadol',
                                  interval: 3,
                                );
                              }),
                        ),
                      ],
                    )
                ],
              ),
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
                    MedCubit.get(context).chooseDateTime(val);
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
