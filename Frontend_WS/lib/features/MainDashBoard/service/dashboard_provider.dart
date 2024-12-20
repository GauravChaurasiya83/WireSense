import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/dashboard_model.dart';
import 'dashboard_service.dart';

// WebSocket service provider
final webSocketServiceProvider = Provider<WebSocketService>((ref) {
  final service = WebSocketService('ws://localhost:8765');
  ref.onDispose(() => service.close());
  return service;
});

// StreamProvider for user data
final userDataProvider = StreamProvider<UserData>((ref) {
  final service = ref.watch(webSocketServiceProvider);
  return service.userDataStream;
});

// Individual field providers (optional)
final userNameProvider = Provider<String?>((ref) {
  final userData = ref.watch(userDataProvider).valueOrNull;
  return userData?.name;
});

final userAgeProvider = Provider<int?>((ref) {
  final userData = ref.watch(userDataProvider).valueOrNull;
  return userData?.age;
});

final userMessageProvider = Provider<String?>((ref) {
  final userData = ref.watch(userDataProvider).valueOrNull;
  return userData?.message;
});
