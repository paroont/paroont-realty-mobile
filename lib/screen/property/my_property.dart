import 'package:flutter/material.dart';
import 'package:paroont_realty_mobile/model/property.dart';
import 'package:paroont_realty_mobile/model/common.dart';
import 'package:paroont_realty_mobile/service/property.dart';
import 'package:paroont_realty_mobile/screen/property/search_common.dart';
import 'package:paroont_realty_mobile/screen/property/post_property_common.dart';

class MyPropertyWidget extends StatefulWidget {
  @override
  _MyPropertyWidgetState createState() => _MyPropertyWidgetState();
}

class _MyPropertyWidgetState extends State<MyPropertyWidget> {
  List<PropertyDetail> allProperties = List();

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
    _properties =
        PropertyService().allProperties(PropertyService().getMyFilter());
  }

  Widget _buildMainWidget(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      floatingActionButton: buildPostPropertyFloatingAction(context),
    );
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
                  allProperties.addAll(snapshot.data.data);
                  widget = Container(
                      child: ListView.separated(
                          // controller: _scrollController,
                          separatorBuilder: (context, i) => Divider(),
                          itemCount: allProperties.length,
                          itemBuilder: (context, i) {
                            return buildPropertyResultRow(
                                context, allProperties[i], false);
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
}
