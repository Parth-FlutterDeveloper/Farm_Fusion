import 'package:farm_booking_app/Common%20Widget/button_widget.dart';
import 'package:farm_booking_app/Services/stripe_service.dart';
import 'package:farm_booking_app/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Services/shared_preference.dart';

class BookingScreen extends StatefulWidget {
  final Map<String, dynamic> farmIdPrice;
  const BookingScreen({
    super.key,
    required this.farmIdPrice
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {

  bool loading = false;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final numOfDayController = TextEditingController();
  String? _selectedDate;
  String? _selectedTime;
  final _formKey = GlobalKey<FormState>();

  late String farmId,farmPrice;

  String? userId, userEmail;
  SharedPreferenceHelper spHelper = SharedPreferenceHelper();

  // String amount = (double.parse('50') * 100).toStringAsFixed(0);
  String amount = '5000';
  String currency = 'USD';


  getDataFromSPHelper() async {
    userId = await spHelper.getUserId();
    userEmail = await spHelper.getUserEmail();
    setState(() {
      print("USER iiiiiiiiiiiiiiiiiiiiiiddddddddddddd : $userId");
      print("USER iiiiiiiiiiiiiiiiiiiiiiddddddddddddd : $userEmail");
    });
  }

  int calculateTotalPrice() {
    final numOfDays = int.tryParse(numOfDayController.text) ?? 0;
    final pricePerDay = int.tryParse(farmPrice) ?? 0;
    return numOfDays * pricePerDay;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    farmId = widget.farmIdPrice['id'];
    farmPrice = widget.farmIdPrice['price'];
    getDataFromSPHelper();
    // Detect number all time changed by the user in field
    numOfDayController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade300,
        title: Text("Booking",style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: "LocalFont",
            color: Colors.black,
            letterSpacing: 1.5
        ),),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Enter Name",
                      filled: true,
                      fillColor: Colors.green.shade50,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11)
                      ),
                    ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Please enter name";
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixText: userEmail,
                      labelText: userEmail,
                      filled: true,
                      fillColor: Colors.green.shade50,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11)
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _selectedDate = "${pickedDate.toLocal()}".split(' ')[0];
                      });
                    }
                  },
                  child: Container(
                    width: Get.width,
                    margin: EdgeInsets.only(left: 15,right: 15),
                    padding: EdgeInsets.symmetric(vertical: 18,horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.black54),
                    ),
                    child: Text(
                      _selectedDate == null ? 'Select Date' : _selectedDate!,
                      style: _selectedDate == null ? TextStyle(
                          fontSize: 16
                      ) : TextStyle(
                          fontSize: 16,
                        letterSpacing: 1.5
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        _selectedTime = pickedTime.format(context);
                      });
                    }
                  },
                  child: Container(
                    width: Get.width,
                    margin: EdgeInsets.only(left: 15,right: 15),
                    padding: EdgeInsets.symmetric(vertical: 18,horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.black54),
                    ),
                    child: Text(
                      _selectedTime == null ? 'Select Time' : _selectedTime!,
                      style: _selectedTime == null ? TextStyle(
                          fontSize: 16
                      ) : TextStyle(
                          fontSize: 16,
                          letterSpacing: 1.5
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                      controller: numOfDayController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Enter Number of Days",
                        suffixText: "day",
                        filled: true,
                        fillColor: Colors.green.shade50,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11)
                        ),
                      ),
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Please enter number of days";
                        }
                        return null;
                      },
                    ),
                ),

                SizedBox(height: 110),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Price / Day',style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade900,
                          fontFamily: "LocalFont",
                          letterSpacing: 1
                      ),),
                      Text('₹ $farmPrice',style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade900,
                          fontFamily: "LocalFont",
                          letterSpacing: 1
                      ),),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Price',style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade900,
                          fontFamily: "LocalFont",
                          letterSpacing: 1
                      ),),
                      Text('₹ ${calculateTotalPrice()}',style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade900,
                          fontFamily: "LocalFont",
                          letterSpacing: 1
                      ),),
                    ],
                  ),
                ),

                SizedBox(height: 30),
                Center(
                  child: ButtonWidget(
                      text: "Pay now",
                      width: 1.2,
                      onTap: () async {
                        setState(() {
                          loading = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          if (_selectedTime == null || _selectedDate == null) {
                            Utils().redToastMessage("Please enter Date & Time");
                            setState(() {
                              loading = false;
                            });
                          } else {
                            // Get.toNamed(RoutesName.phonePePayment);
                            try{
                              await StripeService.initPaymentSheet(amount, currency);
                              await StripeService.presentPaymentSheet();
                              setState(() {
                                loading = false;
                              });
                            }catch(error){
                              Utils().redToastMessage("Error is : $error");
                              setState(() {
                                loading = false;
                              });
                            }
                          }
                        }
                      },
                      loading: loading,
                      backColor: Colors.green,
                      txtColor: Colors.white
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
