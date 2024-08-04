import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/firebase_Utils.dart';
import 'package:todo/model/task.dart';

class ListProvider extends ChangeNotifier {
  List<Task> taskList = [];
  DateTime selectDate = DateTime.now();
  void getAllTasksFromFireStore() async {
    QuerySnapshot<Task> querySnapshot = await FirbaseUtils.getTasksCollection()
        .get();
    taskList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    taskList = taskList.where((task){
      if(selectDate.day ==task.dateTime.day&&
      selectDate.month == task.dateTime.month&&
      selectDate.year == task.dateTime.year){
        return true;
      }
      return false;
    }).toList();

    taskList.sort((Task task1, Task task2){
       return task1.dateTime.compareTo(task2.dateTime);
    });

    notifyListeners();
  }

  void changeSelectDate(DateTime newSelectedDate){
    selectDate = newSelectedDate;
    getAllTasksFromFireStore();
    notifyListeners();
  }

}
