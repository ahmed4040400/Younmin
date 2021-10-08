import 'package:auto_route/annotations.dart';
import 'package:younmin/presentation/home/home.dart';

@AdaptiveAutoRouter(routes: <AutoRoute>[
  AutoRoute(path: "/", page: Home, initial: true),
])
class $YounminRouter {}
