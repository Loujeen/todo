import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_Utils.dart';
import 'package:todo/model/task.dart';
import 'package:todo/provider/list_provider.dart';
class AddBottomSheet extends StatefulWidget {


  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  var selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
String title = '';
String description = '';
late ListProvider listProvider;
  @override
  Widget build(BuildContext context) {
     listProvider = Provider.of<ListProvider>(context);
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Text("add new", style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700
          ),
          ),
          Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    onChanged:(text){
                      title=text;
                    },
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "please enter task title";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter task title'
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    onChanged:(text){
                      description=text;
                    },
                    validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "please enter task description";
                    }
                    return null;
                  },
                    decoration: InputDecoration(
                        hintText: 'Enter task Description'
                    ),
                    maxLines: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('Select Date', style: TextStyle(fontSize: 22),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        showCalender();
                      },
                      child: Text('${selectedDate.day}/${selectedDate
                          .month}/${selectedDate.year}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),),
                    ),
                  ),
                  ElevatedButton(onPressed: () {
                    addTask();
                  }
                      , child: Text('Add'))
                ],))
        ],
      ),
    );
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    selectedDate = chosenDate ?? selectedDate;
    setState(() {

    });
  }


  void addTask() {
    if (formKey.currentState?.validate()==true){
      Task task = Task(
          title: title,
          description: description,
          dateTime: selectedDate,
      isDone: true,
      );
     FirbaseUtils.addTaskToFireStore(task).timeout(Duration(seconds: 1),onTimeout: (){
       print('Task added successfully');
       listProvider.getAllTasksFromFireStore();
       Navigator.pop(context);
     });
    }
  }
}