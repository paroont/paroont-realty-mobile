import 'package:flutter/material.dart';
import 'package:paroont_realty_mobile/model/property.dart';
import 'package:paroont_realty_mobile/model/common.dart';
import 'package:paroont_realty_mobile/service/ref_data.dart';
import 'package:paroont_realty_mobile/util/common_util.dart';
import 'package:paroont_realty_mobile/util/property_util.dart';
import 'package:paroont_realty_mobile/service/property.dart';


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
                            return _buildRow(context, allProperties[i]);
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
                      'Id: ${p.propertyId} ${notNullStr(RdmService().propertyTransactionTypeValue(p.transactionTypeId))} ',
                ),
                TextSpan(
                    text:
                        '${notNullStr(RdmService().propertyConfigTypeValue(p.configurationId))} ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text:
                        '${notNullStr(RdmService().propertyTypeGroupsValue(p.propertyTypeId))} '),
                TextSpan(
                    text:
                        '${notNullStr(RdmService().propertyTypeValue(p.propertyTypeGroupId))} '),
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
          padding: EdgeInsets.all(2),
          //labelPadding: EdgeInsets.all(4),
          //labelPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
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
