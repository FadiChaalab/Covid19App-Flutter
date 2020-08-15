import 'package:flutter/material.dart';

class SidebarItem extends StatelessWidget {
  final bool isSelected;
  final String text;
  final Function onTap;

  const SidebarItem({Key key, this.isSelected, this.text, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -1.58,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.white : Colors.transparent,
              ),
            ),
            AnimatedDefaultTextStyle(
              child: Text(text),
              style: isSelected
                  ? TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )
                  : TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
              duration: Duration(milliseconds: 200),
            ),
          ],
        ),
      ),
    );
  }
}
