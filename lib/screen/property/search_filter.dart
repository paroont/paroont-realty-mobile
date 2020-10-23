import 'package:flutter/material.dart';
import 'package:paroont_realty_mobile/constant/paroont_const.dart';
import 'package:paroont_realty_mobile/service/property.dart';
import 'package:paroont_realty_mobile/service/ref_data.dart';
import 'package:paroont_realty_mobile/widget/common_widget.dart';
import 'package:paroont_realty_mobile/util/property_util.dart';



class PropertyFilterScreen extends StatefulWidget {
  @override
  _PropertyFilterScreenState createState() => _PropertyFilterScreenState();
}

class _PropertyFilterScreenState extends State<PropertyFilterScreen> {
  RangeValues selectedBudgetRange = RangeValues(
      minPropertyBudget(PropertyService().getFilter()),
      maxPropertyBudget(PropertyService().getFilter()));

  RangeValues selectedUnitAreaRange = RangeValues(
      minUnitArea(PropertyService().getFilter()),
      maxUnitArea(PropertyService().getFilter()));

  List<int> selectedTransactionTypeIds = List();
  List<int> selectedSaleTypeIds = List();
  List<int> selectedUnitAreaTypeIds = List();
  List<int> selectedUnitUnitTypeIds = List();

  List<int> selectedPropertyTypeIds = List();
  List<int> selectedPropertyTypeGroupIds = List();
  List<int> selectedPropertyConfigTypeIds = List();
  List<int> selectedFurnishTypeIds = List();
  List<int> selectedAvailableTypeIds = List();
  List<int> selectedPropertyAgeIds = List();

  List<int> selectedPostedUserTypeIds = List();

  List<int> selectedPropertyFaceTypeIds = List();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter"),
      ),
      body: Container(
        child: ListView(children: [
          _makeFilterTile(context, 'Searching For:',
              _createTransactionTypesWidget(context)),
          Divider(),

          _makeFilterTile(
              context, 'Category:', _createPropertyTypeGroupsWidget(context)),
          Divider(),

          _makeFilterTile(
              context, 'Property Type:', _createPropertyTypesWidget(context)),
          Divider(),

          _makeFilterTile(context, 'Number of Bedrooms:',
              _createPropertyConfigTypesWidget(context)),
          Divider(),

          _makeFilterTile(
              context, 'City:', _createCityWidget(context)), // data ??
          Divider(),

          _makeFilterTile(
              context, 'Area:', _createAreaWidget(context)), // data ??
          Divider(),

          _makeFilterTile(context, 'Localities:', Container()), // data ??
          Divider(),

          _makeFilterTile(
              context, 'Budget:', _createBudgetWidget(context)), // data ??
          Divider(),

          _makeFilterTile(
              context, 'Unit Area:', _createUnitAreaWidget(context)),
          Divider(),

          _makeFilterTile(
              context, 'Sale Type:', _createSaleTypesChip(context)), // data??
          Divider(),

          _makeFilterTile(
              context, 'Furnishing:', _createFurnishTypesWidget(context)),
          Divider(),

          _makeFilterTile(
              context, 'Availability:', _createAvailableTypesWidget(context)),
          Divider(),

          _makeFilterTile(
              context, 'Property Age:', _createPropertyAgeTypesWidget(context)),
          Divider(),

          _makeFilterTile(
              context, 'Posted By:', _createPostedUserTypesWidget(context)),
          Divider(),

          _makeFilterTile(context, 'Property Facing:',
              _createPropertyFaceTypesWidget(context)),
          Divider(),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.list),
      ),
    );
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

  void _updateMulitSelectTypes<T>(
      List<T> selectedIds, List<T> finalIds, bool selected, T id) {
    selected ? selectedIds.add(id) : selectedIds.remove(id);
    //Clear existing data
    finalIds.clear();
    selectedIds?.forEach((element) {
      finalIds.add(element);
    });
  }

  void _updateSingleSelectTypes<T>(List<T> selectedIds, bool selected, T id) {
    //Clear existing data
    selectedIds.clear();
    selected ? selectedIds.add(id) : selectedIds.remove(id);
  }

  Widget _createBudgetWidget(BuildContext context) {
    return Container(
      child: Column(children: [
        Text(
            '${propertyPriceFormat().format(selectedBudgetRange.start)} to ${propertyPriceFormat().format(selectedBudgetRange.end)}'),
        RangeSlider(
          values: selectedBudgetRange,
          min: minPropertyBudget(PropertyService().getFilter()),
          max: maxPropertyBudget(PropertyService().getFilter()),
          onChanged: (newRange) {
            _updateBudgetRange(newRange);
          },
        )
      ]),
    );
  }

  void _updateBudgetRange(RangeValues newRange) {
    setState(() {
      selectedBudgetRange = newRange;
      PropertyService().getFilter().minBudget = selectedBudgetRange.start;
      PropertyService().getFilter().maxBudget = selectedBudgetRange.end;
    });
  }

  void _resetBudgetRange() {
    selectedBudgetRange = RangeValues(
        minPropertyBudget(PropertyService().getFilter()),
        maxPropertyBudget(PropertyService().getFilter()));
  }

  Widget _createTransactionTypesWidget(BuildContext context) {
    List<Widget> chips = List();
    RdmService().propertyTransactionTypes()?.forEach((k, v) {
      chips.add(
        FilterChip(
          label: Text(v),
          selected: selectedTransactionTypeIds.contains(int.parse(k)),
          onSelected: (isSelected) {
            _updateTransactionTypes(isSelected, int.parse(k));
          },
        ),
      );
    });
    return new Wrap(
      children: chips,
      spacing: 2,
    );
  }

  void _updateTransactionTypes(bool isSelected, int id) {
    setState(() {
      _updateMulitSelectTypes(selectedTransactionTypeIds,
          PropertyService().getFilter().transactionTypeIds, isSelected, id);
      _resetBudgetRange();
    });
  }

  Widget _createSaleTypesChip(BuildContext context) {
    List<Widget> chips = List();
    RdmService().propertySaleTypes()?.forEach((k, v) {
      chips.add(
        FilterChip(
          label: Text(v),
          selected: selectedSaleTypeIds.contains(int.parse(k)),
          onSelected: (isSelected) {
            _updateSaleTypes(isSelected, int.parse(k));
          },
        ),
      );
    });
    return new Wrap(
      children: chips,
      spacing: 2,
    );
  }

  void _updateSaleTypes(bool isSelected, int id) {
    setState(() {
      _updateMulitSelectTypes(selectedSaleTypeIds,
          PropertyService().getFilter().saleTypeIds, isSelected, id);
    });
  }

  Widget _createUnitAreaWidget(BuildContext context) {
    return Column(
      children: [
        _createUnitAreaTypeWidget(context),
        Divider(),
        _createUnitAreaRangeWidget(context),
        Divider(),
        _createUnitUnitTypeWidget(context),
      ],
    );
  }

  Widget _createUnitAreaTypeWidget(BuildContext context) {
    List<Widget> chips = List();
    _createFilterDataMap(RdmService().propertyAreaTypes())?.forEach((k, v) {
      chips.add(
        ChoiceChip(
          label: Text(v),
          selected: selectedUnitAreaTypeIds.contains(int.parse(k)),
          onSelected: (isSelected) {
            setState(() {
              _updateUnitAreaTypes(isSelected, int.parse(k));
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

  void _updateUnitAreaTypes(bool selected, int id) {
    setState(() {
      _updateSingleSelectTypes(selectedUnitAreaTypeIds, selected, id);
      PropertyService().getFilter().areaTypeId =
          selectedUnitAreaTypeIds.isNotEmpty ? id : ARD_COMMON_INVALID_KEY;
    });
  }

  Widget _createUnitUnitTypeWidget(BuildContext context) {
    List<Widget> chips = List();
    _createFilterDataMap(RdmService().propertyAreaUnitTypes())?.forEach((k, v) {
      chips.add(
        ChoiceChip(
          label: Text(v),
          selected: selectedUnitUnitTypeIds.contains(int.parse(k)),
          onSelected: (isSelected) {
            setState(() {
              _updateUnitUnitTypes(isSelected, int.parse(k));
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

  void _updateUnitUnitTypes(bool selected, int id) {
    setState(() {
      _updateSingleSelectTypes(selectedUnitUnitTypeIds, selected, id);
      PropertyService().getFilter().areaUnitId =
          selectedUnitUnitTypeIds.isNotEmpty ? id : ARD_COMMON_INVALID_KEY;
    });
  }

  Widget _createUnitAreaRangeWidget(BuildContext context) {
    return Container(
      child: Column(children: [
        Text(
            '${unitAreaFormat().format(selectedUnitAreaRange.start)} to ${unitAreaFormat().format(selectedUnitAreaRange.end)}'),
        RangeSlider(
          values: selectedUnitAreaRange,
          min: minUnitArea(PropertyService().getFilter()),
          max: maxUnitArea(PropertyService().getFilter()),
          onChanged: (newRange) {
            _updateUnitAreaRange(newRange);
          },
        )
      ]),
    );
  }

  void _updateUnitAreaRange(RangeValues newRange) {
    setState(() {
      selectedUnitAreaRange = newRange;
      PropertyService().getFilter().minArea = selectedUnitAreaRange.start;
      PropertyService().getFilter().maxArea = selectedUnitAreaRange.end;
    });
  }

  Widget _createPropertyTypesWidget(BuildContext context) {
    List<Widget> chips = List();
    _createFilterDataMap(RdmService().propertyTypes())?.forEach((k, v) {
      chips.add(
        FilterChip(
          label: Text(v),
          selected: selectedPropertyTypeIds.contains(int.parse(k)),
          onSelected: (isSelected) {
            _updatePropertyTypes(isSelected, int.parse(k));
          },
        ),
      );
    });
    return new Wrap(
      children: chips,
      spacing: 2,
    );
  }

  void _updatePropertyTypes(bool isSelected, int id) {
    setState(() {
      _updateMulitSelectTypes(selectedPropertyTypeIds,
          PropertyService().getFilter().propertyTypeIds, isSelected, id);
    });
  }

  Widget _createPropertyConfigTypesWidget(BuildContext context) {
    List<Widget> chips = List();
    _createFilterDataMap(RdmService().propertyConfigTypes())?.forEach((k, v) {
      chips.add(
        FilterChip(
          label: Text(v),
          selected: selectedPropertyConfigTypeIds.contains(int.parse(k)),
          onSelected: (isSelected) {
            _updatePropertyConfigTypes(isSelected, int.parse(k));
          },
        ),
      );
    });
    return new Wrap(
      children: chips,
      spacing: 2,
    );
  }

  void _updatePropertyConfigTypes(bool isSelected, int id) {
    setState(() {
      _updateMulitSelectTypes(selectedPropertyConfigTypeIds,
          PropertyService().getFilter().configurationIds, isSelected, id);
    });
  }

  Widget _createFurnishTypesWidget(BuildContext context) {
    List<Widget> chips = List();
    _createFilterDataMap(RdmService().propertyFurnishTypes())?.forEach((k, v) {
      chips.add(
        FilterChip(
          label: Text(v),
          selected: selectedFurnishTypeIds.contains(int.parse(k)),
          onSelected: (isSelected) {
            _updateFurnishTypes(isSelected, int.parse(k));
          },
        ),
      );
    });
    return new Wrap(
      children: chips,
      spacing: 2,
    );
  }

  void _updateFurnishTypes(bool isSelected, int id) {
    setState(() {
      _updateMulitSelectTypes(selectedFurnishTypeIds,
          PropertyService().getFilter().furnishIds, isSelected, id);
    });
  }

  Widget _createAvailableTypesWidget(BuildContext context) {
    List<Widget> chips = List();
    Map<String, String> filterdData =
        _createFilterDataMap(RdmService().propertyAvailableTypes());
    //remove date option.
    filterdData?.removeWhere(
        (key, value) => ARD_PROPERTY_AVAILABLE_TYPE_KEY_DATE.toString() == key);

    filterdData?.forEach((k, v) {
      chips.add(
        FilterChip(
          label: Text(v),
          selected: selectedAvailableTypeIds.contains(int.parse(k)),
          onSelected: (isSelected) {
            _updateAvailableTypes(isSelected, int.parse(k));
          },
        ),
      );
    });
    return new Wrap(
      children: chips,
      spacing: 2,
    );
  }

  void _updateAvailableTypes(bool isSelected, int id) {
    setState(() {
      _updateMulitSelectTypes(selectedAvailableTypeIds,
          PropertyService().getFilter().availabilityIds, isSelected, id);
    });
  }

  Widget _createPropertyAgeTypesWidget(BuildContext context) {
    List<Widget> chips = List();
    _createFilterDataMap(RdmService().propertyAgeTypes())?.forEach((k, v) {
      chips.add(
        FilterChip(
          label: Text(v),
          selected: selectedPropertyAgeIds.contains(int.parse(k)),
          onSelected: (isSelected) {
            _updatePropertyAgeTypes(isSelected, int.parse(k));
          },
        ),
      );
    });
    return new Wrap(
      children: chips,
      spacing: 2,
    );
  }

  void _updatePropertyAgeTypes(bool isSelected, int id) {
    setState(() {
      _updateMulitSelectTypes(selectedPropertyAgeIds,
          PropertyService().getFilter().propertyAgeIds, isSelected, id);
    });
  }

  Widget _createPostedUserTypesWidget(BuildContext context) {
    List<Widget> chips = List();
    Map<String, String> filterdData =
        _createFilterDataMap(RdmService().propertyProfileTypes());
    //remove date option.
    filterdData?.removeWhere((key, value) =>
        ARD_PROPERTY_PROFILE_TYPE_KEY_ADMIN.toString() == key ||
        ARD_PROPERTY_PROFILE_TYPE_KEY_SUPPORT.toString() == key);

    filterdData?.forEach((k, v) {
      chips.add(
        FilterChip(
          label: Text(v),
          selected: selectedPostedUserTypeIds.contains(int.parse(k)),
          onSelected: (isSelected) {
            _updatePostedUserTypes(isSelected, int.parse(k));
          },
        ),
      );
    });
    return new Wrap(
      children: chips,
      spacing: 2,
    );
  }

  void _updatePostedUserTypes(bool isSelected, int id) {
    setState(() {
      _updateMulitSelectTypes(selectedPostedUserTypeIds,
          PropertyService().getFilter().postedUserTypeIds, isSelected, id);
    });
  }

  Widget _createPropertyFaceTypesWidget(BuildContext context) {
    List<Widget> chips = List();
    _createFilterDataMap(RdmService().propertyFaceTypes())?.forEach((k, v) {
      chips.add(
        FilterChip(
          label: Text(v),
          selected: selectedPropertyFaceTypeIds.contains(int.parse(k)),
          onSelected: (isSelected) {
            _updatePropertyFaceTypes(isSelected, int.parse(k));
          },
        ),
      );
    });
    return new Wrap(
      children: chips,
      spacing: 2,
    );
  }

  void _updatePropertyFaceTypes(bool isSelected, int id) {
    setState(() {
      _updateMulitSelectTypes(selectedPropertyFaceTypeIds,
          PropertyService().getFilter().faceIds, isSelected, id);
    });
  }

  Widget _createPropertyTypeGroupsWidget(BuildContext context) {
    List<Widget> chips = List();
    _createFilterDataMap(RdmService().propertyTypeGroups())?.forEach((k, v) {
      chips.add(
        ChoiceChip(
          label: Text(v),
          selected: selectedPropertyTypeGroupIds.contains(int.parse(k)),
          onSelected: (isSelected) {
            setState(() {
              _updatePropertyTypeGroups(isSelected, int.parse(k));
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

  void _updatePropertyTypeGroups(bool selected, int id) {
    setState(() {
      _updateSingleSelectTypes(selectedPropertyTypeGroupIds, selected, id);
      PropertyService().getFilter().propertyTypeGroupId =
          selectedPropertyTypeGroupIds.isNotEmpty ? id : ARD_COMMON_INVALID_KEY;
    });
  }
  // End of State
}


Map<T, String> _createFilterDataMap<T>(Map<T, String> dataMap) {
  Map<T, String> filterdData =
      dataMap?.map((key, value) => MapEntry(key, value));
  filterdData?.removeWhere(
      (key, value) => ARD_COMMON_KEY_NO_DATA.toString() == key.toString());
  return filterdData;
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

// Property Common Chip Widget

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
