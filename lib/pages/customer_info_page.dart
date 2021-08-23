import 'package:ecom_user_app/models/customer_model.dart';
import 'package:ecom_user_app/pages/order_confirm_page.dart';
import 'package:ecom_user_app/providers/customer_provider.dart';
import 'package:ecom_user_app/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerInfoPage extends StatefulWidget {
  static final String routeName = 'customer_info';
  @override
  _CustomerInfoPageState createState() => _CustomerInfoPageState();
}

class _CustomerInfoPageState extends State<CustomerInfoPage> {
  final _searchPhoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  CustomerModel? _customerModel;
  @override
  void dispose() {
    _searchPhoneController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Customer Info'),
        ),
        body: Consumer<CustomerProvider>(
          builder: (context, provider, _) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Exiting Customer?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _searchPhoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: 'Enter Mobile Number',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            _searchCustomerByPhone(provider);
                          },
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    _customerModel == null ? 'New Customer?' : 'Edit Info',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Name'),
                            validator: (value) {
                              return null;
                            },
                            onSaved: (value) {
                              _customerModel!.customerName = value;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: _phoneController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Phone Number'),
                            validator: (value) {
                              return null;
                            },
                            onSaved: (value) {
                              _customerModel!.customerPhone = value;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Email'),
                            validator: (value) {
                              return null;
                            },
                            onSaved: (value) {
                              _customerModel!.customerEmail = value;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _addressController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Address'),
                            validator: (value) {
                              return null;
                            },
                            onSaved: (value) {
                              _customerModel!.customerAddress = value;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            child: Text('Next'),
                            onPressed: () {
                              _saveCustomerInfo(provider);
                            },
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ));
  }

  void _searchCustomerByPhone(CustomerProvider provider) async {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
    if (_searchPhoneController.text.isEmpty) {
      showMessage(context, 'Provide a Phone Number');
      return;
    }

    final customer =
        await provider.getCustomerByPhone(_searchPhoneController.text);
    setState(() {
      _customerModel = customer;
    });

    if (_customerModel != null) {
      showMessage(context, 'Found');
      setState(() {
        _nameController.text = _customerModel!.customerName!;
        _phoneController.text = _customerModel!.customerPhone!;
        _emailController.text = _customerModel!.customerEmail!;
        _addressController.text = _customerModel!.customerAddress!;
      });
    } else {
      showMessage(context, 'Not found');
      _customerModel = CustomerModel();
    }
  }

  void _saveCustomerInfo(CustomerProvider provider) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_customerModel!.customerId == null) {
        final customerId = await provider.addCustomer(_customerModel!);
        Navigator.pushNamed(context, OrderConfirmPage.routeName,
            arguments: customerId);
      } else {
        await provider.updateCustomer(_customerModel!);
        Navigator.pushNamed(context, OrderConfirmPage.routeName,
            arguments: _customerModel!.customerId);
      }
    }
  }
}
