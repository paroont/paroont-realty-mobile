import 'package:flutter/material.dart';
import 'package:paroont_realty_mobile/model/property.dart';
import 'package:paroont_realty_mobile/model/common.dart';
import 'package:paroont_realty_mobile/service/property.dart';
import 'package:paroont_realty_mobile/screen/property/search_common.dart';

class PropertySearchResultScreen extends StatefulWidget {
  const PropertySearchResultScreen({
    Key key,
  }) : super(key: key);

  @override
  PropertySearchResultScreenState createState() =>
      PropertySearchResultScreenState();
}

class PropertySearchResultScreenState
    extends State<PropertySearchResultScreen> {
  List<PropertyDetail> allProperties = List();

  Future<CorePaginationData<PropertyDetail>> _properties;

  ScrollController _scrollController = ScrollController(keepScrollOffset: true);

  bool _isLoading = false;
  int totalRecords = 0;
  @override
  void didChangeDependencies() {
    _loadProperties();
    super.didChangeDependencies();
  }

  _scrollListener() {
    if (!_isLoading &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      setState(() {
        _isLoading = true;
        // PropertySearchMainWidget.of(context).filter.pageNo++;
PropertyService().getFilter().pageNo++;
        if (PropertyService().getFilter().pageNo <=
            (totalRecords /
                PropertyService().getFilter().pageSize)) {
          _loadProperties();
        }

        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  totalRecords = snapshot.data.totalRecords;
                  allProperties.addAll(snapshot.data.data);
                  widget = Expanded(
                      child: ListView.separated(
                          controller: _scrollController,
                          separatorBuilder: (context, i) => Divider(),
                          itemCount: allProperties.length,
                          itemBuilder: (context, i) {
                            return buildPropertyResultRow(context, allProperties[i], true);
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

  void loadData() {
    setState(() {
      PropertyService().getFilter().pageNo = 0;
      _loadProperties();
    });
  }

  void _loadProperties() {
    _properties = PropertyService()
        .allProperties(PropertyService().getFilter());
  }

  

 
}


