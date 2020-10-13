import 'package:flutter/material.dart';
import 'package:paroont_realty_mobile/model/property.dart';
import 'package:paroont_realty_mobile/screen/property/search_result.dart';


class PropertySearchMainWidget extends InheritedWidget {

  const PropertySearchMainWidget({
    Key key,
    @required this.searchResultState,
    @required this.filter,
    @required Widget child,
  }) : assert(searchResultState != null),
       assert(filter != null),
      assert(child != null),
       super(key: key, child: child);

  final GlobalKey<PropertySearchResultScreenState> searchResultState;
  final PropertyFilter filter;

  static PropertySearchMainWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PropertySearchMainWidget>();
  }

  @override
  bool updateShouldNotify(PropertySearchMainWidget old) => searchResultState != old.searchResultState && filter != old.filter;
}


class PropertySearchForm extends StatefulWidget {
  @override
  _PropertySearchFormState createState() => _PropertySearchFormState();
}

class _PropertySearchFormState extends State<PropertySearchForm> {
  final _formKey = GlobalKey<FormState>();
  final _PropertySearchDelegate _searchDelegate = _PropertySearchDelegate();
  var searchTextController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: TextFormField(
                controller: searchTextController,
                decoration: InputDecoration(
                  hintText: 'Search property',
                  prefixIcon: Icon(Icons.search),
                ),
                readOnly: true,
                onTap: () {
                  showSearchPage(context, _searchDelegate);
                }),
          ),
          IconButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                // If the form is valid, display a Snackbar.
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Searching...')));
              }
            },
            iconSize: 45,
            icon: Icon(
              Icons.list,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  //Shows Search result
  void showSearchPage(
      BuildContext context, _PropertySearchDelegate searchDelegate) async {
    final String selected = await showSearch<String>(
      context: context,
      delegate: searchDelegate,
    );

    if (selected != null) {
      setState(() {
        searchTextController.text = selected;
        PropertySearchMainWidget.of(context).filter.searchQuery = selected;
         
        PropertySearchMainWidget.of(context).searchResultState.currentState.loadData();
      });
    }
  }
}

class _PropertySearchDelegate extends SearchDelegate<String> {
  final List<String> _suggestions = List();
  final List<String> _histories = List();

  _PropertySearchDelegate() {
    _suggestions.add('2 BHK in Thane');
    _suggestions.add('3 BHK in Mira Road');
    //_histories.add('2 BHK in Thane');
    //_histories.add('3 BHK in Mira Road');
  }
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
          : IconButton(
              icon: const Icon(Icons.mic),
              tooltip: 'Voice input',
              onPressed: () {
                this.query = 'TBW: Get input from voice';
              },
            ),
    ];
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
  Widget buildResults(BuildContext context) => null;

  void processResults(BuildContext context) {
    if (this.query.isNotEmpty) {
      _histories
          .removeWhere((e) => e.toUpperCase() == this.query.toUpperCase());
      _histories.insert(0, this.query);
    }

    this.close(context, this.query);
  }

  @override
  void showResults(BuildContext context) {
    processResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestions = this.query.isEmpty
        ? _histories
        : _suggestions
            .where((word) => word.toUpperCase().contains(query.toUpperCase()));
    return _PropertySuggestionWidget(
      query: this.query,
      suggestions: suggestions.toList(),
      onSelected: (String suggestion) {
        this.query = suggestion;
        showResults(context);
      },
    );
  }
}

class _PropertySuggestionWidget extends StatelessWidget {
  const _PropertySuggestionWidget(
      {this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return ListTile(
          leading: query.isEmpty ? Icon(Icons.history) : Icon(null),
          title: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                    text: suggestion.substring(0, query.length),
                    // Highlight the substring that matched the query.
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: suggestion.substring(query.length),
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




