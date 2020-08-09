import 'package:flutter/material.dart';
import '../enum/enum_theme.dart';
import '../library/shared_preferences_helper.dart';
import '../library/theme_helper.dart';
import '../bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

const _keyTheme = 'key_thema_user';

class ApplicationBloc implements Bloc {
  PageController get pageController { return _pageController; }
  PageController _pageController;

  BehaviorSubject<int> _controllerBottomNavigatorBar;
  Function(int) get sinkBottomNavigatorBar { return _controllerBottomNavigatorBar.sink.add; }
  Stream<int> get streamBottomNavigatorBar { return _controllerBottomNavigatorBar.stream; }

  BehaviorSubject<int> _controllerTheme;
  Function(int) get _sinkTheme { return _controllerTheme.sink.add; }
  Stream<int> get streamTheme { return _controllerTheme.stream; }

  ApplicationBloc() {
    _pageController = PageController(initialPage: 0);
    _controllerBottomNavigatorBar = BehaviorSubject<int>();
    _controllerTheme = BehaviorSubject<int>.seeded(ThemeEnum.claro.index);
    _controllerBottomNavigatorBar.listen(_handlerNavigatorBar);
    _loadTheme().then(attTheme);
  }

  void _handlerNavigatorBar(int value) {
    if (value != null) {
      _pageController?.jumpToPage(value);
    }
  }

  /// Rotina do Theme
  ThemeData getThemeData(int codTheme) {
    try {
      if (codTheme != null && codTheme == ThemeEnum.escuro.index){
        return ThemeHelper.instance.dark;
      }
    } catch(e){}
    return ThemeHelper.instance.classic;
  }

  void attTheme(int codTheme){
    if (codTheme != null){
      _sinkTheme(codTheme);
    }
  }

  Future<int> _loadTheme() async {
    try {
      final str = await SharedPreferencesHelper.instance.loadData(_keyTheme);
      if (str != null && str.isNotEmpty) {
        return int.parse(str);
      }
    } catch(e){}
    return null;
  }

  @override
  void dispose() async {
    await _controllerBottomNavigatorBar?.close();
    await _controllerTheme?.close();
    _pageController?.dispose();
  }
}