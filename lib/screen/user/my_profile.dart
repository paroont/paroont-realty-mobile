import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paroont_realty_mobile/model/user.dart';
import 'package:paroont_realty_mobile/constant/paroont_const.dart';
import 'package:paroont_realty_mobile/service/user.dart';
import 'package:paroont_realty_mobile/service/ref_data.dart';

/*
CONTACT_NO_2_TITLE
CONTACT_NO_3_TITLE
CITY_ID
CITY_NAME
*/

class MyProfileWidget extends StatefulWidget {
  final UserProfile profile;
  MyProfileWidget(this.profile);

  @override
  _MyProfileWidgetState createState() => _MyProfileWidgetState();
}

class _MyProfileWidgetState extends State<MyProfileWidget> {
  final _profileFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
        ),
        body: _buildBody(context),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              child: Icon(Icons.save),
              onPressed: () {
                _saveProfile(context);
              },
            );
          },
        ));
  }

  Widget _buildBody(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            _buildProfileTypesWidget(context),
            _buildProfileFormWidget(context),
          ],
        ));
  }

  Widget _buildProfileFormWidget(BuildContext context) {
    List<Widget> formWidgets = List();

    formWidgets.add(_buildMobileNoWidget(context));
    formWidgets.add(_buildWhatsAppNoWidget(context));

    formWidgets.add(_buildFirstNameWidget(context));
    formWidgets.add(_buildLastNameWidget(context));
    formWidgets.add(_buildEmailIdWidget(context));

    formWidgets.add(_buildFacebookIdWidget(context));
    formWidgets.add(_buildTwitterIdWidget(context));
    formWidgets.add(_buildInstagramIdWidget(context));

    formWidgets.add(_buildReraIdWidget(context));
    formWidgets.add(_buildCompanyNameWidget(context));
    formWidgets.add(_buildCompanyWebUrlWidget(context));

    formWidgets.add(_buildAddressLine1Widget(context));
    formWidgets.add(_buildAddressLine2Widget(context));
    formWidgets.add(_buildCityWidget(context));

    formWidgets.add(_buildContactNo2Widget(context));
    formWidgets.add(_buildContactNo3Widget(context));

    formWidgets.add(_buildEmailId2Widget(context));
    formWidgets.add(_buildEmailId3Widget(context));

    formWidgets.add(_buildCompanyOverviewWidget(context));

    return Form(
      key: _profileFormKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: formWidgets),
    );
  }

  Widget _buildMobileNoWidget(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Primary Mobile No',
                prefix: Text(
                  widget.profile.takeMobileCountryCode(),
                ),
                prefixIcon: Icon(Icons.phone_iphone),
                counterText: '',
                border: InputBorder.none,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 10,
              initialValue: widget.profile.mobileNo,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter Mobile No';
                } else if (value.length != 10) {
                  return 'Mobile No must be 10 digits';
                }
                return null;
              },
              onChanged: (value) {
                widget.profile.mobileNo = value;
              },
            ),
          )
        ]);
  }

  Widget _buildWhatsAppNoWidget(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'WhatsApp No',
                prefix: Text(
                  widget.profile.takeWhatsAppCountryCode(),
                ),
                 prefixIcon: Icon(Icons.phone_iphone),
                counterText: '',
                border: InputBorder.none,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 10,
              initialValue: widget.profile.whatsAppNo,
              validator: (value) {
                if (value.isNotEmpty && value.length != 10) {
                  return 'WhatsApp No must be 10 digits';
                }
                return null;
              },
              onChanged: (value) {
                widget.profile.whatsAppNo = value;
              },
            ),
          )
        ]);
  }

  Widget _buildFirstNameWidget(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'First Name',
                counterText: '',
                prefixIcon: Icon(Icons.person),
                border: InputBorder.none,
              ),
              maxLength: 255,
              initialValue: widget.profile.firstName,
              validator: (value) {
                if (value.isEmpty) {
                  return 'First Name is required';
                }
                return null;
              },
              onChanged: (value) {
                widget.profile.firstName = value;
              },
            ),
          ),
        ]);
  }

  Widget _buildLastNameWidget(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              decoration:
                  InputDecoration(labelText: 'Last Name', counterText: '',
                    prefixIcon: Icon(Icons.person),
                     border: InputBorder.none,),
              maxLength: 255,
              initialValue: widget.profile.lastName,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Last Name is required';
                }
                return null;
              },
              onChanged: (value) {
                widget.profile.lastName = value;
              },
            ),
          )
        ]);
  }

  Widget _buildEmailIdWidget(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Primary Email',
                counterText: '',
                 prefixIcon: Icon(Icons.email),
                border: InputBorder.none,
              ),
              maxLength: 255,
              initialValue: widget.profile.emailId,
              onChanged: (value) {
                widget.profile.emailId = value;
              },
            ),
          )
        ]);
  }

  Widget _buildFacebookIdWidget(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Facebook',
                counterText: '',
                 prefixIcon: Icon(Icons.face),
                border: InputBorder.none,
              ),
              maxLength: 255,
              initialValue: widget.profile.facebookId,
              onChanged: (value) {
                widget.profile.facebookId = value;
              },
            ),
          )
        ]);
  }

  Widget _buildTwitterIdWidget(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Twitter',
                counterText: '',
                 prefixIcon: Icon(Icons.tag_faces),
                border: InputBorder.none,
              ),
              maxLength: 255,
              initialValue: widget.profile.twitterId,
              onChanged: (value) {
                widget.profile.twitterId = value;
              },
            ),
          )
        ]);
  }

  Widget _buildInstagramIdWidget(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Instagram',
                counterText: '',
                 prefixIcon: Icon(Icons.face),
                border: InputBorder.none,
              ),
              maxLength: 255,
              initialValue: widget.profile.instagramId,
              onChanged: (value) {
                widget.profile.instagramId = value;
              },
            ),
          )
        ]);
  }

  Widget _buildReraIdWidget(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'RERA',
                counterText: '',
                 prefixIcon: Icon(Icons.art_track),
                border: InputBorder.none,
              ),
              maxLength: 255,
              initialValue: widget.profile.reraId,
              onChanged: (value) {
                widget.profile.reraId = value;
              },
            ),
          )
        ]);
  }

  Widget _buildCompanyNameWidget(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Company Name',
                counterText: '',
                 prefixIcon: Icon(Icons.radio),
                border: InputBorder.none,
              ),
              maxLength: 255,
              initialValue: widget.profile.companyName,
              onChanged: (value) {
                widget.profile.companyName = value;
              },
            ),
          )
        ]);
  }

  Widget _buildCompanyWebUrlWidget(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Company Web URL',
                counterText: '',
                 prefixIcon: Icon(Icons.web),
                border: InputBorder.none,
              ),
              maxLength: 255,
              initialValue: widget.profile.companyWebUrl,
              onChanged: (value) {
                widget.profile.companyWebUrl = value;
              },
            ),
          )
        ]);
  }

  Widget _buildAddressLine1Widget(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Address',
                counterText: '',
                 prefixIcon: Icon(Icons.home),
                border: InputBorder.none,
              ),
              maxLength: 255,
              initialValue: widget.profile.addressLine1,
              onChanged: (value) {
                widget.profile.addressLine1 = value;
              },
            ),
          )
        ]);
  }

  Widget _buildAddressLine2Widget(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Address Line 2',
                counterText: '',
                 prefixIcon: Icon(Icons.home),
                border: InputBorder.none,
              ),
              maxLength: 255,
              initialValue: widget.profile.addressLine2,
              onChanged: (value) {
                widget.profile.addressLine2 = value;
              },
            ),
          )
        ]);
  }

  Widget _buildCityWidget(BuildContext context) {

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'City',
                counterText: '',
                 prefixIcon: Icon(Icons.location_city),
                border: InputBorder.none,
              ),
              maxLength: 255,
              initialValue: widget.profile.cityName,
              onChanged: (value) {
                widget.profile.cityName = value;
              },
            ),
          )
        ]);
  }

  Widget _buildContactNo2Widget(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Contact No 2',
                prefix: Text(
                  widget.profile.takeContactNo2CountryCode(),
                ),
                counterText: '',
                 prefixIcon: Icon(Icons.phone),
                border: InputBorder.none,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 10,
              initialValue: widget.profile.contactNo2,
              validator: (value) {
                if (value.isNotEmpty && value.length != 10) {
                  return 'Contact No must be 10 digits';
                }
                return null;
              },
              onChanged: (value) {
                widget.profile.contactNo2 = value;
              },
            ),
          )
        ]);
  }

  Widget _buildContactNo3Widget(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Contact No 3',
                prefix: Text(
                  widget.profile.takeContactNo3CountryCode(),
                ),
                counterText: '',
                 prefixIcon: Icon(Icons.phone),
                border: InputBorder.none,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 10,
              initialValue: widget.profile.contactNo3,
              validator: (value) {
                if (value.isNotEmpty && value.length != 10) {
                  return 'Contact No must be 10 digits';
                }
                return null;
              },
              onChanged: (value) {
                widget.profile.contactNo3 = value;
              },
            ),
          )
        ]);
  }

  Widget _buildEmailId2Widget(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Secondary Email',
                counterText: '',
                 prefixIcon: Icon(Icons.alternate_email),
                border: InputBorder.none,
              ),
              maxLength: 255,
              initialValue: widget.profile.emailId2,
              onChanged: (value) {
                widget.profile.emailId2 = value;
              },
            ),
          )
        ]);
  }

  Widget _buildEmailId3Widget(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Additional Email',
                counterText: '',
                 prefixIcon: Icon(Icons.alternate_email),
                border: InputBorder.none,
              ),
              maxLength: 255,
              initialValue: widget.profile.emailId3,
              onChanged: (value) {
                widget.profile.emailId3 = value;
              },
            ),
          )
        ]);
  }

  Widget _buildCompanyOverviewWidget(BuildContext context) {
    return Container(
      height: 200,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Company Overview',
          counterText: '',
           prefixIcon: Icon(Icons.location_city),
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        maxLines: null,
        maxLength: 2000,
        initialValue: widget.profile.companyOverview,
        onChanged: (value) {
          widget.profile.companyOverview = value;
        },
      ),
    );
  }

  Widget _buildProfileTypesWidget(BuildContext context) {
    List<Widget> widgets = List();
    widgets.add(Text('Profile Type'));

    List<Widget> chips = List();
    RdmService().postPropertyProfileTypes()?.forEach((k, v) {
      chips.add(
        ChoiceChip(
          label: Text(v),
          selected: widget.profile.profileTypeId == int.parse(k),
          onSelected: (selected) {
            setState(() {
              _updateProfileType(selected, int.parse(k));
            });
          },
        ),
      );
    });
    widgets.add(
      new Wrap(
        children: chips,
        spacing: 2,
      ),
    );

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }

  void _updateProfileType(bool selected, int id) {
    setState(() {
      selected
          ? widget.profile.profileTypeId = id
          : widget.profile.profileTypeId = ARD_COMMON_INVALID_KEY;
    });
  }

  void _saveProfile(BuildContext context) async {
    final UserProfileResponse saveResponse =
        await UserService().saveUserProfile(widget.profile);
    print('User save response: ${saveResponse.message}');
    if (saveResponse.status) {
      Navigator.pop(context, saveResponse.takeFirstData());
    } else {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("${saveResponse.message}")));
    }
  }
}
