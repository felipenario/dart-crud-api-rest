import 'dart:async';

import 'package:dart_rest_api/controllers/homework_controller.dart';
import 'package:functions_framework/functions_framework.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

@CloudFunction()
FutureOr<Response> function(Request request) async {
  final router = Router();
  final db = Db('mongodb://127.0.0.1:27017/api-teste');
  await db.open();
  print(db.state == State.OPEN ? 'MongoDB conectado!' : 'Deu algo errado!');

  //router.mount('/user/', UserController(db.collection('user')).router);
  router.mount('/homework/', HomeworkController(db.collection('homework')).router);

  return router(request);
}
