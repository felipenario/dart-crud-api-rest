import 'dart:async';
import 'dart:convert';

import 'package:dart_rest_api/models/homework.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'homework_controller.g.dart';

class HomeworkController {

  HomeworkController(this._homeworkCollection);

  final DbCollection _homeworkCollection;

  @Route.post('/addHomework')
  FutureOr<Response> addHomework(Request request) async{
    try{
      final body = jsonDecode(await request.readAsString());
      final homework = Homework.fromJson(body);
      await _homeworkCollection.save(homework.toJson());
      return Response(201, body: jsonEncode([
        {
          'msg': 'Trabalho/tarefa criado(a) com sucesso!',
          'homework': homework
        }
      ]), headers: {'Content-Type': 'application/json'});
    } catch(e){
      final error = {
        'msg': 'Erro ao cadastrar!',
        'error': e.toString()
      };
      return Response.internalServerError(body: jsonEncode(error), headers: {'Content-Type': 'application/json'});
    }
  }

  @Route.put('/editHomework')
  FutureOr<Response> editHomework(Request request) async{
    try{
      final body = jsonDecode(await request.readAsString());
      final editedHomework = Homework.fromJson(body);
      final homeworkToEdit = await _homeworkCollection.findOne(where.id(ObjectId.parse(editedHomework.id)));
      await _homeworkCollection.update(homeworkToEdit, editedHomework.toJsonWithoutId());
      return Response.ok(jsonEncode([
        {
          'msg': 'Trabalho/tarefa editado com sucesso!',
          'homework': editedHomework
        }
      ]), headers: {'Content-Type': 'application/json'});
    }catch (e){
      final error = {
        'msg': 'Erro ao editar!',
        'error': e.toString()
      };
      return Response.internalServerError(body: jsonEncode(error), headers: {'Content-Type': 'application/json'});
    }
  }

  @Route.get('/getById/<id>')
  FutureOr<Response> getById(Request request, String id) async{
    try{
      final homework = await _homeworkCollection.findOne(where.id(ObjectId.parse(id)));
      return Response.ok(jsonEncode(homework), headers: {'Content-Type': 'application/json'});
    }catch (e){
      final error = {
        'msg': 'Ocorreu um erro!',
        'error': e.toString()
      };
      return Response.internalServerError(headers: {'Content-Type': 'application/json'}, body: jsonEncode(error));
    }
  }

  @Route.get('/getAll')
  FutureOr<Response> getAll(Request request) async{
    try{
      final homeworkList = await _homeworkCollection.find().toList();
      return Response.ok(jsonEncode(homeworkList), headers: {'Content-Type': 'application/json'});
    }catch (e){
      final error = {
        'msg': 'Ocorreu um erro!',
        'error': e.toString()
      };
      return Response.internalServerError(headers: {'Content-Type': 'application/json'}, body: jsonEncode(error));
    }
  }
  
  @Route.delete('/deleteHomework/<id>')
  FutureOr<Response> deleteHomework(Request request, String id) async{
    try{
      final homeworkToDelete = await _homeworkCollection.findOne(where.id(ObjectId.parse(id)));
      if(homeworkToDelete != null){
        await _homeworkCollection.remove(homeworkToDelete);
      }
      return Response.ok(jsonEncode({
        'msg': 'Trabalho/tarefa deletado(a) com sucesso!'
      }), headers: {'Content-Type': 'application/json'});
    }catch (e){
      final error = {
        'msg': 'Ocorreu um erro!',
        'error': e.toString()
      };
      return Response.internalServerError(headers: {'Content-Type': 'application/json'}, body: jsonEncode(error));
      }
    }

  Router get router => _$HomeworkControllerRouter(this);
}