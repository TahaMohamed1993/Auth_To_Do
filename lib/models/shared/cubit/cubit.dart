import 'package:auth_todo_sqflite/models/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/archived_tasks.dart';
import '../../model/done_tasks.dart';
import '../../model/new_task.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());
  static AppCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;

  List<Widget> screen = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  void changIndex(int index) {
    selectedIndex = index;
    emit(AppChangeNavBottomBarState());
  }

  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivetasks = [];

  late Database database;
  void creatDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) async {
        // print('Created dataBase');

        await database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT,status TEXT)')
            .then((value) {
          print('Created Table');
        }).catchError((Error) {
          print('Error when Creating Table ${Error.toString()} dataBase');
        });
      },
      onOpen: (database) {
        getDataFromDataBase(database);
        print('openDateBase');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });
  }

  insertToDatabase(
      {required String title,
      required String date,
      required String time}) async {
    await database.transaction((txn) => txn
            .rawInsert(
                'INSERT INTO tasks(title,date,time,status) VALUES("$title", "$date", "$time","New")')
            .then((value) {
          print('$value Inserted Sucxessfuly');
          emit(AppInsertToDataBaseState());
          getDataFromDataBase(database);
        }).catchError((onError) {
          print('Error when insert raw  ${onError.toString()} table');
        }));
  }

  getDataFromDataBase(database) {
    newtasks = [];
    donetasks = [];
    archivetasks = [];
    emit(AppGetFromDataBaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach(
        (element) {
          if (element['status'] == 'New') {
            newtasks.add(element);
          } else if (element['status'] == 'done') {
            donetasks.add(element);
          } else {
            archivetasks.add(element);
          }
        },
      );
      emit(AppGetFromDataBaseState());
    });
  }

  void deleteData({required int id}) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDataBase(database);
      emit(AppDeletDataRawFormBaseState());
    });
  }

  updateData({
    required String status,
    required int id,
  }) async {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', '$id'],
    ).then(
      (value) {
        getDataFromDataBase(database);
        emit(
          AppUpdateDataBaseState(),
        );
      },
    );
  }

  bool showBottomSheet = false;
  IconData fabIcon = Icons.edit;
  void changBottomSheetState({required bool isShow, required IconData icon}) {
    showBottomSheet = isShow;
    fabIcon = icon;
    emit(AppChangBottomSheetState());
  }
}
