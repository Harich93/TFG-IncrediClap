import 'package:flutter/material.dart';
import 'package:incredibclap/themes/themes.dart';
import 'package:incredibclap/widgets/music/music_widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class MusicButton {

  final Function onPress;
  final IconData icon;
  final String text;

  MusicButton({
    required this.onPress, 
    required this.icon,
    required this.text
  });
}

class MusicMenu extends StatelessWidget {

  final bool hidden;
  const MusicMenu({Key? key,  this.hidden = false }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final List<MusicButton> items = [
      MusicButton(icon: Icons.radio_button_checked_rounded, text: "Grabar", onPress: () => {}),
      MusicButton(icon: Icons.music_note, text: "Partitura",onPress: () => showMaterialModalBottomSheet(
        context: context,
        builder: (context) => const MusicSheets(),
      )),
    ];

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
      padding: const EdgeInsets.symmetric( vertical: 5),
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: ThemeColors.transparent
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
      child: Column(
        children: [
          Icon( 
            item.icon, 
            size: model.selectedIndex == index ? 25 : 25 , 
            color: model.selectedIndex == index ? Colors.pink : Colors.black54 
          ),
          Text(item.text)
        ],
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