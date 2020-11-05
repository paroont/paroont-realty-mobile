import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paroont_realty_mobile/model/user.dart';
import 'package:paroont_realty_mobile/service/user.dart';
import 'package:paroont_realty_mobile/screen/user/my_profile.dart';

class UserProfileWidget extends StatefulWidget {
  @override
  _UserProfileWidgetState createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  var mobileNoController = new TextEditingController();
  var emailIdController = new TextEditingController();
  var fullNameController = new TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    List<Widget> widgets = UserService().getUser().loggedIn
        ? _buildLoggedInWidget(context)
        : _buildLoginWidget(context);

    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: widgets),
    );
  }

  List<Widget> _buildLoggedInWidget(BuildContext context) {
    List<Widget> widgets = List();

    widgets.add(TextFormField(
      controller: fullNameController,
      readOnly: true,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
    ));

    widgets.add(TextFormField(
      controller: mobileNoController,
      readOnly: true,
      decoration: InputDecoration(
          border: InputBorder.none, labelText: 'Primary Mobile '),
    ));

    widgets.add(TextFormField(
      controller: emailIdController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Primary Email',
        border: InputBorder.none,
      ),
    ));
    widgets.add(Container(
      height: 5,
    ));
    widgets.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: _buildEditProfileButtonWidget(context)),
          Expanded(child: _buildLogoutButtonWidget(context))
        ],
      ),
    );

    return widgets;
  }

  List<Widget> _buildLoginWidget(BuildContext context) {
    List<Widget> widgets = List();

    widgets.add(_buildLoginFormWidget(context));
    widgets.add(_buildLoginButtonWidget(context));

    return widgets;
  }

  Widget _buildLoginFormWidget(BuildContext context) {
    List<Widget> formWidgets = List();
    formWidgets.add(_buildMobileNoWidget(context));

    return Form(
        key: _loginFormKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: formWidgets));
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
                  UserService().getUser().takePrimaryMobileIsdCode(),
                ),
                counterText: '',
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 10,
              controller: mobileNoController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter Mobile No';
                } else if (value.length != 10) {
                  return 'Mobile No must be 10 digits';
                }
                return null;
              },
            ),
          )
        ]);
  }

  Widget _buildLoginButtonWidget(BuildContext context) {
    return Center(
      child: OutlineButton(
          child: Text("Login"),
          onPressed: () {
            if (_loginFormKey.currentState.validate()) {
              processLogin(context);
            }
          }),
    );
  }

  Widget _buildLogoutButtonWidget(BuildContext context) {
    return OutlineButton(
        child: Text("Logout"),
        onPressed: () {
          logout();
        });
  }

  Widget _buildEditProfileButtonWidget(BuildContext context) {
    return OutlineButton(
      child: Text("Edit My Profile"),
      onPressed: () {
        _editMyProfile(context);
      },
    );
  }

  void logout() {
    setState(() {
      UserService().getUser().logout();
    });
  }

  void login(UserProfile profile) {
    setState(() {
      UserService().getUser().login(profile);
      emailIdController.text = profile.emailId;
      fullNameController.text = 'Welcome ' + profile.takeFullName();
    });
  }

  void processLogin(BuildContext context) async {
    var profileResponse = await UserService().takeUserProfile(
        mobileNo: mobileNoController.text, createIfNotExist: true);
    if (null != profileResponse) {
      print("Profile_Response_Msg: ${profileResponse.message}");
      if (profileResponse.status) {
        login(profileResponse.takeFirstData());
      } else {
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text("${profileResponse.message}")));
      }
    }
  }

  void _editMyProfile(BuildContext context) async {
    UserProfile editProfile =
        UserProfile.fromJson(UserService().getUser().profile.toJson());
    final UserProfile editedProfile = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyProfileWidget(editProfile)),
    );
    if (null != editedProfile) {
      login(UserProfile.fromJson(editedProfile.toJson()));
    }
  }
}


