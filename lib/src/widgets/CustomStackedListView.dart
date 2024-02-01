import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

typedef StackedItemOnRemove = void Function(int index, AxisDirection direction);
typedef StackedItemBeforeRemove = Future<bool> Function(
  int index,
  AxisDirection direction,
);

class CustomStackedListView extends StatefulWidget {
  final Axis scrollDirection;
  final bool reverse;
  final IndexedWidgetBuilder builder;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final Duration animateDuration;
  final int itemCount;
  final double itemExtent;
  final double fadeOutFrom;
  final double heightFactor;
  final double widthFactor;
  final StackedItemOnRemove? onRemove;
  final StackedItemBeforeRemove? beforeRemove;

  const CustomStackedListView({
    Key? key,
    required this.itemCount,
    required this.builder,
    this.reverse = false,
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.controller,
    this.physics,
    required this.itemExtent,
    this.fadeOutFrom = 0.7,
    this.heightFactor = 1,
    this.widthFactor = 1,
    this.onRemove,
    this.beforeRemove,
    this.animateDuration = kThemeAnimationDuration,
  }) : super(key: key);

  @override
  _CustomStackedListViewState createState() => _CustomStackedListViewState();
}

class _CustomStackedListViewState extends State<CustomStackedListView> {
  late final ScrollController controller;
  int? selectedIndex;

  @override
  void initState() {
    controller = widget.controller ?? ScrollController();
    controller.addListener(_update);
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        selectedIndex = null;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(_update);
    super.dispose();
  }

  void _update() {
    setState(() {});
  }

  void _onItemTap(int index) {
    // _scrollToIndex(index);
    HapticFeedback.mediumImpact();
    (selectedIndex == index)
        ? setState(() {
            selectedIndex = null;
          })
        : setState(() {
            selectedIndex = index;
          });
  }

  void _scrollToIndex(int index) {
    final realExtent = widget.itemExtent *
        (widget.scrollDirection == Axis.horizontal
            ? widget.widthFactor
            : widget.heightFactor);
    controller.animateTo(
      index * realExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final realExtent = widget.itemExtent *
        (widget.scrollDirection == Axis.horizontal
            ? widget.widthFactor
            : widget.heightFactor);
    return Stack(children: [
      AnimationLimiter(
        child: ListView.builder(
          scrollDirection: widget.scrollDirection,
          padding: widget.padding,
          controller: controller,
          itemCount: widget.itemCount,
          physics: widget.physics ?? BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            double scroll =
                ((controller.offset - index * realExtent) / realExtent);
            double currentScroll = scroll.clamp(0.0, 1.0);

            double opacity = 1.0;
            double offset = 0;
            bool atFirst = false;

            if (currentScroll > 0 || (index == 0 && controller.offset <= 0)) {
              if (currentScroll < 1) {
                atFirst = true;
              }

              if (currentScroll >= widget.fadeOutFrom) {
                final fadeOut =
                    ((1 - currentScroll) / (1.0 - widget.fadeOutFrom))
                        .clamp(0.0, 1.0);
                opacity = lerpDouble(0.0, 1.0, fadeOut)!;
              }

              offset = (currentScroll * realExtent).roundToDouble();
            }
            opacity = opacity.clamp(0.0, 1.0);
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: AnimatedItem(
                    key: UniqueKey(),
                    atFirst: atFirst,
                    heightFactor:
                        index == selectedIndex ? 1.0 : widget.heightFactor,
                    lastOne: index == (widget.itemCount - 1),
                    isClicked: (index == selectedIndex) ? true : false,
                    index: index,
                    offset: offset,
                    opacity: opacity,
                    widthFactor: widget.widthFactor,
                    onRemove: widget.onRemove,
                    beforeRemove: widget.beforeRemove,
                    animateDuration: widget.animateDuration,
                    child: GestureDetector(
                      onLongPress: () => _onItemTap(index),
                      child: SizedBox(
                        width: widget.scrollDirection == Axis.vertical
                            ? double.infinity
                            : widget.itemExtent,
                        height: widget.scrollDirection == Axis.vertical
                            ? widget.itemExtent
                            : double.infinity,
                        child: widget.builder(context, index),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ]);
  }
}

class AnimatedItem extends StatefulWidget {
  final int index;
  final bool atFirst, lastOne;
  final double opacity;
  final bool isClicked;
  final double offset;
  final double widthFactor, heightFactor;
  final Widget child;
  final StackedItemOnRemove? onRemove;
  final StackedItemBeforeRemove? beforeRemove;
  final Duration animateDuration;

  const AnimatedItem({
    Key? key,
    required this.atFirst,
    required this.lastOne,
    required this.isClicked,
    required this.index,
    required this.offset,
    required this.opacity,
    required this.widthFactor,
    required this.heightFactor,
    required this.child,
    required this.animateDuration,
    this.onRemove,
    this.beforeRemove,
  }) : super(key: key);

  @override
  _AnimatedItemState createState() => _AnimatedItemState();
}

class _AnimatedItemState extends State<AnimatedItem>
    with TickerProviderStateMixin {
  late final AnimationController animationController;
  late final bool deletable;
  double _dragOffsetX = 0;
  double _dragOffsetY = 0;
  bool confirmDelete = false;
  late AxisDirection _direction;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: widget.animateDuration,
      vsync: this,
    );
    deletable = widget.onRemove != null;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Matrix4 transform = Matrix4.identity();
    transform.translate(_dragOffsetX,
        _dragOffsetY); // Directly use the drag offsets without adding widget.offset

    Widget child = Transform(
      alignment: Alignment.topCenter,
      transform: transform,
      child: Opacity(
        opacity: widget.opacity,
        child: Align(
          alignment: Alignment.topCenter,
          widthFactor: widget.lastOne ? 1.0 : widget.widthFactor,
          heightFactor: widget.lastOne ? 1.0 : widget.heightFactor,
          child: widget.child,
        ),
      ),
    );

    if (deletable) {
      child = GestureDetector(
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        child: child,
      );
    }
    return Padding(
      padding: EdgeInsets.only(bottom: widget.isClicked ? 30 : 0),
      child: child,
    );
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffsetX += details.delta.dx;
      _dragOffsetY += details.delta.dy;
    });
  }

  void _onPanEnd(DragEndDetails details) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _animateToOffset(0.0, 0.0);
  }

  void _animateToOffset(double endX, double endY) {
    animationController.reset();

    const curve = Curves.easeIn;

    final animationX = Tween<double>(begin: _dragOffsetX, end: endX).animate(
      CurvedAnimation(parent: animationController, curve: curve),
    );

    final animationY = Tween<double>(begin: _dragOffsetY, end: endY).animate(
      CurvedAnimation(parent: animationController, curve: curve),
    );

    animationX.addListener(() {
      setState(() {
        _dragOffsetX = animationX.value;
      });
    });

    animationY.addListener(() {
      setState(() {
        _dragOffsetY = animationY.value;
      });
    });

    animationController.forward();
  }
}
