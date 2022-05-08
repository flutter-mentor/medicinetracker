import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/widgets/medicine_widget.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../models/medicine_model.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<MedicineModel> medList = [];
  List<MedicineModel> synonmsList = [];

  // const SearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      MedCubit.get(context).getMedicines();

      return BlocConsumer<MedCubit, MedStates>(
          builder: (context, state) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Medicine finder',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      ),
                      child: TextFormField(
                        onChanged: (v) {
                          setState(() {
                            medList = MedCubit.get(context)
                                .medicineList
                                .where((element) {
                                  return element.name.contains(v);
                                })
                                .toSet()
                                .toList();

                            print(medList.length);
                            if (v.isEmpty) {
                              medList = [];
                              synonmsList = [];
                            }
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Type medicine name',
                          hintStyle: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemBuilder: (context, index) {
                        var synonom = medList[index].effective;

                        synonmsList =
                            MedCubit.get(context).medicineList.where((element) {
                          return element.effective.contains(synonom) &&
                              element.name != medList[index].name;
                        }).toList();
                        return MedicineWidget(model: medList[index]);
                      },
                      itemCount: medList.length,
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Same active substance',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: synonmsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                width: 340,
                                child:
                                    MedicineWidget(model: synonmsList[index]));
                          }),
                    ),
                  ],
                ),
              ),
            );
          },
          listener: (context, state) {});
    });
  }
}
