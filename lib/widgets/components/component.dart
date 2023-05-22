import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../models/shared/cubit/cubit.dart';

Widget dufaltFormField(
        {required TextInputType? keyboardType,
        bool obscureText = false,
        required String? Function(String?)? validat,
        Widget? label,
        void Function()? onTap,
        required String? hintText,
        required Widget? icon,
        TextEditingController? controller,
        Widget? prefixIcon}) =>
    TextFormField(
      onTap: onTap,
      obscureText: obscureText,
      controller: controller,
      validator: validat,
      decoration: InputDecoration(
        suffixIcon: prefixIcon,
        icon: icon,
        label: label,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black),
      ),
    );

Widget buildTaskItem(Map model, context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Dismissible(
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
      key: UniqueKey(),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.0,
            child: Text('${model['time']}'),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['title']}',
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  ' ${model['date']}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context).updateData(status: 'done', id: model['id']);
            },
            icon: const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context)
                  .updateData(status: 'archive', id: model['id']);
            },
            icon: const Icon(
              Icons.archive,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget taskasBuilder({required List<Map> tasks}) {
  return ConditionalBuilder(
    condition: tasks.length > 0,
    fallback: (BuildContext context) => const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu_outlined,
            size: 100,
            color: Colors.grey,
          ),
          Text(
            'No Taskas Yet ,Please add Some Task',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
    builder: (BuildContext context) => ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
        separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsetsDirectional.only(start: 20),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
        itemCount: tasks.length),
  );
}
