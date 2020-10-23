import 'package:flutter/material.dart';



class MultiSelectData {
  Map<String, String> dataMap = Map();
  List<String> selectedIds = List();
  String title = '';
}



class MultiSelectWidget extends StatefulWidget {
  final MultiSelectData widgetData;

  MultiSelectWidget({Key key, this.widgetData}) : super(key: key);

  @override
  _MultiSelectWidgetState createState() => _MultiSelectWidgetState();
}

class _MultiSelectWidgetState extends State<MultiSelectWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.widgetData.title),
      ),
      body: ListView(
        children: _buildTiles(context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, widget.widgetData.selectedIds);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  List<Widget> _buildTiles(BuildContext context) {
    List<Widget> tiles = List();
    widget.widgetData.dataMap?.forEach((k, v) {
      tiles.add(CheckboxListTile(
          title: Text(v),
          value: widget.widgetData.selectedIds.contains(k),
          onChanged: (isSelected) {
            setState(() {
              isSelected
                  ? widget.widgetData.selectedIds.add(k)
                  : widget.widgetData.selectedIds.remove(k);
            });
          }));
    });
    return tiles;
  }
}



class ClosableChipWidget extends StatefulWidget {
  final MultiSelectData widgetData;

  ClosableChipWidget({Key key, this.widgetData}) : super(key: key);

  @override
  _ClosableChipWidgetState createState() => _ClosableChipWidgetState();
  void updateFilterData(BuildContext context) {}
}

class _ClosableChipWidgetState extends State<ClosableChipWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildChips(context),
    );
  }

  Widget _buildChips(BuildContext context) {
    List<Widget> chips = List();
    widget.widgetData.dataMap?.forEach((k, v) {
      chips.add(
        Chip(
          label: Text(v),
          onDeleted: () {
            setState(() {
              widget.widgetData.dataMap.removeWhere((key, value) => key == k);
              widget.updateFilterData(context);
            });
          },
        ),
      );
    });
    return new Wrap(
      children: chips,
      spacing: 2,
    );
  }
}