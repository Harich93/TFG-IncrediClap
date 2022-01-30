import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MusicButton {

  final Function onPress;
  final IconData icon;

  MusicButton({
    required this.onPress, 
    required this.icon
  });
}

class MusicMenu extends StatelessWidget {

  final bool hidden;

  final List<MusicButton> items = [
    MusicButton(icon: Icons.pie_chart, onPress: () => {} ),
    MusicButton(icon: Icons.search, onPress: () => {} ),
    MusicButton(icon: Icons.notifications, onPress: () => {} ),
    MusicButton(icon: Icons.supervised_user_circle, onPress: () => {} ),
  ];

  MusicMenu({Key? key,  this.hidden = false }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ( _ ) => _MenuModel(),
      child: _MusicMenuBackground( 
        child: _MenuItems( items )
      ),
    );
  }
}

class _MusicMenuBackground extends StatelessWidget {
  
  final Widget child;

  const _MusicMenuBackground({ required this.child });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: -5,
          )
        ],
        color: Colors.white
      ),
      child: child,
    );
  }
}

class _MenuItems extends StatelessWidget {
  
  final List<MusicButton> menuItems;

  const _MenuItems( this.menuItems );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(menuItems.length, ( i ) => _MusicMenuButton( i, menuItems[i] ) ),
    );
  }
}

class _MusicMenuButton extends StatelessWidget{

  final int index;
  final MusicButton item;

  const _MusicMenuButton( this.index, this.item );
  
  @override
  Widget build(BuildContext context) {

    final model = Provider.of<_MenuModel>(context);

    return GestureDetector(
      child: Icon( 
        item.icon, 
        size: model.selectedIndex == index ? 30 : 25 , 
        color: model.selectedIndex == index ? Colors.pink : Colors.black54 
      ),
      behavior: HitTestBehavior.translucent,
      onTap: () => {  
        model.selectedIndex = index,
        item.onPress()
      },
    );
  }
}

class _MenuModel with ChangeNotifier{

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;
  set selectedIndex( int value ) {
    _selectedIndex = value;
    notifyListeners();
  }

}