import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:my_toots/widgets/compose/compose_status.widget.dart';

class ComposeFabWidget extends StatelessWidget {
  const ComposeFabWidget({Key? key}) : super(key: key);
  final double _fabDimension = 56.0;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fade,
      openBuilder: (BuildContext context, VoidCallback _) {
        return const SafeArea(child: ComposeStatusWidget());
      },
      closedElevation: 6.0,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(_fabDimension / 2),
        ),
      ),
      closedColor: Theme.of(context).colorScheme.primary,
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return SizedBox(
          height: _fabDimension,
          width: _fabDimension,
          child: Center(
            child: Icon(
              Icons.edit,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        );
      },
    );
  }
}
