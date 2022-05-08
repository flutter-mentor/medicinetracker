import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_tracker/const/const.dart';
import 'package:medicine_tracker/helpers/notification_api.dart';
import 'package:medicine_tracker/widgets/primary_button.dart';

import '../../../componenets/componenets.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../create_dose_screen.dart';
import '../../notifct_opened_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<int> intrvls = [
    1,
    2,
    3,
  ];
  @override
  void initState() {
    // TODO: implement initState
    NotificationApi.init(initSchudealed: true);
    listenNotfict();
    NotificationApi.initializetimezone();
    super.initState();
  }

  void listenNotfict() {
    NotificationApi.onNotfications.stream.listen((event) {
      void onClickNotfict(String? payload) =>
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return NotfictOpenedScreen();
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello , ${MedCubit.get(context).userModel!.name} get well soon',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Column(
                      children: [
                        LottieBuilder.asset(
                          'assets/not.json',
                          width: 300,
                          animate: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'You didn\'t add any reminders yet',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        PrimaryButton(
                            text: 'Add now',
                            color: AppColors.primColor,
                            width: double.infinity,
                            height: 45,
                            onPressed: () {
                              navigateTo(context, CreateReminderScreen());
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
