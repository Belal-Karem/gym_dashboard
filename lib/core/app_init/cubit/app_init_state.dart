abstract class AppInitState {}

class AppInitLoading extends AppInitState {}

class AppInitReady extends AppInitState {}

class AppInitError extends AppInitState {
  final String message;
  AppInitError(this.message);
}
