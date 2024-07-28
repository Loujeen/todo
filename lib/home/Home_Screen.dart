import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:todo/AppColors.dart';
import 'package:todo/home/settings/settings.dart';
import 'package:todo/home/task_list/add_task_bottomsheet.dart';
import 'package:todo/home/task_list/task_list_tab.dart';
class HomeScreen extends StatefulWidget {
  static const String routeName='home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight:
        MediaQuery.of(context).size.height*0.1847133758,
        title: Text('ToDoList',
            style:TextStyle(
            fontWeight:FontWeight.bold,
            fontSize: 22,color: Colors.white)),
      ),
    
    bottomNavigationBar: BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8,
      child: BottomNavigationBar(

        currentIndex: selectedIndex,
          onTap: (index){
          selectedIndex= index;
          setState(() {

          });
          },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list),
              label: 'list'),
          BottomNavigationBarItem(icon: Icon(Icons.settings),
              label: 'Settings'),],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: (){
        showAddTaskBottomSHeet();
      },
      child: Icon(Icons.add,size: 33,),
    ),
    floatingActionButtonLocation:
    FloatingActionButtonLocation.centerDocked ,

    body: Column(
      children: [
        Expanded(child: tabs[selectedIndex])
      ],
    ),
    );

  }
  void showAddTaskBottomSHeet(){
    showModalBottomSheet(context: context,
        builder: (context)=>AddBottomSheet()
    );
  }
  List<Widget> tabs=[TaskListTab(),SettingsTab()];
}
