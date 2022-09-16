import 'package:mobx/mobx.dart';

part "appdata.g.dart";


class AppData=_AppData with _$AppData;

abstract class _AppData with Store{
  @observable
  var data;
}

