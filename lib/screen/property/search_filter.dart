import 'package:flutter/material.dart';
import 'package:paroont_realty_mobile/constant/paroont_const.dart';
import 'package:paroont_realty_mobile/service/property.dart';
import 'package:paroont_realty_mobile/service/ref_data.dart';
import 'package:paroont_realty_mobile/widget/common_widget.dart';

class PropertyFilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter"),
      ),
      body: Container(
        child: ListView(children: [
          _makeFilterTile(
              context, 'Searching For:', _createTransactionTypesChip()),
          Divider(),
          _makeFilterTile(
              context, 'Category:', _createPropertyTypeGroupsChip()),
          Divider(),
          _makeFilterTile(
              context, 'Property Type:', _createPropertyTypesChip()),
          Divider(),
          _makeFilterTile(
              context, 'Number of Bedrooms:', _createPropertyConfigTypesChip()),

          Divider(),
          _makeFilterTile(
              context, 'City:', _createCityWidget(context)), // data ??
          Divider(),
          _makeFilterTile(
              context, 'Area:', _createAreaWidget(context)), // data ??
          Divider(),
          _makeFilterTile(context, 'Localities:', Container()), // data ??
          Divider(),
          _makeFilterTile(context, 'Budget:', Container()), // data ??
          Divider(),
          _makeFilterTile(context, 'Unit Area:', Container()),
          Divider(),

          _makeFilterTile(context, 'Sale Type:', Container()), // data??
          Divider(),

          _makeFilterTile(
              context, 'Furnishing:', _createPropertyFurnishTypesChip()),
          Divider(),
          _makeFilterTile(
              context, 'Availiability:', _createPropertyAvailableTypesChip()),

          Divider(),
          _makeFilterTile(
              context, 'Property Age:', _createPropertyAgeTypesChip()),
          Divider(),

          _makeFilterTile(context, 'Posted By:', _createPostedUserTypesChip()),

          Divider(),
          _makeFilterTile(
              context, 'Property Facing:', _createPropertyFaceTypesChip()),
          Divider(),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.list),
      ),
    );
  }
}

Widget _makeFilterTile(BuildContext context, String title, Widget content) {
  return ListTile(
    title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _titleWidget(context, title),
      content,
    ]),
  );
}

Widget _titleWidget(BuildContext context, String myTitle) {
  return Text(
    myTitle,
    // style: DefaultTextStyle.of(context).style,
  );
}

Widget _createAreaWidget(BuildContext context) {
  Map<String, String> selectedDataMap = Map();
  PropertyService().getFilter().areaIds.forEach((element) {
    selectedDataMap[element] = RdmService().propertyTypes()[element];
  });
  return AreaWidget(dataMap: selectedDataMap);
}

class AreaWidget extends StatefulWidget {
  final Map<String, String> dataMap;
  AreaWidget({Key key, this.dataMap}) : super(key: key);
  @override
  _AreaWidgetState createState() => _AreaWidgetState();
  void updateFilterData(BuildContext context) {
    List<String> ids = PropertyService().getFilter().areaIds;
    ids.clear();
    dataMap?.forEach((key, value) {
      ids.add(key);
    });
  }
}

class _AreaWidgetState extends State<AreaWidget> {
  String _selectedItem = '-1';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildChips(context),
    );
  }

  Widget _buildChips(BuildContext context) {
    List<Widget> chips = List();
    widget.dataMap?.forEach((k, v) {
      chips.add(
        Chip(
          label: Text(v),
          onDeleted: () {
            setState(() {
              widget.dataMap.removeWhere((key, value) => key == k);
              widget.updateFilterData(context);
            });
          },
        ),
      );
    });

    chips.add(DropdownButton<String>(
        value: _selectedItem,
        icon: Icon(Icons.add),
        
        items: _buildSelectItems(context),
        onChanged: (value) {
          setState(() {
            if ('-1' != value) {
              print("Selected_Area: $value");
              widget.dataMap.removeWhere((key, value) => key == value);
              widget.dataMap[value] = RdmService().propertyTypes()[value];
              List<String> ids = PropertyService().getFilter().cityIds;
              ids.remove(value);
              ids.add(value);
            }
          });
        }));

    return new Wrap(
      children: chips,
      spacing: 2,
    );
  }

  List<DropdownMenuItem<String>> _buildSelectItems(BuildContext context) {
    List<DropdownMenuItem<String>> ddItems = List();

    ddItems.add(DropdownMenuItem(
      child: Text('Add Area'),
      value: '-1',
    ));
    RdmService().propertyTypes().forEach((key, value) {
      ddItems.add(DropdownMenuItem(
        child: Text(value),
        value: key,
      ));
    });

    return ddItems;
  }
}

Widget _createCityWidget(BuildContext context) {
  Map<String, String> selectedDataMap = Map();
  PropertyService().getFilter().cityIds.forEach((element) {
    selectedDataMap[element] = RdmService().propertyTypes()[element];
  });
  return CityWidget(dataMap: selectedDataMap);
}

class CityWidget extends StatefulWidget {
  final Map<String, String> dataMap;
  CityWidget({Key key, this.dataMap}) : super(key: key);
  @override
  _CityWidgetState createState() => _CityWidgetState();
  void updateFilterData(BuildContext context) {
    List<String> ids = PropertyService().getFilter().cityIds;
    ids.clear();
    dataMap?.forEach((key, value) {
      ids.add(key);
    });
  }
}

class _CityWidgetState extends State<CityWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildChips(context),
    );
  }

  Widget _buildChips(BuildContext context) {
    List<Widget> chips = List();
    widget.dataMap?.forEach((k, v) {
      chips.add(
        Chip(
          label: Text(v),
          onDeleted: () {
            setState(() {
              widget.dataMap.removeWhere((key, value) => key == k);
              widget.updateFilterData(context);
            });
          },
        ),
      );
    });

    chips.add(ActionChip(
        label: Text('Add City'),
        avatar: CircleAvatar(
          child: Icon(Icons.add),
        ),
        onPressed: () {
          _citySelection(context);
        }));
    return new Wrap(
      children: chips,
      spacing: 2,
    );
  }

  _citySelection(BuildContext context) async {
    MultiSelectData data = new MultiSelectData();

    data.title = 'City';
    data.dataMap = RdmService().propertyTypes();
    data.selectedIds = widget.dataMap.entries.map((e) => e.key).toList();

    final selectedCities = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MultiSelectWidget(widgetData: data)));
    if (null != selectedCities) {
      setState(() {
        List<String> ids = PropertyService().getFilter().cityIds;
        ids.clear();
        widget.dataMap.clear();
        selectedCities?.forEach((key) {
          ids.add(key);
          widget.dataMap[key] = RdmService().propertyTypes()[key];
        });
      });
    }
    print("Selected_Cities: $selectedCities");
  }
}

class SelectedCitiesChip extends PropertyFilterChip {
  SelectedCitiesChip({Key key, Map dataMap, List selectedIds})
      : super(key: key, dataMap: dataMap, selectedIds: selectedIds);
  @override
  void updateFilterData(BuildContext context) {
    List<int> ids = PropertyService().getFilter().transactionTypeIds;
    ids.clear();
    selectedIds?.forEach((element) {
      ids.add(int.parse(element));
    });
  }
}

Widget _createTransactionTypesChip() {
  return TransactionTypesChip(
      dataMap: _createFilterDataMap(RdmService().propertyTransactionTypes()),
      selectedIds: PropertyService()
          .getFilter()
          .transactionTypeIds
          .map((e) => e.toString())
          .toList());
}

class TransactionTypesChip extends PropertyFilterChip {
  TransactionTypesChip({Key key, Map dataMap, List selectedIds})
      : super(key: key, dataMap: dataMap, selectedIds: selectedIds);
  @override
  void updateFilterData(BuildContext context) {
    List<int> ids = PropertyService().getFilter().transactionTypeIds;
    ids.clear();
    selectedIds?.forEach((element) {
      ids.add(int.parse(element));
    });
  }
}

Widget _createPostedUserTypesChip() {
  return PostedUserTypesChip(
      dataMap: _createPostedUserTypesDataMap(),
      selectedIds: PropertyService()
          .getFilter()
          .postedUserTypeIds
          .map((e) => e.toString())
          .toList());
}

Map<String, String> _createPostedUserTypesDataMap() {
  Map<String, String> filterdData =
      _createFilterDataMap(RdmService().propertyProfileTypes());
  //remove ADMIN AND support option.
  filterdData?.removeWhere((key, value) =>
      ARD_PROPERTY_PROFILE_TYPE_KEY_ADMIN.toString() == key ||
      ARD_PROPERTY_PROFILE_TYPE_KEY_SUPPORT.toString() == key);
  return filterdData;
}

class PostedUserTypesChip extends PropertyFilterChip {
  PostedUserTypesChip({Key key, Map dataMap, List selectedIds})
      : super(key: key, dataMap: dataMap, selectedIds: selectedIds);
  @override
  void updateFilterData(BuildContext context) {
    List<int> ids = PropertyService().getFilter().postedUserTypeIds;
    ids.clear();
    selectedIds?.forEach((element) {
      ids.add(int.parse(element));
    });
  }
}

Widget _createPropertyTypesChip() {
  return PropertyTypesChip(
      dataMap: _createFilterDataMap(RdmService().propertyTypes()),
      selectedIds: PropertyService()
          .getFilter()
          .propertyTypeIds
          .map((e) => e.toString())
          .toList());
}

class PropertyTypesChip extends PropertyFilterChip {
  PropertyTypesChip({Key key, Map dataMap, List selectedIds})
      : super(key: key, dataMap: dataMap, selectedIds: selectedIds);
  @override
  void updateFilterData(BuildContext context) {
    List<int> ids = PropertyService().getFilter().propertyTypeIds;
    ids.clear();
    selectedIds?.forEach((element) {
      ids.add(int.parse(element));
    });
  }
}

Widget _createPropertyFaceTypesChip() {
  return PropertyFaceTypesChip(
      dataMap: _createFilterDataMap(RdmService().propertyFaceTypes()),
      selectedIds: PropertyService()
          .getFilter()
          .faceIds
          .map((e) => e.toString())
          .toList());
}

class PropertyFaceTypesChip extends PropertyFilterChip {
  PropertyFaceTypesChip({Key key, Map dataMap, List selectedIds})
      : super(key: key, dataMap: dataMap, selectedIds: selectedIds);
  @override
  void updateFilterData(BuildContext context) {
    List<int> ids = PropertyService().getFilter().faceIds;
    ids.clear();
    selectedIds?.forEach((element) {
      ids.add(int.parse(element));
    });
  }
}

Widget _createPropertyAgeTypesChip() {
  return PropertyAgeTypesChip(
      dataMap: _createFilterDataMap(RdmService().propertyAgeTypes()),
      selectedIds: PropertyService()
          .getFilter()
          .propertyAgeIds
          .map((e) => e.toString())
          .toList());
}

class PropertyAgeTypesChip extends PropertyFilterChip {
  PropertyAgeTypesChip({Key key, Map dataMap, List selectedIds})
      : super(key: key, dataMap: dataMap, selectedIds: selectedIds);
  @override
  void updateFilterData(BuildContext context) {
    List<int> ids = PropertyService().getFilter().propertyAgeIds;
    ids.clear();
    selectedIds?.forEach((element) {
      ids.add(int.parse(element));
    });
  }
}

Widget _createPropertyAvailableTypesChip() {
  return PropertyAvailableTypesTypesChip(
      dataMap: _createPropertyAvailableTypesDataMap(),
      selectedIds: PropertyService()
          .getFilter()
          .availabilityIds
          .map((e) => e.toString())
          .toList());
}

Map<String, String> _createPropertyAvailableTypesDataMap() {
  Map<String, String> filterdData =
      _createFilterDataMap(RdmService().propertyAvailableTypes());
  //remove date option.
  filterdData?.removeWhere(
      (key, value) => ARD_PROPERTY_AVAILABLE_TYPE_KEY_DATE.toString() == key);
  return filterdData;
}

class PropertyAvailableTypesTypesChip extends PropertyFilterChip {
  PropertyAvailableTypesTypesChip({Key key, Map dataMap, List selectedIds})
      : super(key: key, dataMap: dataMap, selectedIds: selectedIds);
  @override
  void updateFilterData(BuildContext context) {
    List<int> ids = PropertyService().getFilter().availabilityIds;
    ids.clear();
    selectedIds?.forEach((element) {
      ids.add(int.parse(element));
    });
  }
}

Widget _createPropertyFurnishTypesChip() {
  return PropertyFurnishTypesChip(
      dataMap: _createFilterDataMap(RdmService().propertyFurnishTypes()),
      selectedIds: PropertyService()
          .getFilter()
          .furnishIds
          .map((e) => e.toString())
          .toList());
}

class PropertyFurnishTypesChip extends PropertyFilterChip {
  PropertyFurnishTypesChip({Key key, Map dataMap, List selectedIds})
      : super(key: key, dataMap: dataMap, selectedIds: selectedIds);
  @override
  void updateFilterData(BuildContext context) {
    List<int> ids = PropertyService().getFilter().furnishIds;
    ids.clear();
    selectedIds?.forEach((element) {
      ids.add(int.parse(element));
    });
  }
}

Widget _createPropertyConfigTypesChip() {
  return PropertyConfigTypesChip(
      dataMap: _createFilterDataMap(RdmService().propertyConfigTypes()),
      selectedIds: PropertyService()
          .getFilter()
          .configurationIds
          .map((e) => e.toString())
          .toList());
}

class PropertyConfigTypesChip extends PropertyFilterChip {
  PropertyConfigTypesChip({Key key, Map dataMap, List selectedIds})
      : super(key: key, dataMap: dataMap, selectedIds: selectedIds);
  @override
  void updateFilterData(BuildContext context) {
    List<int> ids = PropertyService().getFilter().configurationIds;
    ids.clear();
    selectedIds?.forEach((element) {
      ids.add(int.parse(element));
    });
  }
}

Widget _createPropertyTypeGroupsChip() {
  List<String> selectedChoice = List();
  selectedChoice
      .add(PropertyService().getFilter().propertyTypeGroupId.toString());

  return PropertyTypeGroupsChip(
      dataMap: RdmService().propertyTypeGroups(),
      selectedChoice: selectedChoice);
}

class PropertyTypeGroupsChip extends PropertyChoiceChip {
  PropertyTypeGroupsChip({Key key, Map dataMap, List selectedChoice})
      : super(key: key, dataMap: dataMap, selectedChoice: selectedChoice);
  @override
  void updateFilterData(BuildContext context) {
    PropertyService().getFilter().propertyTypeGroupId =
        takeSelectedChoice().isNotEmpty
            ? int.parse(takeSelectedChoice())
            : ARD_COMMON_INVALID_KEY;
  }
}

// Property Common Chip Widget

Map<String, String> _createFilterDataMap(Map<String, String> dataMap) {
  Map<String, String> filterdData =
      dataMap?.map((key, value) => MapEntry(key, value));
  filterdData
      ?.removeWhere((key, value) => ARD_COMMON_KEY_NO_DATA.toString() == key);
  return filterdData;
}

class PropertyFilterChip extends StatefulWidget {
  final Map<String, String> dataMap;
  final List<String> selectedIds;

  PropertyFilterChip({Key key, this.dataMap, this.selectedIds})
      : super(key: key);
  @override
  _PropertyFilterChipState createState() => _PropertyFilterChipState();
  void updateFilterData(BuildContext context) {}
}

class _PropertyFilterChipState extends State<PropertyFilterChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildChips(context),
    );
  }

  Widget _buildChips(BuildContext context) {
    List<Widget> chips = List();
    widget.dataMap?.forEach((k, v) {
      chips.add(
        FilterChip(
          label: Text(v),
          selected: widget.selectedIds.contains(k),
          onSelected: (isSelected) {
            setState(() {
              isSelected
                  ? widget.selectedIds.add(k)
                  : widget.selectedIds.remove(k);
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

class PropertyChoiceChip extends StatefulWidget {
  final Map<String, String> dataMap;
  final List<String> selectedChoice;

  PropertyChoiceChip({Key key, this.dataMap, this.selectedChoice})
      : super(key: key);
  @override
  _PropertyChoiceChipState createState() => _PropertyChoiceChipState();
  void updateFilterData(BuildContext context) {}
  String takeSelectedChoice() {
    return selectedChoice.length >= 1 ? selectedChoice[0] : '';
  }
}

class _PropertyChoiceChipState extends State<PropertyChoiceChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildChips(context),
    );
  }

  Widget _buildChips(BuildContext context) {
    List<Widget> chips = List();
    widget.dataMap?.forEach((k, v) {
      chips.add(
        ChoiceChip(
          label: Text(v),
          selected: widget.selectedChoice.contains(k),
          onSelected: (isSelected) {
            setState(() {
              widget.selectedChoice.clear();
              isSelected
                  ? widget.selectedChoice.add(k)
                  : widget.selectedChoice.remove(k);
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
