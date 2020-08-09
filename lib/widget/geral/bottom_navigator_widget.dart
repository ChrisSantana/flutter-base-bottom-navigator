import 'package:flutter/material.dart';
import '../../bloc/application_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BottomNavigatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBloc = Provider.of<ApplicationBloc>(context);
    return StreamBuilder<int>(
      stream: appBloc.streamBottomNavigatorBar,
      initialData: 0,
      builder: (context, snap){
        return BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 10,
          currentIndex: snap.hasData ? snap.data : 0,
          selectedItemColor: Theme.of(context).primaryColorDark,
          unselectedItemColor: Colors.blueGrey,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.home,
                size: 22,
              ),
              title: Padding(
                padding: EdgeInsets.only(top: 4, left: 4),
                child: Text(
                  'Home',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.infoCircle,
                size: 23,
              ),
              title: Padding(
                padding: EdgeInsets.only(top: 4, right: 2),
                child: Text(
                  'Sobre',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              backgroundColor: Colors.white,
            ),
          ],
          onTap: (index){
            _onTap(index, appBloc);
          },
        );
      },
    );
  }

  void _onTap(int index, ApplicationBloc appBloc){
    appBloc.sinkBottomNavigatorBar(index);
  }
}