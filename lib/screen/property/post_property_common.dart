import 'package:flutter/material.dart';
import 'package:paroont_realty_mobile/constant/ui_const.dart';
import 'package:paroont_realty_mobile/model/property.dart';
import 'package:paroont_realty_mobile/screen/property/post_property.dart';

class PostPropertyFloatingActionButton extends StatelessWidget {
  final Function(PropertySaveResponse) responseCallback;
  PostPropertyFloatingActionButton(this.responseCallback);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text(UI_TITLE_POST_PROPERTY_ACTION_INIT),
      icon: Icon(Icons.add),
      onPressed: () {
        openPostPropertyScreen(context);
      },
    );
  }

  void openPostPropertyScreen(BuildContext context) async {
    final PropertySaveResponse propertyResponse = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostPropertyScreen(
          propertyData: new PropertyDetail(),
        ),
      ),
    );
    if (null != propertyResponse) {
      print('Post_Property_Result: [$propertyResponse].');
    }
    responseCallback(propertyResponse);
  }
}
