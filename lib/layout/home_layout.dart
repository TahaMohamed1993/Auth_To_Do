// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import '../models/shared/cubit/cubit.dart';
import '../models/shared/cubit/states.dart';
import '../widgets/components/component.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class HomeLayout extends StatelessWidget {
// 1. create database
// 2. create  Tabls
// 3. open database
// 4. insert to database
// 5. get from database
// 6. update in database
// 7.delete from database

  TextEditingController taskTitelController = TextEditingController();
  TextEditingController taskTimeController = TextEditingController();
  TextEditingController taskDateController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => AppCubit()..creatDatabase(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
            if (state is AppInsertToDataBaseState) {
              Navigator.pop(context);
            }
          },
          builder: (BuildContext context, AppStates state) {
            AppCubit cubit = AppCubit.get(context);

            return Scaffold(
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    const DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 125, 184, 198),
                      ),
                      child: Text(
                        'Drawer Header',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Sign Out'),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushReplacementNamed(
                            'login'); // Replace '/login' with your desired route after signing out
                      },
                    ),
                  ],
                ),
              ),
              key: scaffoldKey,
              appBar: AppBar(
                title: Text(cubit.titles[cubit.selectedIndex]),
                centerTitle: true,
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubit.showBottomSheet) {
                    if (formKey.currentState!.validate()) {
                      cubit.insertToDatabase(
                        title: taskTitelController.text,
                        date: taskDateController.text,
                        time: taskTimeController.text,
                      );
                    }
                  } else {
                    scaffoldKey.currentState!
                        .showBottomSheet(
                          elevation: 20,
                          (context) => Container(
                            color: Colors.teal[200],
                            padding: const EdgeInsets.all(20),
                            child: Form(
                              key: formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    dufaltFormField(
                                        keyboardType: TextInputType.text,
                                        validat: (value) {
                                          if (value!.isEmpty) {
                                            return 'Title Must not Be Empty';
                                          }
                                          return null;
                                        },
                                        hintText: 'Task Titel',
                                        icon: const Icon(Icons.title),
                                        controller: taskTitelController),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    dufaltFormField(
                                        onTap: () {
                                          showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          ).then((value) {
                                            taskTimeController.text = value!
                                                .format(context)
                                                .toString();
                                            print(value.format(context));
                                          });
                                        },
                                        keyboardType: TextInputType.datetime,
                                        validat: (value) {
                                          if (value!.isEmpty) {
                                            return 'time Must not Be Empty';
                                          }
                                          return null;
                                        },
                                        hintText: 'Task time',
                                        icon: const Icon(
                                            Icons.more_time_outlined),
                                        controller: taskTimeController),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    dufaltFormField(
                                        onTap: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.parse(
                                                      '2023-12-12'))
                                              .then((value) {
                                            taskDateController.text =
                                                DateFormat.yMMMd()
                                                    .format(value!);
                                          });
                                        },
                                        keyboardType: TextInputType.datetime,
                                        validat: (value) {
                                          if (value!.isEmpty) {
                                            return 'Date Must not Be Empty';
                                          }
                                          return null;
                                        },
                                        hintText: 'Task Date',
                                        icon: const Icon(
                                            Icons.date_range_outlined),
                                        controller: taskDateController),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .closed
                        .then((value) {
                      cubit.changBottomSheetState(
                          isShow: false, icon: Icons.edit);
                    });
                    cubit.changBottomSheetState(isShow: true, icon: Icons.add);
                  }
                },
                child: Icon(cubit.fabIcon),
              ),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 20, color: Colors.black.withOpacity(.1))
                  ],
                ),
                child: GNav(
                  selectedIndex: cubit.selectedIndex,
                  onTabChange: (index) {
                    cubit.changIndex(index);
                  },
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[300]!,
                  // tabBorder: Border(),
                  // tabActiveBorder: Border.all(),
                  //       backgroundColor: Colors.lightGreen,

                  style: GnavStyle.google,
                  color: Colors.black,
                  activeColor: Colors.black,
                  gap: 6,
                  iconSize: 24,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.grey[100]!,

                  tabs: const [
                    GButton(
                      icon: Icons.menu,
                      text: 'Tasks',
                    ),
                    GButton(
                      icon: Icons.check_circle_outline,
                      text: 'Done!',
                    ),
                    GButton(
                      icon: Icons.archive_outlined,
                      text: 'Archive',
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                  condition: state is! AppGetFromDataBaseLoadingState,
                  builder: (context) => cubit.screen[cubit.selectedIndex],
                  fallback: (context) =>
                      const Center(child: CircularProgressIndicator())),
            );
          },
        ));
  }
}
