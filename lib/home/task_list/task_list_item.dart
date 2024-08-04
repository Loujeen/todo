import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/AppColors.dart';
import 'package:todo/firebase_Utils.dart';
import 'package:todo/home/task_list/edit_page.dart';
import 'package:todo/model/task.dart';
import 'package:todo/provider/list_provider.dart';

import 'package:intl/intl.dart'; // For date formatting

class TaskListItem extends StatefulWidget {
  final Task task;
  TaskListItem({required this.task});

  @override
  _TaskListItemState createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var listProvider = Provider.of<ListProvider>(context);

    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                FirbaseUtils.deleteTaskFromFireStore(widget.task).timeout(
                  Duration(milliseconds: 500),
                  onTimeout: () {
                    print('task deleted successfully');
                    listProvider.getAllTasksFromFireStore();
                  },
                );
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () async {
            final updatedTask = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditTaskPage(task: widget.task),
              ),
            );
            if (updatedTask != null) {
              setState(() {
                widget.task.title = updatedTask.title;
                widget.task.description = updatedTask.description;
                widget.task.dateTime = updatedTask.date;
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.whiteColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(12),
                  color: isDone ? Colors.green : AppColors.primaryColor,
                  width: width * 0.01,
                  height: height * 0.1,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.task.title,
                        style: TextStyle(
                          color: isDone ? Colors.green : AppColors.primaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.task.description,
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: isDone ? Colors.green : AppColors.primaryColor,
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isDone = !isDone;
                      });
                    },
                    icon: isDone
                        ? Text(
                      'Done',
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                        : Icon(
                      Icons.check,
                      size: 35,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
