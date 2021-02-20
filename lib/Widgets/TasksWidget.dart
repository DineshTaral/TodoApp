import 'package:flutter/material.dart';
import 'package:flutter_todo/Constants/ColorsConstants.dart';
import 'package:flutter_todo/Model/TodoModel.dart';
import 'package:flutter_todo/Utils/Callbacks.dart';
import 'package:flutter_todo/Utils/Utils.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sizer/sizer.dart';
class TasksWidget extends StatelessWidget {
  int index;
  TodoModel todoModel;
  DeleteSelectedTodoCallabck deleteSelectedTodoCallback;
  UpdateSelectedTodoCallback updateSelectedTodoCallback;
  UpdateTodoStatusCallback updateTodoStatusCallback;
  TasksWidget(this.todoModel,this.index,{this.updateSelectedTodoCallback,this.deleteSelectedTodoCallback,this.updateTodoStatusCallback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        updateSelectedTodoCallback(index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Utils.deviceWidth/40,vertical: Utils.deviceWidth/40),
        margin: EdgeInsets.only(top: index==0?Utils.deviceHeight/40:0),
        decoration: BoxDecoration(
            color: todoModel.completedAt==null?Colors.white:Colors.grey,
            gradient: todoModel.completedAt==null?ColorsConstants.LINEAR_GRADIENT1:ColorsConstants.LINEAR_GRADIENT2,
            boxShadow: [BoxShadow(
                color: Colors.black54,
                blurRadius: 3.0,
                offset: Offset(0.0, 3.0)

            ),]
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    flex:5,
                    child: Text("${Jiffy(todoModel.createdAt).fromNow()}",style: Theme.of(context).textTheme.headline1,)),
                Expanded(
                    flex: 1,
                    child: IconButton(icon: Icon(Icons.delete,color: ColorsConstants.WHITE_ICON_COLOR,), onPressed: (){
                    deleteSelectedTodoCallback(index);
                    }))
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex:5,child: Text(todoModel.description,style: TextStyle(fontSize: 12.0.sp,color: ColorsConstants.WHITE_TEXT_COLOR,decoration: todoModel.completedAt==null?null:TextDecoration.lineThrough),)),
                Expanded(
                    flex: 1,
                    child: Checkbox(
                      value: todoModel.completedAt==null?false:true,
                    onChanged: (val){
                        updateTodoStatusCallback(index);
                    },
                    ),

                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
