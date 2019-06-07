import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/index.dart';
import 'index.dart';

class MasterDetailView extends StatelessWidget {
  MasterDetailView({
    @required List<Widget> children,
    @required this.detailsBuilder,
    @required this.onSelected,
    @required this.selectedIndex,
    this.itemNotSelected,
    this.itemsEmpty,
    this.itemsNull,
  }) : _delegate = SliverChildListDelegate(
          children,
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          addSemanticIndexes: false,
        );

  MasterDetailView.builder({
    @required IndexedWidgetBuilder itemBuilder,
    @required int itemCount,
    @required this.detailsBuilder,
    @required this.onSelected,
    this.itemNotSelected,
    this.itemsEmpty,
    this.itemsNull,
    this.selectedIndex,
  }) : _delegate = SliverChildBuilderDelegate(
          itemBuilder,
          childCount: itemCount,
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          addSemanticIndexes: false,
        );

  final Widget itemNotSelected, itemsEmpty, itemsNull;
  final ValueChanged<int> onSelected;
  final selectedIndex;
  final SliverChildDelegate _delegate;
  final Widget Function(BuildContext, int, bool) detailsBuilder;

  Widget _buildListView(ValueChanged<int> selected, bool tablet) {
    final _length = _delegate.estimatedChildCount;

    if (_length == null) {
      return Center(
        child: itemsNull ?? Container(),
      );
    }
    if (_length == 0) {
      return Center(
        child: itemsEmpty ?? Container(),
      );
    }
    return ListView.separated(
      itemCount: _length,
      shrinkWrap: true,
      separatorBuilder: (context, position) {
        return Divider();
      },
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      addSemanticIndexes: false,
      itemBuilder: (context, position) {
        return GestureDetector(
          onTap: () => selected(position),
          child: _delegate.build(context, position),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _length = _delegate.estimatedChildCount;
    return LayoutBuilder(
      builder: (context, dimens) {
        if (MediaQuery.of(context).orientation == Orientation.landscape &&
            dimens.maxWidth >= Dimens.tablet_breakpoint) {
          return Row(
            children: <Widget>[
              Container(
                width: Dimens.tablet_list_width,
                child: Builder(
                  builder: (context) {
                    if (_length == null) {
                      return CustomProgressIndicatorWidget();
                    }
                    return Material(child: _buildListView(onSelected, true));
                  },
                ),
              ),
              Expanded(
                child: _length == null || selectedIndex == null
                    ? (itemNotSelected ?? Container())
                    : detailsBuilder(context, selectedIndex, true),
              ),
            ],
          );
        }
        return Builder(
          builder: (context) {
            if (_length == null) {
              return CustomProgressIndicatorWidget();
            }
            return Material(
                child: _buildListView(
              (val) {
                onSelected(val);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => detailsBuilder(context, val, false),
                  ),
                );
              },
              false,
            ));
          },
        );
      },
    );
  }
}
