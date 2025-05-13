import 'package:flutter/material.dart';
import 'package:shesecure/TextInputField.dart';
import 'package:shesecure/bottomnavigation/bottompage.dart';

const primaryColor = Colors.black;

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

//controllers
class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _voiceController = TextEditingController();
  final TextEditingController _emergencyContactController = TextEditingController();

  //private strings
  String? _selectedProfession;
  String? _selectedGender;

 //dropdown fields
  final List<String> _professions = ['Student', 'Job', 'Home Maker', 'Others'];
  final List<String> _genders = ['Male', 'Female', 'Others'];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _emergencyContactController.dispose();
    super.dispose();
  }

 //validation messages
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, style: const TextStyle(color: Colors.white)), backgroundColor: Colors.red),
    );
  }
  bool _validateFields() {
    if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty) {
      _showSnackbar("Please enter your full name.");
      return false;
    }
    if (_addressController.text.isEmpty) {
      _showSnackbar("Please enter a valid address.");
      return false;
    }
    if (_selectedProfession == null) {
      _showSnackbar("Please select a profession.");
      return false;
    }
    if (_voiceController.text.isEmpty) {
      _showSnackbar("Please enter a name for Voice Recognizer.");
      return false;
    }
    if (_emergencyContactController.text.isEmpty) {
      _showSnackbar("Please enter an emergency contact.");
      return false;
    }
    return true;
  }

  //submit buttom and Navigation
  void _submitForm() {
    if (_validateFields()) {
      _showSnackbar("Form submitted successfully!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('lib/assets/RegistrationPage.png',width: 350,height: 200,),
            SizedBox(height:10),
            const Text(
                    'Registration Page',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
            
            //form fields
            Form(
            child: SingleChildScrollView(   
                 
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                //First Name Field 
                                child:TextFormField(
                                        controller:_firstNameController ,
                                        decoration: InputDecoration(
                                        labelText: 'First Name',
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                        ),
                                        ),
                                ),
                                const SizedBox(width: 10),

                                //Last Name Field
                                Expanded(
                                  child: TextFormField(
                                        controller: _lastNameController,
                                        decoration:InputDecoration(
                                        labelText: 'Last Name',
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                        )
                                      ) ),],),
                            const SizedBox(height: 20),

                              //Address
                              TextFormField(
                                  controller: _addressController,
                                  decoration: InputDecoration(
                                  labelText: 'Address',
                                  border:OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                ),
                                const SizedBox(height: 20),
                          
                           //Phone Number
                           TextFormField(
                            controller: _emergencyContactController,
                            decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            prefixIcon: Icon(Icons.person_outline_rounded)
                             ),
                            ),
                            const SizedBox(height: 20),
      
                            //Profession Selection
                            const Text("Profession", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white)),
                            DropdownButtonFormField<String>(
                              value: _selectedProfession,
                              items: _professions.map((String profession) {
                                return DropdownMenuItem<String>(
                                  value: profession,
                                  child: Text(profession),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedProfession = newValue;
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                hintText: 'Select your profession',
                              ),
                            ),
                            const SizedBox(height: 20),
                            
                            //Gender Selection
                            DropdownButtonFormField<String>(
                              value: _selectedGender,
                              items: _genders.map((String gender) {
                                return DropdownMenuItem<String>(
                                  value: gender,
                                  child: Text(gender),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedGender = newValue;
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                hintText: 'Select your gender',
                              ),
                            ),
                            const SizedBox(height: 20),

                            //Voive Recognizer Name  
                            TextFormField(
                              controller: _voiceController,
                              decoration: InputDecoration(
                              labelText: 'Voice Recognizer',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              prefixIcon: Icon(Icons.mic)
                            ),
                            ),
                            const SizedBox(height: 32),
                            
                            //submit Button
                            ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple,
                                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    ),
                                    onPressed:(){
                                      Navigator.push(context, MaterialPageRoute(builder:(context)=>MyHomePage()));
                                    },
                                    child: const Text('Submit', style: TextStyle(color: Colors.white, fontSize: 16)),
                                  ),


],),), ),]),),);}}
