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

// SearchWidget

class TextSearchData {
  int dataId = -1;
  String type = '';
  String key = '';
  String title = '';
  TextSearchData(this.title);
  TextSearchData.keyTitle(this.key, this.title);
  TextSearchData.all(this.dataId, this.type, this.key, this.title);
}

class TextSearchDelegate extends SearchDelegate<List<TextSearchData>> {
  final List<TextSearchData> searchData;
  final List<TextSearchData> historyData = List();
  final List<TextSearchData> selectedData = List();

  TextSearchDelegate(this.searchData);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isNotEmpty
          ? IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
          : Container()
    ];
  }

  void updateSelectedData(List<TextSearchData> selected) {
    selectedData.clear();
    selectedData.addAll(selected);
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        //Take control back to previous page
        this.close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchResultWidget(
        selectedData: selectedData,
        onComplete: () {
          close(context, selectedData);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchSuggestionWidget(
      query: this.query,
      suggestions: _makeSuggestions(),
      onSelected: (TextSearchData suggestion) {
        this.query = suggestion.title;
        _updateData(suggestion);
        showResults(context);
        //buildResults(context);
      },
    );
  }

  void _updateData(TextSearchData suggestion) {
    _updateHistory(suggestion);
    _updateSelected(suggestion);
  }

  void _updateHistory(TextSearchData suggestion) {
    if (historyData
        .where((element) => element.dataId == suggestion.dataId)
        .toList()
        .isEmpty) {
      historyData.add(suggestion);
    }
  }

  void _updateSelected(TextSearchData suggestion) {
    if (selectedData
        .where((element) => element.dataId == suggestion.dataId)
        .toList()
        .isEmpty) {
      selectedData.add(suggestion);
    }
  }

  List<TextSearchData> _makeSuggestions() {
    //add logic to search on each char.
    return query.isEmpty
        ? historyData
        : searchData
            .where((element) =>
                element.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
  }
}

class SearchResultWidget extends StatefulWidget {
  final List<TextSearchData> selectedData;
  final VoidCallback onComplete;

  const SearchResultWidget({this.selectedData, this.onComplete});

  @override
  _SearchResultWidgetState createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget> {
  @override
  Widget build(BuildContext context) {
    List<Widget> chips = List();
    widget.selectedData?.forEach((d) {
      chips.add(Chip(
        label: Text('${d.title}'),
        onDeleted: () => {_removeSelectedData(d)},
      ));
    });
    if (chips.isEmpty) {
      chips.add(Container());
    } else {
      chips.add(IconButton(
        icon: const Icon(Icons.done_all),
        onPressed: () {
          //close(context, this.query);
          widget.onComplete();
        },
      ));
    }

    return Wrap(
      children: chips,
    );
  }

  void _removeSelectedData(TextSearchData suggestion) {
    setState(() {
      widget.selectedData
          .removeWhere((element) => element.title == suggestion.title);
    });
  }
}

class SearchSuggestionWidget extends StatelessWidget {
  const SearchSuggestionWidget({this.suggestions, this.query, this.onSelected});

  final List<TextSearchData> suggestions;

  final String query;
  final ValueChanged<TextSearchData> onSelected;

  @override
  Widget build(BuildContext context) {
    return suggestions.isEmpty
        ? Container()
        : ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (BuildContext context, int i) {
              final TextSearchData suggestion = suggestions[i];
              return ListTile(
                leading: query.isEmpty ? Icon(Icons.history) : Icon(null),
                title: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: suggestion.title,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  onSelected(suggestion);
                },
              );
            },
          );
  }
}
