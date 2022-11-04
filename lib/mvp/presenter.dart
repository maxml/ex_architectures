import 'package:ex_architectures/mvp/model.dart';
import 'package:ex_architectures/mvp/utils.dart';
import 'package:ex_architectures/mvp/view.dart';

/// Source: https://github.com/liemvo/Flutter_bmi
class IPresenter {
  void onCalculateClicked(String weightString, String heightString) {}
  void onOptionChanged(int value, {String? weightString, String? heightString}) {}
  set bmiView(IView value) {}

  void onAgeSubmitted(String age) {}
  void onHeightSubmitted(String height) {}
  void onWeightSubmitted(String weight) {}
}

class BasicBMIPresenter implements IPresenter {
  late ExModel _model;
  late IView _view;

  BasicBMIPresenter() {
    this._model = ExModel();
    _loadUnit();
  }

  void _loadUnit() async {
    _model.value = await loadValue();
    _view.updateUnit(_model.value, _model.heightMessage, _model.weightMessage);
  }

  @override
  set bmiView(IView value) {
    _view = value;
    _view.updateUnit(_model.value, _model.heightMessage, _model.weightMessage);
  }

  @override
  void onCalculateClicked(String weightString, String heightString) {
    var height = 0.0;
    var weight = 0.0;
    try {
      height = double.parse(heightString);
    } catch (e) {}
    try {
      weight = double.parse(weightString);
    } catch (e) {}
    _model.height = height;
    _model.weight = weight;
    _model.bmi = calculator(height, weight, _model.unitType);
    _view.updateBmiValue(_model.bmiInString, _model.bmiMessage);
  }

  @override
  void onOptionChanged(int value, {String? weightString, String? heightString}) {
    final weightScale = 2.2046226218;
    final heightScale = 2.54;

    if (value != _model.value) {
      _model.value = value;
      saveValue(_model.value);
      var height;
      var weight;
      if (!isEmptyString(heightString!)) {
        try {
          height = double.parse(heightString);
        } catch (e) {}
      }
      if (!isEmptyString(weightString!)) {
        try {
          weight = double.parse(weightString);
        } catch (e) {}
      }

      if (_model.unitType == UnitType.FeetPound) {
        if (weight != null) _model.weight = weight * weightScale;
        if (height != null) _model.height = height / heightScale;
      } else {
        if (weight != null) _model.weight = weight / weightScale;
        if (height != null) _model.height = height * heightScale;
      }

      _view.updateUnit(_model.value, _model.heightMessage, _model.weightMessage);
      _view.updateHeight(height: _model.heightInString);
      _view.updateWeight(weight: _model.weightInString);
    }
  }

  @override
  void onAgeSubmitted(String age) {
    // TODO: will implement late
  }

  @override
  void onHeightSubmitted(String height) {
    try {
      _model.height = double.parse(height);
    } catch (e) {}
  }

  @override
  void onWeightSubmitted(String weight) {
    try {
      _model.weight = double.parse(weight);
    } catch (e) {}
  }
}
