import 'package:flutter/material.dart';
import '../widget/geral/progress_indicator_widget.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  SplashScreen({
    @required this.onInitializationComplete,
  }) : assert(onInitializationComplete != null);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Splash Screen',),
            ProgressIndicatorWidget(),
          ],
        ),
      ),
    );
  }

  void _afterLayout(Duration duration) {
    try {
      Future.delayed(Duration(milliseconds: 1500), _processar);
    } catch(e) {
      print(e);
    }
  }

  void _processar() {
    /// Adicione aqui seu processamento, ao concluir chamar onInitializationComplete
    widget.onInitializationComplete();
  }
}