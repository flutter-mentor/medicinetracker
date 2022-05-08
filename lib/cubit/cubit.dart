import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:medicine_tracker/cubit/states.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/helpers/notification_api.dart';
import 'package:medicine_tracker/models/dose_model.dart';
import 'package:medicine_tracker/models/intake_model.dart';
import 'package:medicine_tracker/models/medicine_model.dart';
import 'package:medicine_tracker/screens/create_dose_screen/set_timings/set_timings.dart';
import 'package:medicine_tracker/screens/create_dose_screen/main_screen/main_screen.dart';
import 'package:medicine_tracker/screens/profile_screen.dart';
import 'package:medicine_tracker/screens/relatives_screen.dart';
import 'dart:math' show cos, sqrt, asin;
import '../const/const.dart';
import '../models/user_model.dart';
import '../screens/create_dose_screen/choose_med_name_screen/first_step_screen.dart';
import '../screens/search_screen.dart';

class MedCubit extends Cubit<MedStates> {
  static MedCubit get(context) => BlocProvider.of(context);
  MedCubit() : super(MedInitialState());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lNAmeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isPassword = true;
  String obSecureText = 'Show';
  bool userLoginIn = true;
  int bottomNavBarIndex = 0;
  void changeBottomNavBar(int index) {
    bottomNavBarIndex = index;
    emit(ChangeBottomBar());
  }

  List<Widget> appScreens = [
    MainScreen(),
    SearchScreen(),
    RelativesScreen(),
    ProfileScreen(),
  ];
  void changeAuthBehavior() {
    userLoginIn = !userLoginIn;
    emit(ChangeAuthBehavior());
  }

  int currentPageViewIndex = 0;
  void nestStep() {
    currentPageViewIndex++;
    emit(ChangedPageViewIndex());
  }

  void previousStep() {
    currentPageViewIndex--;
    emit(ChangedPageViewIndex());
  }

  String mediceneNAme = '';
  String freq = '';

  String notfictBody = 'Please update dose to notfiy realtives';
  List<Widget> stepsScreens = [
    PickMedName(),
    SetTimings(),
  ];
  int reminderIdGenerator = 0;

  void removeIntake(int index) {
    intakes.removeAt(index);
    emit(RemovedIntakeDone());
  }

  void saveReminder({
    required String medName,
    required int interval,
  }) {
    emit(AddReminderLoading());
    reminderIdGenerator = DateTime.now().hour +
        DateTime.now().minute +
        DateTime.now().second +
        DateTime.now().microsecond;
    DoseModel doseModel = DoseModel(
        medName: medName,
        intakes: intakes.map((e) {
          return {'time': e.time, 'dose': e.dose};
        }).toList(),
        interval: interval,
        hint: notfictBody,
        taken: interval,
        payload: mediceneNAme,
        createdAt: Timestamp.now(),
        id: reminderIdGenerator);
    NotificationApi.showSchadNotfictDaily(
        id: reminderIdGenerator,
        title: medName,
        body: medName,
        paylod: '',
        h: intakeTime.hour,
        m: intakeTime.minute,
        s: 0);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('reminders')
        .doc(reminderIdGenerator.toString())
        .set(doseModel.toMap())
        .then((value) {
      emit(AddReminderDone());
    }).catchError((error) {
      emit(AddReminderError(error.toString()));
      print(error.toString());
    });
  }

  DateTime intakeTime = DateTime.now();
  void chooseDateTime(DateTime choosed) {
    intakeTime = choosed;
    emit(ChoosedDateTime());
  }

  void changePAsswordBehavior() {
    isPassword = !isPassword;
    if (isPassword == false) {
      obSecureText = 'Hide';
    } else if (isPassword == true) {
      obSecureText = 'Show';
    }
    emit(ChangePasswordBehavior());
  }

  List<IntakeModel> intakes = [];

  void addIntakes({
    required DateTime time,
    required int dose,
  }) {
    intakes.add(IntakeModel(time: time, dose: dose));
    emit(AddIntakesDone());
  }

  String errorMessage = '';
  void login({required String email, required String password}) {
    emit(LoginLoading());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(LoginDone(value.user!.uid));
      uId = value.user!.uid;
    }).catchError((error) {
      emit(LoginError(error.toString()));
      switch (error.code) {
        case 'invalid-email':
          errorMessage = "Incorrect email";
          break;
        case "wrong-password":
          errorMessage = "Incorrect password";
          break;
        case "too-many-requests":
          errorMessage = "Something went wrong , try again";
          break;

        default:
          errorMessage = "Something went wrong , try again";
      }
    });
  }

  void createUser({
    required String name,
    required String eMail,
    required String uId,
    required String phone,
    required String lName,
  }) {
    emit(CreateUserLoading());
    UserModel userModel = UserModel(
      name: name,
      phone: phone,
      eMail: eMail,
      uId: uId,
      lastname: lName,
      relatives: [],
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {})
        .catchError((error) {
      emit(CreateUserError(error.toString()));
    });
  }

  UserModel? userModel;
  void getUserData() {
    // emit(GetUserLoading());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);

      print(value.data().toString());
      emit(GetUserDone());
    }).catchError((error) {
      emit(GetUserError(error.toString()));
      print(error.toString());
    });
  }

  void signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String lName,
  }) {
    emit(SignUpLoading());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(
        name: name,
        lName: lName,
        phone: phone,
        eMail: email,
        uId: value.user!.uid,
      );
      emit(CreateUserDone(value.user!.uid));
    }).catchError((error) {
      emit(SignUpError(error.toString()));

      switch (error.code) {
        case "email-already-in-use":
          errorMessage = "Email already in use";
          break;
        case "invalid-email":
          errorMessage = "Incorrect E-mail";
          break;
        case "wrong-password":
          errorMessage = "Incorrect password";
          break;
        case "too-many-requests":
          errorMessage = "Something went wrong , try again";
          break;

        default:
          errorMessage = "Something went wrong , try again";
          print(error.code.toString());
      }
    });
  }

  void addMedicine() {
    MedicineModel medicineModel = MedicineModel(
        name: 'bi alcofan', effective: 'paracetamol', initPrice: 12.5);
    FirebaseFirestore.instance
        .collection('medicines')
        .add(medicineModel.toMap())
        .then((value) {
      emit(AddMedDone());
    }).catchError((error) {
      emit(AddMedError(error.toString()));
    });
  }

  List<MedicineModel> medicineList = [];
  void getMedicines() {
    FirebaseFirestore.instance
        .collection('medicines')
        .snapshots()
        .listen((event) {
      medicineList = [];
      event.docs.forEach((element) {
        medicineList.add(MedicineModel.fromJson(element.data()));
      });
      emit(GetMedDone());
    });
  }

  void searchMedicine({
    required String medName,
    required List<MedicineModel> medList,
  }) {
    getMedicines();
    medList = medicineList.where((element) {
      return element.name.contains(medName);
    }).toList();
    emit(FoundMedicine());
  }
}
