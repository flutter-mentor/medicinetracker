import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicine_tracker/models/medicine_model.dart';

import '../const/const.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class MedicineWidget extends StatelessWidget {
  MedicineModel model;
  MedicineWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  'https://i-cf65.ch-static.com/content/dam/cf-consumer-healthcare/panadol/en_eg/Products/455x455-Advance-eng%20eg_new.jpg?auto=format',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.primColor.withOpacity(0.15),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.pills,
                                size: 16,
                                color: AppColors.primColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${model.effective}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      color: AppColors.primColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.primColor.withOpacity(0.15),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.moneyBill1Wave,
                                size: 16,
                                color: AppColors.primColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'from EGP ${model.initPrice}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      color: AppColors.primColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        listener: (context, state) {});
  }
}
