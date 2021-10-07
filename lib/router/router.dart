import 'package:auto_route/annotations.dart';
import 'package:younmin/presentation/home/home.dart';

@AdaptiveAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: Home, initial: true),
])
class $YounminRouter {}
