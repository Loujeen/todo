import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/model/task.dart';

class FirbaseUtils{

  static CollectionReference<Task> getTasksCollection(){
   return FirebaseFirestore.instance.collection(Task.collectionname).
    withConverter<Task>(
        fromFirestore:((snapshot,options)=>Task.fromFireStore(snapshot.data()!)) ,
        toFirestore:(task,options)=> task.toFireStore() );

  }
  static Future<void> addTaskToFireStore(Task task ){
  var taskCollection =getTasksCollection();
  DocumentReference<Task> taskDocRef = taskCollection.doc();
 task.id= taskDocRef.id;

 return taskDocRef.set(task);


  }
static Future<void> deleteTaskFromFireStore(Task task){
   return getTasksCollection().doc(task.id).delete();
}
}