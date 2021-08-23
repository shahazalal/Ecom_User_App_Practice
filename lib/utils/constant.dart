const emptyTextFieldMsg = 'This field must not be empty';
const takaSymbol = '৳';

class PaymentMethod {
  static final String cod = 'Cash On Delivery';
  static final String online = 'Online Payment';
}

class OrderStatus {
  static final String pending = 'Pending';
  static final String delivered = 'Delivered';
  static final String cancelled = 'Cancelled';
}
