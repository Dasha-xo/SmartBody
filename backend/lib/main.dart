import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_auth/shelf_auth.dart';
import 'package:jwt_auth/jwt_auth.dart' as jwt;
import 'package:mongo_dart/mongo_dart.dart';

final _jwtSecret = 'your-secret-key-here';

void main() async {
  final db = await Db.create('mongodb://localhost:27017/inbody_app');
  await db.open();
  
  final app = Router();
  
  // Аутентификация
  final jwtAuth = jwt.JwtAuth(_jwtSecret);
  
  app.post('/login', (Request req) async {
    // Проверка учетных данных и выдача токена
    return Response.ok('token');
  });
  
  app.post('/register', (Request req) async {
    // Регистрация нового пользователя
    return Response.ok('user created');
  });
  
  // Защищенные маршруты
  app.get('/analysis', (Request req) {
    if (!jwtAuth.validateRequest(req)) {
      return Response.unauthorized('Invalid token');
    }
    return Response.ok('Analysis data');
  });
  
  // Запуск сервера
  final server = await io.serve(app, '0.0.0.0', 8080);
  print('Server running on ${server.address}:${server.port}');
}
