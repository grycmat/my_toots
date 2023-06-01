import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/services/api.service.dart';

class FavoriteButtonWidget extends StatefulWidget {
  const FavoriteButtonWidget({required this.status, Key? key})
      : super(key: key);
  final Status status;
  @override
  _FavoriteButtonWidgetState createState() => _FavoriteButtonWidgetState();
}

class _FavoriteButtonWidgetState extends State<FavoriteButtonWidget> {
  late bool _isFavorited;
  @override
  void initState() {
    _isFavorited = widget.status.favourited ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            onPressed: () async {
              final service = getIt.get<ApiService>();
              await service.toggleFavorite(
                  status: widget.status, favorite: !_isFavorited);
              setState(() {
                _isFavorited = !_isFavorited;
              });
            },
            icon: _isFavorited
                ? const Icon(
                    Icons.favorite_outlined,
                    color: Colors.red,
                  )
                : const Icon(Icons.favorite_outline_outlined)),
        Text(
          widget.status.favouritesCount.toString(),
        ),
      ],
    );
  }
}
