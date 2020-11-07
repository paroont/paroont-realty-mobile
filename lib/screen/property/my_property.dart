import 'package:flutter/material.dart';
import 'package:paroont_realty_mobile/model/property.dart';
import 'package:paroont_realty_mobile/model/common.dart';
import 'package:paroont_realty_mobile/service/property.dart';
import 'package:paroont_realty_mobile/screen/property/search_common.dart';
import 'package:paroont_realty_mobile/screen/property/post_property_common.dart';
import 'package:paroont_realty_mobile/screen/property/search_filter.dart';
import 'package:paroont_realty_mobile/service/common.dart';

class MyPropertyWidget extends StatefulWidget {
  @override
  _MyPropertyWidgetState createState() => _MyPropertyWidgetState();
}

class _MyPropertyWidgetState extends State<MyPropertyWidget> {
  List<PropertyDetail> allProperties = List();
  Map<int, PropertyDetail> selectedProperties = Map();
  bool _allSelected = false;

  Future<CorePaginationData<PropertyDetail>> _properties;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildMainWidget(context),
    );
  }

  @override
  void didChangeDependencies() {
    _loadProperties();
    super.didChangeDependencies();
  }

  void _loadProperties() {
    _properties = PropertyService()
        .allProperties(PropertyService().getMyFilter(), myProperty: true);
  }

  Widget _buildMainWidget(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      floatingActionButton: PostPropertyFloatingActionButton((saveResponse) {
        processPostPropertyResponse(saveResponse);
      }),
    );
  }

  void processPostPropertyResponse(PropertySaveResponse saveResponse) {
    if (null != saveResponse) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("${saveResponse.message}")));
    }
    loadData();
  }

  void loadData() {
    setState(() {
      _loadProperties();
    });
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      child: Column(children: [
        _buildSearchTopWidget(context),
        Expanded(
          child: _buildSearchResult(context),
        )
      ]),
    );
  }

  Widget _buildSearchTopWidget(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      _buildSelectAllWidget(context),
      _buildOtherActionWidget(context)
    ]);
  }

  Widget _buildOtherActionWidget(BuildContext context) {
    List<Widget> _widgets = List();
    if (selectedProperties.isNotEmpty) {
      _widgets.add(_buildWhatsAppWidget(context));
    }
    _widgets.add(_buildFilterWidget(context));
    return Row(
        mainAxisAlignment: MainAxisAlignment.end, children: _widgets);
  }

  Widget _buildFilterWidget(BuildContext context) {
    return Container(
      child: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PropertyFilterScreen()),
          );
        },
        iconSize: 45,
        icon: Icon(
          Icons.list,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildWhatsAppWidget(BuildContext context) {
    return Row(
      //  mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {
            CommonService().sendWhatsApp( number: '+00919819440106', msg: 'hello');
          },
          iconSize: 30,
          icon: Icon(
            Icons.message,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSelectAllWidget(BuildContext context) {
    return Container(
      width: 75,
      child: Checkbox(
        value: _allSelected,
        onChanged: (selected) {
          setState(() {
            _processSelectAll(selected);
          });
        },
      ),
    );
  }

  void _processSelectAll(bool selected) {
    _allSelected = selected;
    selectedProperties.clear();
    if (selected) {
      allProperties.forEach((p) {
        selectedProperties[p.propertyId] = p;
      });
    }
  }

  Widget _buildSearchResult(BuildContext context) {
    return Container(
      child: FutureBuilder<CorePaginationData<PropertyDetail>>(
          future: _properties,
          builder: (context, snapshot) {
            Widget widget;
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasError) {
                  widget = Text("${snapshot.error}");
                } else {
                  //  totalRecords = snapshot.data.totalRecords;
                  allProperties.clear();
                  allProperties.addAll(snapshot.data.data);
                  widget = Container(
                      child: ListView.separated(
                          // controller: _scrollController,
                          separatorBuilder: (context, i) => Divider(),
                          itemCount: allProperties.length,
                          itemBuilder: (context, i) {
                            return buildMyPropertyResultRow(
                                context, allProperties[i]);
                          }));
                }
                break;
              default:
                widget = CircularProgressIndicator();
                break;
            }
            return widget;
          }),
    );
  }

  Widget buildMyPropertyResultRow(BuildContext context, PropertyDetail pd) {
    return ListTile(
      //leading: Icon(Icons.check),
      title: buildPropertyTileTitle(context, pd),
      //contentPadding: EdgeInsets.symmetric(horizontal: 16),
      leading: Checkbox(
        value: selectedProperties.containsKey(pd.propertyId),
        onChanged: (selected) {
          setState(() {
            selected
                ? selectedProperties[pd.propertyId] = pd
                : selectedProperties.remove(pd.propertyId);
          });
        },
      ),

      onTap: () {
        openPostPropertyScreen(context, pd, (saveResponse) {
          processPostPropertyResponse(saveResponse);
        });
      },
    );
  }
}
