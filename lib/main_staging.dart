import 'package:login_demo/app/app.dart';
import 'package:login_demo/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
