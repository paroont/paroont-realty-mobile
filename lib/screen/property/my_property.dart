import 'package:flutter/material.dart';
import 'package:paroont_realty_mobile/model/property.dart';
import 'package:paroont_realty_mobile/model/common.dart';
import 'package:paroont_realty_mobile/service/property.dart';
import 'package:paroont_realty_mobile/screen/property/search_common.dart';
import 'package:paroont_realty_mobile/screen/property/post_property_common.dart';
import 'package:paroont_realty_mobile/screen/property/post_property.dart';

class MyPropertyWidget extends StatefulWidget {
  @override
  _MyPropertyWidgetState createState() => _MyPropertyWidgetState();
}

class _MyPropertyWidgetState extends State<MyPropertyWidget> {
  List<PropertyDetail> allProperties = List();
  Map<int, PropertyDetail> selectedProperties = Map();

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
    return _buildSearchResult(context);
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
        openPostPropertyScreen(context, pd, (saveResponse){
          processPostPropertyResponse(saveResponse);
        });
      },
    );
  }


}
