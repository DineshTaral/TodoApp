import 'package:flutter/cupertino.dart';
import 'package:flutter_todo/Api/ApiClient.dart';
import 'package:flutter_todo/Model/TodoModel.dart';
import 'package:flutter_todo/Widgets/CustomProgressDialog.dart';
import 'package:rxdart/rxdart.dart';
import '../Constants/KeysConstants.dart' as keysConstants;
class TodoBloc
{
  final _todoController=BehaviorSubject<List<TodoModel>>();
  Function(List<TodoModel>) get setTodoList=>_todoController.sink.add;
  Stream<List<TodoModel>> get getTodoList=> _todoController.stream;
  CustomProgressDialog _customProgressDialog=CustomProgressDialog();
  List<TodoModel> todoList=List();
   final _apiClient=ApiClient();

  getTodoDataList(){
    _apiClient.getTodoList().then((value) async {
      print("value is ${value.data}");
      List<TodoModel> uncompletedTaskList=List();
      List<TodoModel> completedTaskList=List();
    await  value.data.forEach((element){
        TodoModel todoModel=TodoModel();
        todoModel.id=element[keysConstants.ID];
        todoModel.title=element[keysConstants.TITLE];
        todoModel.userId=element[keysConstants.USER_ID];
        todoModel.description=element[keysConstants.DESCRIPTION];
        todoModel.completedAt=element[keysConstants.COMPLETED_AT];
        todoModel.createdAt=element[keysConstants.CREATED_AT];
        todoModel.updatedAt=element[keysConstants.UPDATED_AT];
        if(todoModel.completedAt==null)
          {
            uncompletedTaskList.add(todoModel);
          }else {
          completedTaskList.add(todoModel);
        }
      });

      setDataInRxDart(uncompletedTaskList, completedTaskList);
    }).catchError((onError){
      print("error in get to do list $onError");
    });
  }


  addTodo(BuildContext context,String todoContent)
  {
    _customProgressDialog.showProgressDialog(context);
    _apiClient.addTodoTask(todoContent).then((value) {
      print("add data  ${value.data}");
      TodoModel todoModel=TodoModel();
      todoModel.id=value.data[keysConstants.ID];
      todoModel.title=value.data[keysConstants.TITLE];
      todoModel.userId=value.data[keysConstants.USER_ID];
      todoModel.description=value.data[keysConstants.DESCRIPTION];
      todoModel.completedAt=value.data[keysConstants.COMPLETED_AT];
      todoModel.createdAt=value.data[keysConstants.CREATED_AT];
      todoModel.updatedAt=value.data[keysConstants.UPDATED_AT];
      todoList.insert(0,todoModel);
      setTodoList(todoList);
      _customProgressDialog.dismiss(context);
      Navigator.pop(context);
    }).catchError((onError){
      _customProgressDialog.dismiss(context);
      print("error in create todo $onError");
    });
  }


  deleteTask(BuildContext context,int taskId,int index){
    _customProgressDialog.showProgressDialog(context);
    _apiClient.deleteTask(taskId).then((value) {
      if(value) {
       // Navigator.pop(context);
        todoList.removeAt(index);
        setTodoList(todoList);
        _customProgressDialog.dismiss(context);
      }
    }).catchError((onError){
      _customProgressDialog.dismiss(context);
      print("error in delete task $onError");

    });
  }



  completeTodoTask(BuildContext context,int todoTaskId,int index){
_customProgressDialog.showProgressDialog(context);
    _apiClient.completeTask(todoTaskId).then((value) async {
      List<TodoModel> uncompletedTaskList=List();
      List<TodoModel> completedTaskList=List();
      todoList[index].completedAt=value.data[keysConstants.COMPLETED_AT];
      todoList.forEach((element) {
        if(element.completedAt!=null)
            completedTaskList.add(element);
        else uncompletedTaskList.add(element);
      });
     await setDataInRxDart(uncompletedTaskList, completedTaskList);
      _customProgressDialog.dismiss(context);

    }).catchError((onError){
      _customProgressDialog.dismiss(context);
      print("error in complete todo task $onError");
    });
  }

  uncompleteTodoTask(BuildContext context,int todoTaskId,int index){
_customProgressDialog.showProgressDialog(context);
    _apiClient.uncompleteTask(todoTaskId).then((value) async {
      List<TodoModel> uncompletedTaskList=List();
      List<TodoModel> completedTaskList=List();
      todoList[index].completedAt=null;
      todoList.forEach((element) {
        if(element.completedAt!=null)
          completedTaskList.add(element);
        else uncompletedTaskList.add(element);
      });
     await setDataInRxDart(uncompletedTaskList, completedTaskList);
     _customProgressDialog.dismiss(context);
    }).catchError((onError){
      _customProgressDialog.dismiss(context);

      print("error in complete todo task $onError");
    });
  }

  updateTask(BuildContext context,int taskId,String content,int index){
_customProgressDialog.showProgressDialog(context);
    _apiClient.updateTodo(taskId,content).then((value){
          todoList[index].description=content;
          _customProgressDialog.dismiss(context);
          Navigator.pop(context);
    }).catchError((onError){
      _customProgressDialog.dismiss(context);
      print("error in update todo ${onError}");
    });
  }

  setDataInRxDart(List<TodoModel> uncompletedTaskList, List<TodoModel> completedTaskList )
  {
    todoList.clear();
    setTodoList(null);
    int incrementVal=0;
    uncompletedTaskList.sort((a,b){
      return b.createdAt.compareTo(a.createdAt);
    });
    completedTaskList.sort((a,b){
      return a.completedAt.compareTo(b.completedAt);
    });


    for(int i=0;i<uncompletedTaskList.length;i++)
    {
      todoList.add(uncompletedTaskList[i]);
    }
    for(int i=uncompletedTaskList.length;i<completedTaskList.length+uncompletedTaskList.length;i++)
    {
      todoList.add(completedTaskList[incrementVal]);
      incrementVal++;
    }

    setTodoList(todoList);

  }
}