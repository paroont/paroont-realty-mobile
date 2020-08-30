import 'package:flutter/material.dart';
import 'package:paroont_realty_mobile/model/property.dart';
import 'package:paroont_realty_mobile/service/ref_data.dart';
import 'package:paroont_realty_mobile/util/common_util.dart';
import 'package:paroont_realty_mobile/util/property_util.dart';
import 'package:paroont_realty_mobile/service/property.dart';

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

class PropertySearchResultScreen extends StatefulWidget {
  @override
  _PropertySearchResultScreenState createState() =>
      _PropertySearchResultScreenState();
}

class _PropertySearchResultScreenState
    extends State<PropertySearchResultScreen> {
  Future<List<PropertyDetail>> _properties;
 
@override
  void didChangeDependencies() {
  _properties = PropertyService().allProperties();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<List<PropertyDetail>>(
            future: _properties,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                    child: ListView.separated(
                        separatorBuilder: (context, i) => Divider(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return _buildRow(context, snapshot.data[i]);
                        }));
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            }));
  }

  Widget _buildRow(BuildContext context, PropertyDetail p) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text:
                      '${notNullStr(Rdm().propertyTransactionTypeValue(p.transactionTypeId))} ',
                ),
                TextSpan(
                    text:
                        '${notNullStr(Rdm().propertyConfigTypeValue(p.configurationId))} ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text:
                        '${notNullStr(Rdm().propertyTypeGroupsValue(p.propertyTypeId))} '),
                TextSpan(
                    text:
                        '${notNullStr(Rdm().propertyTypeValue(p.propertyTypeGroupId))} '),
                TextSpan(text: 'in ${notNullStr(p.cityName)} '),
              ],
            ),
          ),
          RichText(
            text:
                TextSpan(style: DefaultTextStyle.of(context).style, children: [
              TextSpan(
                  text: '${buildingTitle(p)}',
                  style: TextStyle(fontWeight: FontWeight.w400)),
            ]),
          ),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text: '${propertyBuyAmount(p)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '${propertyBuyUnitAmount(p)}',
                ),
                TextSpan(
                    text: '${propertyRentAmount(p)}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text: '${propertyRentDepositAmount(p)}',
                    style: TextStyle(fontWeight: FontWeight.w200)),
                TextSpan(
                    text: '| ', style: TextStyle(fontWeight: FontWeight.w200)),
                TextSpan(
                  text: '${propertyArea(p, 1)} ',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                TextSpan(
                  text: '${propertyArea(p, 2)} ',
                  style: TextStyle(fontWeight: FontWeight.w200),
                ),
                TextSpan(
                  text: '${propertyArea(p, 3)} Area',
                  style: TextStyle(fontWeight: FontWeight.w200),
                ),
              ],
            ),
          ),
          Wrap(
            children: _buildOutlines(context, p),
            spacing: 2,
          ),
        ],
      ),
      subtitle: Row(
        children: [
          Text("Agent: "),
          Text("View Contact No: "),
          IconButton(
            icon: Icon(
              Icons.phone,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.message,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PropertySearchDetailScreen(
                    propertyDetail: p,
                  )),
        );
      },
    );
  }

  List<Widget> _buildOutlines(BuildContext context, PropertyDetail p) {
    List<Widget> chips = List();

    propertySearchResultOutlines(p).forEach((e) {
      chips.add(
        Chip(
          label: Text(
            e,
            style: TextStyle(
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      );
    });

    return chips;
  }
}

class PropertySearchDetailScreen extends StatelessWidget {
  final PropertyDetail propertyDetail;

  PropertySearchDetailScreen({Key key, @required this.propertyDetail})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Property Details!"),
      ),
      body: Center(
        child: Text('${propertyDetail.buildingName}'),
      ),
    );
  }
}
