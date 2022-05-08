import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_tracker/cubit/cubit.dart';
import 'package:medicine_tracker/cubit/states.dart';
import 'package:medicine_tracker/layout/layout.dart';
import 'dart:io';

import '../componenets/componenets.dart';
import '../const/const.dart';
import '../network/local/cash_helper.dart';
import '../widgets/adabtive_simple_dialogue.dart';
import '../widgets/adabtive_spinnerr.dart';
import '../widgets/custom_text_filled.dart';
import '../widgets/primary_button.dart';
import 'create_an_accont_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    return BlocConsumer<MedCubit, MedStates>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Login',
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFilled(
                        label: 'E-mail',
                        height: 45,
                        readOnly: false,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return ' E-mail is required';
                          }
                        },
                        isPasword: false,
                        controller: emailController),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFilled(
                      label: 'Password',
                      readOnly: false,
                      height: 55,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Password is required';
                        }
                      },
                      isPasword: MedCubit.get(context).isPassword,
                      controller: MedCubit.get(context).passwordController,
                      suffix: InkWell(
                        onTap: () {
                          MedCubit.get(context).changePAsswordBehavior();
                        },
                        child: Text(
                          MedCubit.get(context).obSecureText,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (state is LoginLoading)
                      CustomAdabtiveSpinner(isIos: Platform.isIOS),
                    if (state is! LoginLoading)
                      PrimaryButton(
                          text: 'Login',
                          color: AppColors.primColor,
                          width: double.infinity,
                          height: 45,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              MedCubit.get(context).login(
                                  email: MedCubit.get(context)
                                      .emailController
                                      .text,
                                  password: MedCubit.get(context)
                                      .passwordController
                                      .text);
                            }
                          }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              navigateTo(context, const CreateAnAccontScreen());
                            },
                            child: Text(
                              'Don\'t have an account?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 14),
                            )),
                        TextButton(
                            onPressed: () {
                              // navigateTo(context, ForgetPasswordScreen());
                            },
                            child: Text(
                              'Forget Password',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 14),
                            )),
                      ],
                    ),
                    Container(
                      child: Text(
                        'Get well soon..',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is LoginError) {
        showDialog(
            context: context,
            builder: (context) => AdabtiveSimpleDialogue(
                title: Text(MedCubit.get(context).errorMessage)));
      }
      if (state is LoginDone) {
        MedCubit.get(context).getUserData();
        navigateAndFinish(context, LayoutScreen());
        CacheHelper.saveData(key: 'uid', value: state.uId);
        uId = CacheHelper.getData(key: 'uid');
        CacheHelper.putBoolean(key: 'created', value: true);
        CacheHelper.putBoolean(key: 'onboarding', value: true);
      }
    });
  }
}
