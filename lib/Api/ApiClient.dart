import 'dart:convert';
import 'package:dio/dio.dart';

import 'BaseUrl.dart' as baseUrl;

class ApiClient {
  Future<Response> getTodoList() async {
    try {
      final response = await Dio().get(baseUrl.GET_TASK_LIST,options: Options(headers: getHeader()));
      if (response.statusCode == 200) return response;
    } catch (err) {
      throw err;
    }
  }

  Future<Response> addTodoTask(String todo) async {
    try {
      var body = {
        "task": {
          "description":todo
        }
      };
      final response = await Dio().post(baseUrl.CREATE_TASK,
          data: body,options: Options(headers: getHeader()));
      if (response.statusCode == 201) return response;
    } catch (err) {
      throw err;
    }
  }

  Future<bool> deleteTask(int taskId)
  async {
    try{

      final response=await Dio().delete(baseUrl.DELETE_TASK+taskId.toString(),options: Options(headers: getHeader()));
      if(response.statusCode==204) return await true;
    }catch(err){
      throw err;
    }
  }

  Future<Response> completeTask(int todoId) async {
    try{
      final response=await Dio().put(baseUrl.COMPLETE_TASK+"$todoId/completed",options: Options(headers: getHeader()));
      if(response.statusCode==200)
          return response;
    }catch(err){
      throw err;
    }
  }

  Future<Response> uncompleteTask(int todoId) async {
    try{
      final response=await Dio().put(baseUrl.UNCOMPLETE_TASK+"$todoId/uncompleted",options: Options(headers: getHeader()));
      if(response.statusCode==200)
          return response;
    }catch(err){
      throw err;
    }
  }


  Future<Response> updateTodo(int todoTaskId,String todo)
  async {
    try{
      var body = {
        "task": {
          "description":todo
        }
      };
      final response=await Dio().put(baseUrl.UPDATE_TASK+"$todoTaskId",data: body,options: Options(headers: getHeader()));
      if(response.statusCode==200)
        return response;
    }catch(err){
      throw err;
    }
  }

  Map<String,String> getHeader()
  {
    Map<String,String> map=Map();
    map['Content-Type']='application/json';
    return map;
  }
}
