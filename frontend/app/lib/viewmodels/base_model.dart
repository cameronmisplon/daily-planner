import 'package:flutter/material.dart';

class BaseModel extends ChangeNotifier {
  bool _busy = false;
  bool _dirty = false;

  bool get busy => _busy;

  bool get dirty => _dirty;

  void reset() {
    _busy = false;
    _dirty = false;
  }

  void setBusy(bool busy) {
    _busy = busy;
    notifyListeners();
  }

  void setDirty(bool dirty) {
    _dirty = dirty;
  }
}