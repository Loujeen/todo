import 'package:flutter/material.dart';
class AddBottomSheet extends StatefulWidget {


  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  var selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
String title = '';
String description = '';
  @override
  Widget build(BuildContext context) {
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

    }
  }
}