class CustomerModel {
  String? customerId;
  String? customerName;
  String? customerAddress;
  String? customerPhone;
  String? customerEmail;

  CustomerModel(
      {this.customerId,
      this.customerName,
      this.customerAddress,
      this.customerPhone,
      this.customerEmail});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'customerId': customerId,
      'customerName': customerName,
      'customerAddress': customerAddress,
      'customerPhone': customerPhone,
      'customerEmail': customerEmail,
    };
    return map;
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) => CustomerModel(
        customerId: map['customerId'],
        customerName: map['customerName'],
        customerAddress: map['customerAddress'],
        customerPhone: map['customerPhone'],
        customerEmail: map['customerEmail'],
      );

  @override
  String toString() {
    return 'CustomerModel{customerId: $customerId, customerName: $customerName, customerAddress: $customerAddress, customerPhone: $customerPhone, customerEmail: $customerEmail}';
  }
}
