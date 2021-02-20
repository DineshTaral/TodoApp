import 'package:flutter/material.dart';
import 'package:flutter_todo/Bloc/TodoBloc.dart';
import 'package:flutter_todo/Constants/ColorsConstants.dart' ;
import 'package:flutter_todo/Model/TodoModel.dart';
import 'package:flutter_todo/Utils/Utils.dart';
import 'package:flutter_todo/Widgets/TasksWidget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiffy/jiffy.dart';

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {

  TodoBloc _todoBloc=TodoBloc();
  TextEditingController _todoTextController=TextEditingController();
  String randomParagraph="  what constitutes a paragraph. A paragraph is defined as “a group of sentences or a single sentence that forms a unit” (Lunsford and Connors 116). Length and appearance do not determine whether a section in a paper is a paragraph. For instance, in some styles of writing, particularly journalistic styles, a paragraph can be just one sentence long. Ultimately, a paragraph is a sentence or group of sentences that support one main idea. In this handout, we will refer to this as the “controlling idea,” because it controls what happens in the rest of the paragraph";
  //final _scaffoldKey=GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _todoBloc.getTodoDataList();
  }
  @override
  Widget build(BuildContext context) {
    Utils.deviceHeight=MediaQuery.of(context).size.height;
    Utils.deviceWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      //key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text("CBNITS TODO"),
      flexibleSpace:  Container(

        margin: EdgeInsets.only(top: Utils.deviceHeight/40),

        alignment: Alignment.center,
        decoration: new BoxDecoration(
            gradient:  ColorsConstants.LINEAR_GRADIENT1
        ),
      ),
      ),
      body: Container(
        height: Utils.deviceHeight,
        width: Utils.deviceWidth,
        padding: EdgeInsets.symmetric(horizontal: Utils.deviceWidth/40),
    //    decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/background.jpg"),fit: BoxFit.fill)),
        color: ColorsConstants.BACKGROUND_COLOR,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                _todoTextController.text='';
                _showTodoDialog(isTaskUpdating: false);
              },
              child: Container(
                height: Utils.deviceHeight/15,
                width: Utils.deviceWidth,
                margin: EdgeInsets.only(top: Utils.deviceHeight/40),

                alignment: Alignment.center,
                decoration: new BoxDecoration(
                  gradient:  ColorsConstants.LINEAR_GRADIENT1
                ),
                child: Text("Create To-Do",style: Theme.of(context).textTheme.headline2),
              ),
            ),

            Expanded(child:
            StreamBuilder<List<TodoModel>>(
              stream: _todoBloc.getTodoList,
              builder: (context, snapshot) {
                if(snapshot.hasData)
                return ListView.separated(separatorBuilder: (context,index){
                  return SizedBox(
                    height: Utils.deviceHeight/60,
                  );
                },itemCount: _todoBloc.todoList.length,itemBuilder: (context,index){
                  return TasksWidget(_todoBloc.todoList[index], index,deleteSelectedTodoCallback: (selIndex){
                            _todoBloc.deleteTask(context, _todoBloc.todoList[selIndex].id, selIndex);
                  },updateTodoStatusCallback: (selIndex){
                              if(_todoBloc.todoList[selIndex].completedAt==null)

                                  _todoBloc.completeTodoTask(context,_todoBloc.todoList[selIndex].id,selIndex);
                                else  _todoBloc.uncompleteTodoTask(context,_todoBloc.todoList[selIndex].id,selIndex);

                  },
                  updateSelectedTodoCallback: (selIndex){
                    _todoTextController.text=_todoBloc.todoList[selIndex].description;
                    _showTodoDialog(isTaskUpdating: true,selIndex: selIndex,id: _todoBloc.todoList[selIndex].id);
                  },
                  );
                });
                else return Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              }
            ))


          ],
        ),


      ),
    );
  }


  _showTodoDialog({bool isTaskUpdating,int id,int selIndex})
  {
    return showDialog(
    context: context,
      barrierDismissible: false,
      child:   Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(10),

          child: Container(

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ColorsConstants.BACKGROUND_COLOR
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              //overflow: Overflow.visible,
            //  alignment: Alignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Add Task",style: Theme.of(context).textTheme.headline2,),
                SizedBox(height: 10,),
                TextFormField(
                  maxLines: 5,
                  controller: _todoTextController,
                  decoration: InputDecoration(
                    hintText: "Add to list…",
                    border: OutlineInputBorder(),
                  ),


                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child:InkWell(
                        onTap: ()=>Navigator.pop(context),
                        child: Container(
                          height: Utils.deviceHeight/25,
                          //   width: Utils.deviceWidth,
                          margin: EdgeInsets.only(top: Utils.deviceHeight/40),

                          alignment: Alignment.center,
                          /*  decoration: new BoxDecoration(
                             gradient:  ColorsConstants.LINEAR_GRADIENT1
                         ),*/
                          child: Text("Cancel",style: Theme.of(context).textTheme.headline3),
                        ),
                      ),
                    ) ,
                    Expanded(
                      flex: 1,
                      child:InkWell(
                        onTap: (){
                          if(_todoTextController.text=='')
                            {
                              Fluttertoast.showToast(
                                  msg: "Please add TODO content",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );    }
                          else{

                            if(isTaskUpdating)
                              _todoBloc.updateTask(context,id,_todoTextController.text,selIndex);
                              else
                            _todoBloc.addTodo(context,_todoTextController.text);
                          }


                        },
                        child: Container(
                          height: Utils.deviceHeight/30,
                          //   width: Utils.deviceWidth,
                          margin: EdgeInsets.only(top: Utils.deviceHeight/40),

                          alignment: Alignment.center,
                          decoration: new BoxDecoration(
                              gradient:  ColorsConstants.LINEAR_GRADIENT1
                          ),
                          child: Text("${isTaskUpdating?"Update Todo":"Add Todo"}",style: Theme.of(context).textTheme.headline3),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
      )
    );
  }
}
