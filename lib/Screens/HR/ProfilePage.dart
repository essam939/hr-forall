import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hr/Component/Citys.dart';
import 'package:hr/Component/CustomImagePicker.dart';
import 'package:hr/Component/TextFormInput.dart';
import 'package:hr/Provider/Colors.dart';
import 'package:hr/Screens/HR/Home%20HR.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController
  fNameController,lNameController,mNameController,iDNumberController,
  phoneNumberController,emailController,idNumberController,passportNumberController,
  phoneController,dateController,passwordController,collageMajorController,
  gpaController,jobTitleController,companyNameController,bankController,
  accountNumberController,ibaNNumberController = new TextEditingController();
  String dropdownValue=City.cities[0].keys.elementAt(0);
  String dropdownValue2;
  final _formKey = GlobalKey<FormState>();
  var date="1980-1-1";
  File _image,userId,cv,certification;
  String userIdString="ID.Jpg",cvString="Ahmed.pdf",certificationString="Certification";
  bool male=true,female=false,single=true,married=false;
  List<String>city=[];
  @override
  void initState() {
    dropdownValue2=City.cities[0][dropdownValue].elementAt(0);
    //looping in class and add data  to list
    for(int i=0;i<City.cities.length;i++){city.addAll(City.cities[0].keys);}
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar("Profile"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key:_formKey,
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _image == null?
                          CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.blue,
                            backgroundImage: NetworkImage("https://cdn0.iconfinder.com/data/icons/avatars-6/500/Avatar_boy_man_people_account_client_male_person_user_work_sport_beard_team_glasses-512.png"),
                          ):
                          CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.blue,
                            backgroundImage: FileImage(_image),
                          ),
                        ],
                      ),
                      onTap: ()async{
                         _image=await showAlert(context);
                         setState(() {});
                      },
                    ),
                    buildTextFormField("First Name",20,TextInputType.text,fNameController,true,null,null,null,customValidation),
                    buildTextFormField("Middle Name",20,TextInputType.text,mNameController),
                    buildTextFormField("family Name",20,TextInputType.text,lNameController),
                    buildTextFormField("E-Mail",20,TextInputType.emailAddress,emailController),
                    buildDropdownButton(city, (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                        dropdownValue2=null;
                      });
                    },dropdownValue),
                    buildDropdownButton(City.cities[0][dropdownValue], (String newValue) {
                      setState(() {
                        dropdownValue2 = newValue;
                      },);
                    },dropdownValue2),
                    buildTextFormField("ID Number",20,TextInputType.number,idNumberController),
                    buildTextFormField("Passport Number",20,TextInputType.number,passportNumberController),
                    InkWell(child: buildTextFormField("$date",20,TextInputType.text,passwordController,false,Icons.today),
                    onTap: (){
                      DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(1980, 1, 1),
                        maxTime: DateTime.now(),
                          onChanged:(data){
                        setState(() {
                          date=data.toIso8601String().split("T00:00:00.000")[0];
                        });
                          },
                        onConfirm: (data){},
                      );
                    },),
                    Row(
                      children: <Widget>[
                        Expanded( flex: 1, child: InkWell(child:
                        CountryCodePicker(
                          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                        initialSelection: 'EG',
                          favorite: ['+2','EG','+966','SAR'],
                          // optional. Shows only country name and flag
                          showCountryOnly: false,
                          // optional. Shows only country name and flag when popup is closed.
                          //   showOnlyCountryCodeWhenClosed: false,
                          // optional. aligns the flag and the Text left
                          alignLeft: false,
                        ),
                        ),
                        ),
                        Expanded(flex: 4, child: buildTextFormField(" Phone Number",20,TextInputType.number,phoneController)),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text("Gender",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: male,
                          onChanged: (bool value){
                            setState(() {
                              female=false;male=true;
                            });
                          },
                        ),
                        Text("Male"),
                        SizedBox(width: 20,),
                        Checkbox(
                          value: female,
                          onChanged: (bool value){
                            setState(() {
                                male=false;female=true;
                            });
                          },
                        ),
                        Text("Famle"),
                      ],
                    ),
                    Text("Marital Status:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: single,
                          onChanged: (bool value){
                            setState(() {
                              married=false;single=true;
                            });
                          },
                        ),
                        Text("Single"),
                        SizedBox(width: 12,),
                        Checkbox(
                          value: married,
                          onChanged: (bool value){
                            setState(() {
                              single=false;married=true;
                            });
                          },
                        ),
                        Text("Married"),
                      ],
                    ),
                    buildTextFormField("Collage Major",20,TextInputType.text,collageMajorController),
                    buildTextFormField("GPA",20,TextInputType.text,gpaController),
                    buildTextFormField("Last Job Title",20,TextInputType.text,jobTitleController),
                    buildTextFormField("Company Name",20,TextInputType.text,companyNameController),
                 Row(
                   children: <Widget>[
                     Expanded(flex: 4,
                       child:buildTextFormField("Start Date",4,TextInputType.number,passwordController,null,null,"10/2019"),
                     ),
                     Spacer(flex: 1,),
                     Expanded(flex: 4,
                       child:buildTextFormField("End Date",4,TextInputType.number,passwordController,null,null,"10/2020"),
                     )
                   ],
                 ),
                    buildTextFormField("Bank Name",20,TextInputType.text,bankController),
                    buildTextFormField("Account Number",20,TextInputType.number,accountNumberController),
                    buildTextFormField("iban Number",20,TextInputType.number,ibaNNumberController),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("$userIdString"),
                        ButtonTheme(
                          minWidth: 20,
                          height: 20,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: ColorsProvider().grayColor)
                          ),
                          child: RaisedButton(
                            onPressed: ()async{
                              // ignore: missing_return
                              userId=await showAlert(context).then((res){
                                userIdString=res.path.substring(res.path.lastIndexOf("/")+1);
                              });
                              setState(() {});
                            },
                            color: ColorsProvider().grayColor,
                            child: Text("CHANGE",style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("$certificationString"),
                        ButtonTheme(
                          minWidth: 20,
                          height: 20,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: ColorsProvider().grayColor)
                          ),

                          child: RaisedButton(
                            onPressed: ()async{
                              // ignore: missing_return
                              certification=await showAlert(context).then((res){
                                certificationString=res.path.substring(res.path.lastIndexOf("/")+1);
                              });
                              setState(() {});
                            },
                            color: ColorsProvider().grayColor,
                            child: Text("CHANGE",style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("$cvString"),
                        ButtonTheme(
                          minWidth: 20,
                          height: 20,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: ColorsProvider().grayColor)
                          ),
                          child: RaisedButton(
                            onPressed: ()async{
                              // ignore: missing_return
                              cv = await FilePicker.getFile(type: FileType.CUSTOM,fileExtension: "pdf").then((res){
                                cvString=res.path.substring(res.path.lastIndexOf("/")+1);
                              });
                              setState(() {});
                            },
                            color: ColorsProvider().grayColor,
                            child: Text("CHANGE",style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width /1.2,
                          height: 45,
                          child: RaisedButton(
                            onPressed: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()));
                              //if (_formKey.currentState.validate()){}
                            },
                            color: ColorsProvider().primary,
                            child: Text("Save",style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ],),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
  String customValidation(dynamic value) {
    if (value.isEmpty ||
        !RegExp("^[0-9]{3}").hasMatch(value)) {
      return null;
    }
    return 'Email is not valid';
  }
}
