import 'dart:ui';

import 'package:flutter/material.dart';
import '../../bloc/bloc.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool showIconSearch;
  final double marginSubtitle;
  final double elevationAppBar;
  final String hintTextSearch;
  final Widget title;
  final String subtitle;
  final Widget subtitleWidget;
  final double heightBottomBar;
  final Widget leadingAppbarIconButton;
  final Widget suffixAppBarIconButton;
  final bool automaticallyImplyLeading;
  final bool showAppBar;
  final Function(String) onListener;

  AppBarWidget({
    @required this.title,
    this.marginSubtitle,
    this.elevationAppBar: 0,
    this.subtitle,
    this.subtitleWidget,
    this.heightBottomBar,
    this.hintTextSearch,
    this.leadingAppbarIconButton,
    this.suffixAppBarIconButton,
    this.showIconSearch: false,
    this.automaticallyImplyLeading: true,
    this.showAppBar: true,
    this.onListener,
  })  : assert(title != null),
        assert(marginSubtitle == null || marginSubtitle >= 0),
        assert(showIconSearch == false || onListener != null);

  @override
  Widget build(BuildContext context) {
    return Provider<_AppBarCustomBloc>(
      create: (_) {
        return _AppBarCustomBloc(onListener);
      },
      dispose: (_, value) {
        value?.dispose();
      },
      child: Consumer<_AppBarCustomBloc>(
        builder: (_, bloc, __) {
          return _buildContent(context, bloc);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, _AppBarCustomBloc bloc) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: showIconSearch ? StreamBuilder<bool>(
        stream: bloc.streamCallSearchAppBar,
        initialData: false,
        builder: (context, snapAppBar) {
          return !snapAppBar.hasData || !snapAppBar.data ? _buildAppBarDefault(context, bloc) : _buildAppBarSearch(context, bloc);
        },
      ) : _buildAppBarDefault(context, bloc),
    );
  }

  Widget _buildAppBarDefault(BuildContext context, _AppBarCustomBloc bloc) {
    return showAppBar ? 
      AppBar(
        leading: leadingAppbarIconButton,
        automaticallyImplyLeading: automaticallyImplyLeading,
        elevation: elevationAppBar,
        bottom: _bottomAppBar(context),
        title: title,
        actions: <Widget>[
          _buildIconSearch(bloc),
          _buildSuffixIcon(),
        ],
      ) : PreferredSize(child: SizedBox.shrink(), preferredSize: const Size.fromHeight(0));
  }

  Widget _buildAppBarSearch(BuildContext context, _AppBarCustomBloc bloc) {
    return showAppBar ? 
      AppBar(
        elevation: elevationAppBar,
        leading: _buildCloseSearch(context, bloc),
        bottom: _bottomAppBar(context),
        title: TextField(
          autofocus: true,
          style: TextStyle(
            color: Theme.of(context).textTheme.caption.color,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
            hintText: hintTextSearch,
            hintStyle: TextStyle(
              color: Theme.of(context).disabledColor,
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
            filled: true,
            fillColor: Colors.blueGrey.shade50,
          ),
          onChanged: bloc.sinkPesquisa,
        ),
      ) : 
      PreferredSize(
        child: SizedBox.shrink(),
        preferredSize: const Size.fromHeight(0),
      );
  }

  Widget _bottomAppBar(BuildContext context) {
    const double height = kToolbarHeight;
    if (subtitleWidget != null) {
      return PreferredSize(
        preferredSize: preferredSize,
        child: Container(
          height: height,
          margin: EdgeInsets.only(left: marginSubtitle ?? 16, right: marginSubtitle ?? 16),
          alignment: Alignment.centerLeft,
          child: subtitleWidget,
        ),
      );
    } else if (subtitle != null && subtitle.isNotEmpty) {
      return PreferredSize(
        preferredSize: preferredSize,
        child: Container(
          height: height,
          margin: EdgeInsets.only(left: marginSubtitle ?? 16, right: marginSubtitle ?? 16),
          alignment: Alignment.centerLeft,
          child: Text(
            subtitle.toUpperCase(),
            style: TextStyle(
              color: Theme.of(context).textTheme.caption.color,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      );
    }
    return PreferredSize(
      child: SizedBox.shrink(),
      preferredSize: const Size.fromHeight(0),
    );
  }

  Widget _buildIconSearch(_AppBarCustomBloc bloc) {
    if (showIconSearch) {
      return IconButton(
        icon: Icon(
          Icons.search,
          size: 26,
        ),
        onPressed: () {
          bloc.sinkCallSearchAppBar(true);
        },
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildSuffixIcon() {
    if (suffixAppBarIconButton != null) {
      return Padding(
        padding: const EdgeInsets.only(right: 8), 
        child: suffixAppBarIconButton,
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildCloseSearch(BuildContext context, _AppBarCustomBloc bloc) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          bloc.sinkCallSearchAppBar(false);
          bloc.sinkPesquisa('');
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
  }

  @override
  Size get preferredSize {
    return subtitleWidget == null && subtitle == null ? const Size.fromHeight(kToolbarHeight) : const Size.fromHeight(kToolbarHeight * 2);
  }
}

class _AppBarCustomBloc implements Bloc {
  final Function(String) _onListener;

  BehaviorSubject<bool> _controllerCallSearchAppBar;
  Function(bool) get sinkCallSearchAppBar { return _controllerCallSearchAppBar.sink.add; }
  Stream<bool> get streamCallSearchAppBar { return _controllerCallSearchAppBar.stream; }

  BehaviorSubject<String> _controllerPesquisa;
  Function(String) get sinkPesquisa { return _controllerPesquisa.sink.add; }
  Stream<String> get streamPesquisa { return _controllerPesquisa.stream; }

  _AppBarCustomBloc(this._onListener) {
    _controllerCallSearchAppBar = BehaviorSubject<bool>();
    _controllerPesquisa = BehaviorSubject<String>();
    _handlerListener();
  }

  void _handlerListener() {
    _controllerCallSearchAppBar.listen(_handlerCallSearch);
    _controllerPesquisa.listen(_handlerPesquisa);
  }

  void _handlerCallSearch(bool value) {
    if(value != null && !value){
      _onListener(null);
    }
  }

  void _handlerPesquisa(String value) {
    _onListener(value);
  }

  @override
  void dispose() async {
    await _controllerCallSearchAppBar?.close();
    await _controllerPesquisa?.close();
  }
}