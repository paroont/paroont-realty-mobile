import 'package:flutter/material.dart';
import 'package:paroont_realty_mobile/model/common.dart';

class MultiSelectWidget extends StatefulWidget {
  final MultiSelectData widgetData;
  final bool textBasedSearch = true;

  MultiSelectWidget({Key key, this.widgetData}) : super(key: key);

  @override
  _MultiSelectWidgetState createState() => _MultiSelectWidgetState();
}

class _MultiSelectWidgetState extends State<MultiSelectWidget> {
  TextEditingController searchTextController = new TextEditingController();
  Map<int, TextSearchData> filteredData = Map();
  @override
  void initState() {
    super.initState();
    filteredData.addAll(widget.widgetData.dataMap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.widgetData.title),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, widget.widgetData.selectedIds);
        },
        child: Icon(Icons.done_outline),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    List<Widget> widgets = List();
    if (widget.textBasedSearch) {
      widgets.add(TextField(
        onChanged: (value) {
          //searchQuery = value;
          filterSearchResults();
        },
        controller: searchTextController,
        decoration: InputDecoration(
          hintText: "Search",
          prefixIcon: Icon(Icons.search),
          suffix: searchTextController.text.isNotEmpty
              ? IconButton(
                  tooltip: 'Clear',
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    //searchQuery = '';
                    
                    searchTextController.clear();
                    filterSearchResults();
                  },
                )
              : null,
        ),
      ));
    }
    widgets.add(Expanded(
        child: ListView(
      children: _buildTiles(context),
    )));
    return Container(child: Column(children: widgets));
  }

  void filterSearchResults() {
    setState(() {
      filteredData.clear();
      if (searchTextController.text.isNotEmpty) {
        widget.widgetData.dataMap.forEach((key, value) {
          if (value.value.toLowerCase().contains(searchTextController.text.toLowerCase())) {
            filteredData[key] = value;
          }
        });
      } else {
        filteredData.addAll(widget.widgetData.dataMap);
      }
    });
  }

  List<Widget> _buildTiles(BuildContext context) {
    List<Widget> tiles = List();
    filteredData?.forEach((k, v) {
      tiles.add(CheckboxListTile(
          title:
              Text(null != v.title && v.title.isNotEmpty ? v.title : v.value),
          subtitle: Text(
              null != v.subTitle && v.subTitle.isNotEmpty ? v.subTitle : ''),
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
          label:
              Text(null != v.title && v.title.isNotEmpty ? v.title : v.value),
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
