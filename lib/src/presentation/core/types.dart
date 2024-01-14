import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef RoutePage = Widget Function(BuildContext, GoRouterState);
typedef QueryParams = Map<String, dynamic>?;
