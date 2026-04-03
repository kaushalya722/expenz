import 'package:expenz_app/constance/colors.dart';
import 'package:expenz_app/constance/constance.dart';
import 'package:expenz_app/model/expense_model.dart';
import 'package:expenz_app/model/income_model.dart';
import 'package:expenz_app/services/expence_service.dart';
import 'package:expenz_app/services/income_service.dart';
import 'package:expenz_app/widgets/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewScreen extends StatefulWidget {

  final Function (Expence) addExpence;
  final Function(Income) addIncome;
  const AddNewScreen({super.key, required this.addExpence, required this.addIncome});

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {

  //state to track expence or income
  int _selectedMethod = 0;

   ExpenceCategory _expenceCategory = ExpenceCategory.health;
   IncomeCategory _incomeCategory = IncomeCategory.salary;
   final TextEditingController _titleController = TextEditingController();
   final TextEditingController _descriptionController = TextEditingController();
   final TextEditingController _amountController = TextEditingController();
   DateTime _selectedDate = DateTime.now();
   DateTime _selectedTime = DateTime.now();



   @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedMethod == 0 ? kRed : kGreen,
      body: SafeArea(
        child:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaulPadding),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(kDefaulPadding),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      color: kWhite, 
                      borderRadius: BorderRadius.circular(100)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMethod = 0;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedMethod == 0 ? kRed : kWhite, 
                              borderRadius: BorderRadius.circular(100)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 10),
                              child: Text("Expense", 
                              style: TextStyle(
                                fontSize: 16, 
                                fontWeight: FontWeight.w500,
                                color: _selectedMethod == 0 ? kWhite : kBlack,
                                ),),
                            )),
                        ),
                  
                  
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedMethod = 1;
                              });
                            },
                            child: Container(
                            decoration: BoxDecoration(
                              color: _selectedMethod == 1 ? kGreen : kWhite,  
                              borderRadius: BorderRadius.circular(100)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 10),
                              child: Text("Income", 
                              style: TextStyle(
                                fontSize: 16, 
                                fontWeight: FontWeight.w500,
                                color: _selectedMethod == 1 ? kWhite : kBlack,
                                ),),
                            )),
                          ),
                        
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kDefaulPadding, vertical: 20),
                  child: Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("How Much?", style: TextStyle(color: kLightGrey.withOpacity(0.8), fontSize: 18, fontWeight: FontWeight.w600),),
                        TextField(
                          style: TextStyle(
                            fontSize: 60,
                            color: kWhite,
                            fontWeight: FontWeight.bold
                          ),
                          decoration: InputDecoration(
                            hintText: "0",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: kWhite, fontSize: 60,fontWeight: FontWeight.w500)
                          ),
                          ),
                      ],
                    ),
                  ),
                ),
                // user data form
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.3,
                  ),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)
                     )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      child: Column(
                        children: [
                          // category selected dropdown
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100)
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: kDefaulPadding, horizontal: 20)
                            ),
                            items: _selectedMethod == 0 ? ExpenceCategory.values.map((category){
                              return DropdownMenuItem(
                                value: category,
                                child: Text(category.name),
                                );
                            }).toList() 
                            : IncomeCategory.values.map((category){
                              return DropdownMenuItem(
                                value: category,
                                child: Text(category.name),
                                );
                            }).toList() ,

                            value : _selectedMethod == 0 ? _expenceCategory : _incomeCategory,
                            onChanged: (value) {
                             setState(() {
                               _selectedMethod == 0 ? _expenceCategory = value as ExpenceCategory : _incomeCategory = value as IncomeCategory;
                             });
                            },
                              
                            ),
                            const SizedBox(height: 20,),
                            //title feild
                            TextFormField(
                              controller: _titleController,
                              decoration: InputDecoration(
                                hintText: "Title",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  
                                ),
                                 contentPadding: EdgeInsets.symmetric(vertical: kDefaulPadding, horizontal: 20)
                              ),
                            ),
                            const SizedBox(height: 20,),
                            TextFormField(
                              controller: _descriptionController,
                              decoration: InputDecoration(
                                hintText: "Description",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  
                                ),
                                 contentPadding: EdgeInsets.symmetric(vertical: kDefaulPadding, horizontal: 20)
                              ),
                            ),
                             const SizedBox(height: 20,),
                            TextFormField(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Amount",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  
                                ),
                                 contentPadding: EdgeInsets.symmetric(vertical: kDefaulPadding, horizontal: 20)
                              ),
                            ),
                            const SizedBox(height: 20,),
                            //date picker
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDatePicker(context: context, 
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2026), 
                                    lastDate: DateTime(2030)
                                    ).then((value){
                                       if(value != null){
                                         setState(() {
                                           _selectedDate = value;
                                         });
                                       }}
                                    ) ;
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: kMainColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                                      child: Row(
                                        children: [
                                          Icon(Icons.calendar_month_outlined, color: kWhite,),
                                          const SizedBox(width: 10,),
                                          Text("Select Date", style: TextStyle(color: kWhite, fontSize: 16, fontWeight: FontWeight.w500),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  DateFormat.yMMMd().format(_selectedDate),
                                  style: TextStyle(color: kGrey, fontSize: 15, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            //time picker
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showTimePicker(
                                      context: context, 
                                      initialTime: TimeOfDay.now()
                                      ).then((value) {
                                        if(value != null){
                                         setState(() {
                                            _selectedTime = DateTime(
                                            _selectedDate.year,
                                            _selectedDate.month,
                                            _selectedDate.day,
                                            value.hour,
                                            value.minute,
                                          );
                                         });
                                        }
                                      },);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: kYellow,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                                      child: Row(
                                        children: [
                                          Icon(Icons.timer, color: kWhite,),
                                          const SizedBox(width: 10,),
                                          Text("Select Time", style: TextStyle(color: kWhite, fontSize: 16, fontWeight: FontWeight.w500),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  DateFormat.jm().format(_selectedTime),
                                  style: TextStyle(color: kGrey, fontSize: 15, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Divider(
                              color: kLightGrey,
                              thickness: 3,
                            ),
                            const SizedBox(height: 20,),
                            

                            //submit button
                            GestureDetector(
                              onTap: () async{
                                //save the expences or income data into shared preferences
                                if(_selectedMethod == 0) {
                                   
                                   //adding expences
                                    List<Expence> loadedExpences = await ExpenceService().loadExpences();
                                

                                //create the expence to store
                                Expence expence =  Expence(
                                  id: loadedExpences.length + 1, 
                                  title: _titleController.text, 
                                  amount: _amountController.text.isEmpty ? 0: double.parse(_amountController.text), 
                                  category: _expenceCategory, 
                                  date: _selectedDate, 
                                  time: _selectedTime, 
                                  description: _descriptionController.text);
                               
                              //add expence
                              widget.addExpence(expence); 

                              // clear the feilds
                              _titleController.clear();
                              _amountController.clear();
                              _descriptionController.clear();
                                }else{

                                  //load incomes
                                  List<Income> loadedIncomes = await IncomeService().loadIncomes();

                                  //create the new income
                                  Income income =  Income(
                                    id: loadedIncomes.length + 1, 
                                    title: _titleController.text, 
                                    amount: _amountController.text.isEmpty ? 0 : double.parse(_amountController.text), 
                                    category: _incomeCategory, 
                                    date: _selectedDate, 
                                    time: _selectedTime, 
                                    description: _descriptionController.text);

                                    widget.addIncome(income);

                                    // clear the feilds
                              _titleController.clear();
                              _amountController.clear();
                              _descriptionController.clear();
                                }
                               
                                
                              },
                              child: CustomButton(
                                buttonName: "Add", 
                                buttonColor: _selectedMethod == 0 ? kRed : kGreen),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ) ),
    );
  }
}