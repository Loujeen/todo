import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/home/task_list/task_list_item.dart';
import 'package:todo/provider/list_provider.dart';
class TaskListTab extends StatefulWidget {
  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {


  @override
  Widget build(BuildContext context) {
    var listprovider = Provider.of<ListProvider>(context);
    if(listprovider.taskList.isEmpty) {
      listprovider.getAllTasksFromFireStore();
    }
    return Column(
      children: [
        EasyDateTimeLine(
        initialDate: listprovider.selectDate,
        onDateChange: (selectedDate) {
         listprovider.changeSelectDate(selectedDate);
        },
        activeColor: const Color(0xff5d9cec),
          headerProps: const EasyHeaderProps(
          monthPickerType: MonthPickerType.switcher,
          dateFormatter: DateFormatter.fullDateDayAsStrMY(),
        ),
        dayProps: const EasyDayProps(
          activeDayStyle: DayStyle(
            borderRadius: 32.0,
          ),
          inactiveDayStyle: DayStyle(
            borderRadius: 32.0,
          ),
        ),
        timeLineProps: const EasyTimeLineProps(

          hPadding: 16.0,

          separatorPadding: 16.0, // padding between days
        ),
      )
      ,
      Expanded(
        child: ListView.builder(
            itemBuilder: (context,index){
              return TaskListItem(task:listprovider.taskList[index],);
            },
          itemCount: listprovider.taskList.length,
            ),
      )],
    );
  }




}
