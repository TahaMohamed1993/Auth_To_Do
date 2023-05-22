import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/components/component.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

// import '../../widgets/components/dufaltFormFiled.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var tasks = AppCubit.get(context).donetasks;

    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) => taskasBuilder(tasks: tasks));
  }
}
// buildTaskItem()