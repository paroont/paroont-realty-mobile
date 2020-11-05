import 'package:flutter/material.dart';
import 'package:paroont_realty_mobile/constant/paroont_const.dart';
import 'package:paroont_realty_mobile/model/property.dart';
import 'package:paroont_realty_mobile/model/common.dart';
import 'package:paroont_realty_mobile/service/property.dart';
import 'package:paroont_realty_mobile/service/ref_data.dart';
import 'package:paroont_realty_mobile/constant/ui_const.dart';
import 'package:paroont_realty_mobile/widget/common_widget.dart';
import 'package:paroont_realty_mobile/util/property_util.dart';
import 'package:paroont_realty_mobile/util/common_util.dart';

class PostPropertyScreen extends StatefulWidget {
  final PropertyDetail propertyData;

/*
  DateTime availabilityTs;

  DateTime ocTs;


 int totalBedrooms = -1;
  int totalMasterBedrooms = -1;
  int totalBathrooms = -1;
  int totalBalconies = -1;


  int earthquakeResistant = -1;
  int gasPipeline = -1;
  int clubHouse = -1;
  int gym = -1;
  int kidsPlayArea = -1;
  int waterHarvesting = -1;
  int swimmingPool = -1;
  int commonAreaPowerBackup = -1;
  int flatPowerBackup = -1;
  int seniorCitizenArea = -1;
  int gatedSociety = -1;
  int waterSupply = -1;
  int landscapeLawn = -1;
  int banquetHall = -1;
  int joggersTrack = -1;
  int cctv = -1;
  int fireAlarm = -1;

  int petFriendly = -1;

  String floorTypeIds;

  int modularKitchen = -1;

  int poojaRoom = -1;
  int studyRoom = -1;
  int servantRoom = -1;
  int othersRoom = -1;

  String weekdaysVisitingIds;
  String weekendVisitingIds;

  String postedBy;
  String postedByName;
  DateTime postedTs;
  int postedUserTypeId;
  DateTime dealTs;
  
  */

  PostPropertyScreen({Key key, this.propertyData}) : super(key: key);

  @override
  _PostPropertyScreenState createState() => _PostPropertyScreenState();
}

class _PostPropertyScreenState extends State<PostPropertyScreen> {
  Map<int, TextSearchData> allLocations = takeLocationSearchData();
  Map<int, TextSearchData> allCityLocations = takeLocationCitySearchData();
  Map<int, TextSearchData> allAreaLocations = takeLocationAreaSearchData();
  Map<int, TextSearchData> allLocalites = takePropertyLocalitySearchData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Post Property'),
        ),
        body: _buildBody(context),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              child: Icon(Icons.save),
              onPressed: () {
                _saveProperty(context);
              },
            );
          },
        ));
  }

  void _saveProperty(BuildContext context) async {
    final PropertySaveResponse propertyResponse =
        await PropertyService().saveProperty(widget.propertyData);
    print('Property save response: ${propertyResponse.message}');
    if (propertyResponse.status) {
      Navigator.pop(context, propertyResponse);
    } else {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("${propertyResponse.message}")));
    }
  }

  Widget _buildBody(BuildContext context) {
    return Container(
        child: ListView(
      children: [
        _makeDataTile(
            context, 'Posting For', _buildTransactionTypesWidget(context)),
        Divider(),
        _makeDataTile(
            context, 'Category', _buildPropertyTypeGroupsWidget(context)),
        Divider(),
        _makeDataTile(
            context, 'Property Type', _buildPropertyTypesWidget(context)),
        Divider(),
        _makeDataTile(context, 'Number of Bedrooms',
            _buildPropertyConfigTypesWidget(context)),
        Divider(),
        _makeDataTile(context, 'City', _buildLocationCityWidget(context)),
        _makeDataTile(context, 'Area', _buildLocationAreaWidget(context)),
        _makeDataTile(context, 'Locality', _buildLocalitiesWidget(context)),
        _makeDataTile(context, null, _buildLocationSelectWidget(context)),
        _makeDataTile(context, null, _buildAddress1Widget(context)),
        _makeDataTile(context, null, _buildLandmarkWidget(context)),
        Divider(),
        _makeDataTile(context, null, _buildProjectNameWidget(context)),
        _makeDataTile(context, null, _buildBuilderNameWidget(context)),
        _makeDataTile(context, null, _buildBuildingNameWidget(context)),
        _makeDataTile(context, null, _buildReraWidget(context)),
        Divider(),
        _makeDataTile(context, 'Sale Type', _buildSaleTypesWidget(context)),
        Divider(),
        _makeDataTile(context, 'Availability',
            _buildPropertyAvailableTypesWidget(context)),
        Divider(),
        _makeDataTile(context, 'Unit Area', _createUnitAreaWidget(context)),
        Divider(),
        _makeDataTile(context, 'Price', _buildPriceWidget(context)),
        Divider(),
        _makeDataTile(context, 'Floor', _buildFloorWidget(context)),
        Divider(),
        _makeDataTile(
            context,
            isRental(widget.propertyData) ? 'Preferred Tenant Type' : null,
            _buildTenantTypesWidget(context)),
        Divider(),
        _makeDataTile(context, 'Furnishing', _buildFurnishTypesWidget(context)),
        Divider(),
        _makeDataTile(context, 'Property Age', _buildAgeTypesWidget(context)),
        Divider(),
        _makeDataTile(
            context, 'Posted By', _buildPostedUserTypesWidget(context)),
        Divider(),
        _makeDataTile(context, null, _buildTotalBrokersWidget(context)),
        Divider(),
        _makeDataTile(
            context, 'Property Facing', _buildFaceTypesWidget(context)),
        Divider(),
        _makeDataTile(context, null, _buildDescriptionWidget(context)),
        _makeDataTile(context, null, _buildNotesWidget(context)),
        Divider(),
      ],
    ));
  }

  Widget _makeDataTile(BuildContext context, String title, Widget content) {
    List<Widget> widgets = List();
    if (null != title && title.isNotEmpty) {
      widgets.add(_titleWidget(context, title));
    }
    widgets.add(content);

    return ListTile(
      title: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: widgets),
    );
  }

  Widget _titleWidget(BuildContext context, String myTitle) {
    return Text(
      myTitle,
      // style: DefaultTextStyle.of(context).style,
    );
  }

  Widget _buildTransactionTypesWidget(BuildContext context) {
    List<Widget> chips = List();
    RdmService().propertyTransactionTypes()?.forEach((k, v) {
      chips.add(
        ChoiceChip(
          label: Text(v),
          selected: widget.propertyData.transactionTypeId == int.parse(k),
          onSelected: (selected) {
            _updateTransactionTypes(selected, int.parse(k));
          },
        ),
      );
    });
    return new Wrap(
      children: chips,
      spacing: 2,
    );
  }

  void _updateTransactionTypes(bool selected, int id) {
    setState(() {
      selected
          ? widget.propertyData.transactionTypeId = id
          : widget.propertyData.transactionTypeId = ARD_COMMON_INVALID_KEY;
    });
  }

  Widget _buildPropertyTypeGroupsWidget(BuildContext context) {
    List<Widget> chips = List();
    RdmService().propertyTypeGroups()?.forEach((k, v) {
      chips.add(
        ChoiceChip(
          label: Text(v),
          selected: widget.propertyData.propertyTypeGroupId == int.parse(k),
          onSelected: (selected) {
            setState(() {
              _updatePropertyTypeGroups(selected, int.parse(k));
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
      selected
          ? widget.propertyData.propertyTypeGroupId = id
          : widget.propertyData.propertyTypeGroupId = ARD_COMMON_INVALID_KEY;
    });
  }

  Widget _buildPropertyConfigTypesWidget(BuildContext context) {
    List<Widget> chips = List();
    RdmService().propertyConfigTypes()?.forEach((k, v) {
      chips.add(
        ChoiceChip(
          label: Text(v),
          selected: widget.propertyData.configurationId == int.parse(k),
          onSelected: (selected) {
            setState(() {
              _updatePropertyConfigType(selected, int.parse(k));
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

  void _updatePropertyConfigType(bool selected, int id) {
    setState(() {
      selected
          ? widget.propertyData.configurationId = id
          : widget.propertyData.configurationId = ARD_COMMON_INVALID_KEY;
    });
  }

  Widget _buildPropertyTypesWidget(BuildContext context) {
    List<Widget> chips = List();
    RdmService().propertyTypes()?.forEach((k, v) {
      chips.add(
        ChoiceChip(
          label: Text(v),
          selected: widget.propertyData.propertyTypeId == int.parse(k),
          onSelected: (selected) {
            setState(() {
              _updatePropertyType(selected, int.parse(k));
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

  void _updatePropertyType(bool selected, int id) {
    setState(() {
      selected
          ? widget.propertyData.propertyTypeId = id
          : widget.propertyData.propertyTypeId = ARD_COMMON_INVALID_KEY;
    });
  }

  Widget _buildLocationSelectWidget(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
          hintText: 'Select City, Area, Locality',
          prefixIcon: Icon(Icons.search),
        ),
        readOnly: true,
        onTap: () {
          _locationSelection(context);
        });
  }

  _locationSelection(BuildContext context) async {
    MultiSelectData data = new MultiSelectData();
    Map<int, TextSearchData> sids = Map();
    String cityId = notNullStr(widget.propertyData.cityId);
    if (cityId.isNotEmpty) {
      var city = takeTextSearchDataByKey(allCityLocations, cityId);
      if (null != city) {
        sids[city.dataId] = city;
      }
    }
    String areaId = notNullStr(widget.propertyData.areaId);
    if (areaId.isNotEmpty) {
      var area = takeTextSearchDataByKey(allAreaLocations, areaId);
      if (null != area) {
        sids[area.dataId] = area;
      }
    }
    List<String> localityIds =
        notNullStr(widget.propertyData.localityIds).split(',');
    localityIds.forEach((id) {
      if (id.isNotEmpty) {
        var locality = takeTextSearchDataByKey(allLocalites, id);
        if (null != locality) {
          sids[locality.dataId] = locality;
        }
      }
    });

    data.title = 'City Area Locality';
    data.allData = allLocations;
    data.selectedData = sids;

    final selectedData = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MultiSelectWidget(widgetData: data)));
    if (null != selectedData) {
      updateSelectedLocations(selectedData);
    }
    print("_locationSelection_selectedData: $selectedData");
  }

  void updateSelectedLocations(Map<int, TextSearchData> selectedData) {
    setState(() {
      widget.propertyData.cityId = '';
      widget.propertyData.areaId = '';
      widget.propertyData.localityIds = '';

      List<String> localityIds = List();

      selectedData.forEach((key, value) {
        if (value.type == ARD_COMMON_CITY_NAME) {
          widget.propertyData.cityId = value.key;
        } else if (value.type == ARD_COMMON_AREA_NAME) {
          widget.propertyData.areaId = value.key;
        } else if (value.type == ARD_COMMON_LOCALITY_NAME) {
          localityIds.add(value.key);
        }
      });
      if (localityIds.isNotEmpty) {
        widget.propertyData.localityIds = localityIds.join(',');
      }
    });
  }

  Widget _buildLocationCityWidget(BuildContext context) {
    Widget cityWidget = Container();
    String cityId = notNullStr(widget.propertyData.cityId);
    if (cityId.isNotEmpty) {
      TextSearchData sd = takeTextSearchDataByKey(allCityLocations, cityId);
      cityWidget = Chip(
        label: Text(null != sd ? sd.title : cityId),
        onDeleted: () {
          removeSelectedCity();
        },
      );
    }
    return cityWidget;
  }

  void removeSelectedCity() {
    setState(() {
      widget.propertyData.cityId = '';
    });
  }

  Widget _buildLocationAreaWidget(BuildContext context) {
    Widget areaWidget = Container();
    String areaId = notNullStr(widget.propertyData.areaId);
    if (areaId.isNotEmpty) {
      TextSearchData sd = takeTextSearchDataByKey(allAreaLocations, areaId);
      areaWidget = Chip(
        label: Text(null != sd ? sd.title : areaId),
        onDeleted: () {
          removeSelectedArea();
        },
      );
    }
    return areaWidget;
  }

  void removeSelectedArea() {
    setState(() {
      widget.propertyData.areaId = '';
    });
  }

  Widget _buildLocalitiesWidget(BuildContext context) {
    List<Widget> chips = List();

    List<String> localityIds =
        notNullStr(widget.propertyData.localityIds).split(',');
    localityIds.forEach((id) {
      if (id.isNotEmpty) {
        var sd = takeTextSearchDataByKey(allLocalites, id);
        chips.add(Chip(
          label: Text(null != sd ? sd.title : id),
          onDeleted: () {
            removeSelectedLocality(id);
          },
        ));
      }
    });

    return new Wrap(
      children: chips,
      spacing: 2,
    );
  }

  void removeSelectedLocality(String key) {
    setState(() {
      List<String> localityIds =
          notNullStr(widget.propertyData.localityIds).split(',');
      localityIds.remove(key);
      widget.propertyData.localityIds =
          localityIds.isNotEmpty ? localityIds.join(',') : '';
    });
  }

  Widget _buildProjectNameWidget(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Project/Society'),
      onChanged: (value) {
        updateProjectName(value);
      },
    );
  }

  void updateProjectName(String newName) {
    setState(() {
      widget.propertyData.projectName = newName;
    });
  }

  Widget _buildBuilderNameWidget(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Builder'),
      onChanged: (value) {
        updateBuilderName(value);
      },
    );
  }

  void updateBuilderName(String newName) {
    setState(() {
      widget.propertyData.builderName = newName;
    });
  }

  Widget _buildBuildingNameWidget(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Building Name'),
      onChanged: (value) {
        updateBuildingName(value);
      },
    );
  }

  void updateBuildingName(String newName) {
    setState(() {
      widget.propertyData.buildingName = newName;
    });
  }

  Widget _buildLandmarkWidget(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Landmark'),
      onChanged: (value) {
        updateLandmark(value);
      },
    );
  }

  void updateLandmark(String newName) {
    setState(() {
      widget.propertyData.landmarkName = newName;
    });
  }

  Widget _buildPropertyAvailableTypesWidget(BuildContext context) {
    List<Widget> chips = List();
    RdmService().propertyAvailableTypes()?.forEach((k, v) {
      chips.add(
        ChoiceChip(
          label: Text(v),
          selected: widget.propertyData.availabilityId == int.parse(k),
          onSelected: (selected) {
            setState(() {
              _updatePropertyAvailableType(selected, int.parse(k));
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

  void _updatePropertyAvailableType(bool selected, int id) {
    setState(() {
      selected
          ? widget.propertyData.availabilityId = id
          : widget.propertyData.availabilityId = ARD_COMMON_INVALID_KEY;
    });
  }

  Widget _buildSaleTypesWidget(BuildContext context) {
    List<Widget> chips = List();
    RdmService().propertySaleTypes()?.forEach((k, v) {
      chips.add(
        ChoiceChip(
          label: Text(v),
          selected: widget.propertyData.saleTypeId == int.parse(k),
          onSelected: (selected) {
            setState(() {
              _updateSaleType(selected, int.parse(k));
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

  void _updateSaleType(bool selected, int id) {
    setState(() {
      selected
          ? widget.propertyData.saleTypeId = id
          : widget.propertyData.saleTypeId = ARD_COMMON_INVALID_KEY;
    });
  }

  Widget _buildFurnishTypesWidget(BuildContext context) {
    List<Widget> chips = List();
    RdmService().propertyFurnishTypes()?.forEach((k, v) {
      chips.add(
        ChoiceChip(
          label: Text(v),
          selected: widget.propertyData.furnishId == int.parse(k),
          onSelected: (selected) {
            setState(() {
              _updateFurnishType(selected, int.parse(k));
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

  void _updateFurnishType(bool selected, int id) {
    setState(() {
      selected
          ? widget.propertyData.furnishId = id
          : widget.propertyData.furnishId = ARD_COMMON_INVALID_KEY;
    });
  }

  Widget _buildAgeTypesWidget(BuildContext context) {
    List<Widget> chips = List();
    RdmService().propertyAgeTypes()?.forEach((k, v) {
      chips.add(
        ChoiceChip(
          label: Text(v),
          selected: widget.propertyData.propertyAgeId == int.parse(k),
          onSelected: (selected) {
            setState(() {
              _updateAgeType(selected, int.parse(k));
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

  void _updateAgeType(bool selected, int id) {
    setState(() {
      selected
          ? widget.propertyData.propertyAgeId = id
          : widget.propertyData.propertyAgeId = ARD_COMMON_INVALID_KEY;
    });
  }

  Widget _buildPostedUserTypesWidget(BuildContext context) {
    List<Widget> chips = List();
    RdmService().postPropertyProfileTypes()?.forEach((k, v) {
      chips.add(
        ChoiceChip(
          label: Text(v),
          selected: widget.propertyData.postedUserTypeId == int.parse(k),
          onSelected: (selected) {
            setState(() {
              _updatePostedUserType(selected, int.parse(k));
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

  void _updatePostedUserType(bool selected, int id) {
    setState(() {
      selected
          ? widget.propertyData.postedUserTypeId = id
          : widget.propertyData.postedUserTypeId = ARD_COMMON_INVALID_KEY;
    });
  }

  Widget _buildFaceTypesWidget(BuildContext context) {
    List<Widget> chips = List();
    RdmService().propertyFaceTypes()?.forEach((k, v) {
      chips.add(
        ChoiceChip(
          label: Text(v),
          selected: widget.propertyData.faceId == int.parse(k),
          onSelected: (selected) {
            setState(() {
              _updateFaceType(selected, int.parse(k));
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

  void _updateFaceType(bool selected, int id) {
    setState(() {
      selected
          ? widget.propertyData.faceId = id
          : widget.propertyData.faceId = ARD_COMMON_INVALID_KEY;
    });
  }

  Widget _createUnitAreaWidget(BuildContext context) {
    return Column(
      children: [
        _buildCarpetUnitAreaWidget(context),
        _buildBuiltUpAreaWidget(context),
        _buildSuperBuiltUpAreaWidget(context),
      ],
    );
  }

  Widget _buildCarpetUnitAreaWidget(BuildContext context) {
    List<Widget> chips = List();

    chips.add(
      Container(
          width: 125,
          child: TextFormField(
            decoration: InputDecoration(labelText: 'Carpet'),
            // keyboardType: TextInputType.number,
            onChanged: (value) {
              updateCarpetArea(double.tryParse(value) ?? 0.0);
            },
          )),
    );

    RdmService().propertyAreaUnitTypes()?.forEach((k, v) {
      chips.add(
        ChoiceChip(
          label: Text(v),
          selected: widget.propertyData.carpetAreaUnitId == int.parse(k),
          onSelected: (selected) {
            setState(() {
              updateCarpetAreaUnit(selected, int.parse(k));
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

  void updateCarpetArea(double area) {
    setState(() {
      widget.propertyData.carpetArea = area;
    });
  }

  void updateCarpetAreaUnit(bool selected, int id) {
    setState(() {
      selected
          ? widget.propertyData.carpetAreaUnitId = id
          : widget.propertyData.carpetAreaUnitId = ARD_COMMON_INVALID_KEY;
    });
  }

  Widget _buildBuiltUpAreaWidget(BuildContext context) {
    List<Widget> chips = List();

    chips.add(
      Container(
          width: 125,
          child: TextFormField(
            decoration: InputDecoration(labelText: 'Builtup'),
            // keyboardType: TextInputType.number,
            onChanged: (value) {
              updateBuiltUpArea(double.tryParse(value) ?? 0.0);
            },
          )),
    );

    RdmService().propertyAreaUnitTypes()?.forEach((k, v) {
      chips.add(
        ChoiceChip(
          label: Text(v),
          selected: widget.propertyData.builtUpAreaUnitId == int.parse(k),
          onSelected: (selected) {
            setState(() {
              updateBuiltUpAreaUnit(selected, int.parse(k));
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

  void updateBuiltUpArea(double area) {
    setState(() {
      widget.propertyData.builtUpArea = area;
    });
  }

  void updateBuiltUpAreaUnit(bool selected, int id) {
    setState(() {
      selected
          ? widget.propertyData.builtUpAreaUnitId = id
          : widget.propertyData.builtUpAreaUnitId = ARD_COMMON_INVALID_KEY;
    });
  }

  Widget _buildSuperBuiltUpAreaWidget(BuildContext context) {
    List<Widget> chips = List();

    chips.add(
      Container(
          width: 125,
          child: TextFormField(
            decoration: InputDecoration(labelText: 'Super Builtup'),
            // keyboardType: TextInputType.number,
            onChanged: (value) {
              updateSuperBuiltUpArea(double.tryParse(value) ?? 0.0);
            },
          )),
    );

    RdmService().propertyAreaUnitTypes()?.forEach((k, v) {
      chips.add(
        ChoiceChip(
          label: Text(v),
          selected: widget.propertyData.superBuiltUpAreaUnitId == int.parse(k),
          onSelected: (selected) {
            setState(() {
              updateSuperBuiltUpAreaUnit(selected, int.parse(k));
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

  void updateSuperBuiltUpArea(double area) {
    setState(() {
      widget.propertyData.superBuiltUpArea = area;
    });
  }

  void updateSuperBuiltUpAreaUnit(bool selected, int id) {
    setState(() {
      selected
          ? widget.propertyData.superBuiltUpAreaUnitId = id
          : widget.propertyData.superBuiltUpAreaUnitId = ARD_COMMON_INVALID_KEY;
    });
  }

  Widget _buildFloorWidget(BuildContext context) {
    return Column(
      children: [
        _buildFloorIdWidget(context),
        _buildFloorNoWidget(context),
      ],
    );
  }

  Widget _buildFloorIdWidget(BuildContext context) {
    List<Widget> chips = List();
    RdmService().postPropertyFloorNoTypes()?.forEach((k, v) {
      chips.add(
        ChoiceChip(
          label: Text(v),
          selected: widget.propertyData.floorId == int.parse(k),
          onSelected: (selected) {
            setState(() {
              updateFloorId(selected, int.parse(k));
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

  void updateFloorId(bool selected, int id) {
    setState(() {
      selected
          ? widget.propertyData.floorId = id
          : widget.propertyData.floorId = ARD_COMMON_INVALID_KEY;
    });
  }

  Widget _buildFloorNoWidget(BuildContext context) {
    List<Widget> widgets = List();

    widgets.add(
      Container(
          width: 125,
          child: TextFormField(
            decoration: InputDecoration(labelText: 'Floor No'),

            // keyboardType: TextInputType.number,
            onChanged: (value) {
              updateFloorNo(value);
            },
          )),
    );

    widgets.add(
      Center(
        child: Text(
          ' of ',
        ),
      ),
    );

    widgets.add(
      Container(
          width: 125,
          child: TextFormField(
            decoration: InputDecoration(labelText: 'Total Floors'),
            // keyboardType: TextInputType.number,
            onChanged: (value) {
              updatedTotalFloors(int.tryParse(value) ?? 0);
            },
          )),
    );

    return new Row(
      children: widgets,
    );
  }

  void updateFloorNo(String newNo) {
    setState(() {
      if (notBlankStr(newNo)) {
        widget.propertyData.floorId = ARD_FLOOR_NO_TYPE_KEY_NO;
        widget.propertyData.floorNo = newNo;
      } else {
        widget.propertyData.floorId = ARD_COMMON_KEY_NO_DATA;
      }
    });
  }

  void updatedTotalFloors(int newNo) {
    setState(() {
      widget.propertyData.totalFloors = newNo;
    });
  }

  Widget _buildDescriptionWidget(BuildContext context) {
    return Container(
      height: 200,
      child: TextFormField(
        decoration: InputDecoration(labelText: 'Property Description'),
        //keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        maxLines: null,
        maxLength: 2000,
        onChanged: (value) {
          updateDescription(value);
        },
      ),
    );
  }

  void updateDescription(String newName) {
    setState(() {
      widget.propertyData.propertyDescription = newName;
    });
  }

  Widget _buildNotesWidget(BuildContext context) {
    return Container(
      height: 150,
      child: TextFormField(
        decoration: InputDecoration(labelText: 'Notes'),
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        maxLines: null,
        maxLength: 1000,
        onChanged: (value) {
          updateNotes(value);
        },
      ),
    );
  }

  void updateNotes(String newName) {
    setState(() {
      widget.propertyData.notes = newName;
    });
  }

  Widget _buildTenantTypesWidget(BuildContext context) {
    List<Widget> chips = List();
    if (isRental(widget.propertyData)) {
      RdmService().propertyPreferredTenantTypes()?.forEach((k, v) {
        chips.add(
          ChoiceChip(
            label: Text(v),
            selected: widget.propertyData.tenantTypeId == int.parse(k),
            onSelected: (selected) {
              setState(() {
                _updateTenantType(selected, int.parse(k));
              });
            },
          ),
        );
      });
    } else {
      chips.add(Container());
    }
    return new Wrap(
      children: chips,
      spacing: 2,
    );
  }

  void _updateTenantType(bool selected, int id) {
    setState(() {
      selected
          ? widget.propertyData.tenantTypeId = id
          : widget.propertyData.tenantTypeId = ARD_COMMON_INVALID_KEY;
    });
  }

  Widget _buildPriceWidget(BuildContext context) {
    List<Widget> widgets = List();
    widgets.add(
      Container(
          width: 125,
          child: TextFormField(
            decoration: InputDecoration(labelText: 'Asking Price'),
            //keyboardType: TextInputType.number,
            onChanged: (value) {
              updatePrice(double.tryParse(value) ?? 0.0);
            },
          )),
    );

    if (isRental(widget.propertyData)) {
      widgets.add(Container(
          width: 125,
          child: TextFormField(
            decoration: InputDecoration(labelText: 'Deposit Amount'),
            //keyboardType: TextInputType.number,
            onChanged: (value) {
              updateDepositAmount(double.tryParse(value) ?? 0.0);
            },
          )));

      widgets.add(ChoiceChip(
        label: Text(UI_TITLE_POST_PROPERTY_HEAVY_DEPOSIT),
        selected: widget.propertyData.heavyDeposit == ARD_COMMON_KEY_YES,
        onSelected: (selected) {
          setState(() {
            updateHeavyDepost(selected);
          });
        },
      ));
    } else {
      widgets.add(ChoiceChip(
        label: Text(UI_TITLE_POST_PROPERTY_ALL_AMOUNT_INCLUSIVE),
        selected: widget.propertyData.allInclusiveAmount == ARD_COMMON_KEY_YES,
        onSelected: (selected) {
          setState(() {
            updateAllInclusiveAmount(selected);
          });
        },
      ));
      widgets.add(ChoiceChip(
        label: Text(UI_TITLE_POST_PROPERTY_TAX_GOV_CHARGE_INCLUDED),
        selected:
            widget.propertyData.taxAndGovChargeIncluded == ARD_COMMON_KEY_YES,
        onSelected: (selected) {
          setState(() {
            updateTaxAndGovChargeIncluded(selected);
          });
        },
      ));
    }

    widgets.add(ChoiceChip(
      label: Text(UI_TITLE_POST_PROPERTY_AMOUNT_NEGOTIABLE),
      selected: widget.propertyData.amountNegotiable == ARD_COMMON_KEY_YES,
      onSelected: (selected) {
        setState(() {
          updateAmountNegotiable(selected);
        });
      },
    ));

    return new Wrap(
      children: widgets,
      spacing: 2,
    );
  }

  void updatePrice(double newValue) {
    setState(() {
      widget.propertyData.expectedAmount = newValue;
    });
  }

  void updateDepositAmount(double newValue) {
    setState(() {
      widget.propertyData.expectedDepositAmount = newValue;
    });
  }

  void updateHeavyDepost(bool selected) {
    setState(() {
      selected
          ? widget.propertyData.heavyDeposit = ARD_COMMON_KEY_YES
          : widget.propertyData.heavyDeposit = ARD_COMMON_KEY_NO;
    });
  }

  void updateAllInclusiveAmount(bool selected) {
    setState(() {
      selected
          ? widget.propertyData.allInclusiveAmount = ARD_COMMON_KEY_YES
          : widget.propertyData.allInclusiveAmount = ARD_COMMON_KEY_NO;
    });
  }

  void updateTaxAndGovChargeIncluded(bool selected) {
    setState(() {
      selected
          ? widget.propertyData.taxAndGovChargeIncluded = ARD_COMMON_KEY_YES
          : widget.propertyData.taxAndGovChargeIncluded = ARD_COMMON_KEY_NO;
    });
  }

  void updateAmountNegotiable(bool selected) {
    setState(() {
      selected
          ? widget.propertyData.amountNegotiable = ARD_COMMON_KEY_YES
          : widget.propertyData.amountNegotiable = ARD_COMMON_KEY_NO;
    });
  }

// /////// -- new

  Widget _buildTotalBrokersWidget(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Additional Brokers'),
      //keyboardType: TextInputType.number,
      onChanged: (value) {
        updateTotalBrokers(int.tryParse(value) ?? 0);
      },
    );
  }

  void updateTotalBrokers(int newValue) {
    setState(() {
      widget.propertyData.totalBrokers = newValue;
    });
  }

  Widget _buildAddress1Widget(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'H.No/Street Name'),
      onChanged: (value) {
        updateAddress1Name(value);
      },
    );
  }

  void updateAddress1Name(String newName) {
    setState(() {
      widget.propertyData.addressLine1 = newName;
    });
  }

  Widget _buildReraWidget(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'RERA'),
      onChanged: (value) {
        updateRera(value);
      },
    );
  }

  void updateRera(String newName) {
    setState(() {
      widget.propertyData.reraId = newName;
    });
  }
}
