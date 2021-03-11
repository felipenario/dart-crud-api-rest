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
      var body = jsonDecode(await request.readAsString());
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

  Router get router => _$HomeworkControllerRouter(this);
}