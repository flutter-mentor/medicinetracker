import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedCubit, MedStates>(
        builder: (context, state) {
          return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: MedCubit.get(context).bottomNavBarIndex,
                onTap: (index) {
                  MedCubit.get(context).changeBottomNavBar(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Search ',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.group),
                    label: 'Relatives',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.user),
                    label: 'Me',
                  ),
                ],
              ),
              appBar: AppBar(),
              body: MedCubit.get(context)
                  .appScreens[MedCubit.get(context).bottomNavBarIndex]);
        },
        listener: (context, state) {});
  }
}
