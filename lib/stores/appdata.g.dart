// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appdata.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppData on _AppData, Store {
  late final _$dataAtom = Atom(name: '_AppData.data', context: context);

  @override
  dynamic get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(dynamic value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  late final _$latAtom = Atom(name: '_AppData.lat', context: context);

  @override
  dynamic get lat {
    _$latAtom.reportRead();
    return super.lat;
  }

  @override
  set lat(dynamic value) {
    _$latAtom.reportWrite(value, super.lat, () {
      super.lat = value;
    });
  }

  late final _$lonAtom = Atom(name: '_AppData.lon', context: context);

  @override
  dynamic get lon {
    _$lonAtom.reportRead();
    return super.lon;
  }

  @override
  set lon(dynamic value) {
    _$lonAtom.reportWrite(value, super.lon, () {
      super.lon = value;
    });
  }

  @override
  String toString() {
    return '''
data: ${data},
lat: ${lat},
lon: ${lon}
    ''';
  }
}
