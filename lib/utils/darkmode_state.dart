enum DarkmodeState {
  enable,
  disable;

  bool get isEnable => this == DarkmodeState.enable;
}

extension BoolExtension on bool {
  DarkmodeState get isEnable =>
      this == true ? DarkmodeState.enable : DarkmodeState.disable;
}