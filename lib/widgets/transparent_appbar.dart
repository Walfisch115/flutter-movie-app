import 'package:flutter/material.dart';
import 'package:movie_app/style/my_colors.dart';

class TransparentAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TransparentAppBar({
    super.key,
    required this.scrollController,
    required this.title,
    required this.screenWidth,
    this.actions,
  });

  final ScrollController scrollController;
  final String title;
  final double screenWidth;
  final List<Widget>? actions;

  @override
  State<TransparentAppBar> createState() => _TransparentAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TransparentAppBarState extends State<TransparentAppBar> {
  late Color? _appBarColor;
  bool _isTransitionComplete = false;

  @override
  void initState() {
    super.initState();
    _appBarColor = Colors.transparent;

    widget.scrollController.addListener(() {
      double offset = widget.scrollController.offset;
      double maxOffset = widget.screenWidth / 2;

      // calculate the scroll ratio
      double scrollRatio = (offset / maxOffset).clamp(0.0, 1.0);

      // calculate the background color based on the scroll ratio
      Color? backgroundColor = Color.lerp(Colors.transparent, const Color(0xFF1F1D2B), scrollRatio);

      setState(() {
        _appBarColor = backgroundColor;

        // check if the transition is complete
        _isTransitionComplete = scrollRatio >= 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_rounded),
      ),
      actions: widget.actions,
      foregroundColor: const Color(0xFFF1F1F5),
      backgroundColor: _appBarColor,
      elevation: 0, // no shadow
      shadowColor: _isTransitionComplete
          ? MyColors.darkBluishGrey
          : Colors.transparent, // not shown cause elevation is 0
      surfaceTintColor: Colors.transparent,
      title: _isTransitionComplete ? Text(widget.title) : null,
      centerTitle: true,
      // shape: Border(
      //   bottom: BorderSide(
      //     color: _isTransitionComplete ? MyColors.darkerWhite : Colors.transparent,
      //     width: 0.5,
      //   ),
      // ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
