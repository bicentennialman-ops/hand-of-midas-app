class AppState {
  bool isLogined;
  String token;
  int walletId;

  AppState(this.isLogined, this.token, this.walletId);

  AppState.fromAppState(AppState prevState) {
    isLogined = prevState.isLogined;
    token = prevState.token;
    walletId = prevState.walletId;
  }
}
