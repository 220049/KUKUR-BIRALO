import 'package:flutter/material.dart';
import 'package:n_baz/models/user_model.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/global_ui_viewmodel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

  bool _obscureTextPassword = true;
  bool _obscureTextPasswordConfirm = true;

  late GlobalUIViewModel _ui;
  late AuthViewModel _authViewModel;

  @override
  void initState() {
    _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    _populateFields();
    super.initState();
  }

  void _populateFields() {
    final currentUser = _authViewModel.loggedInUser;
    if (currentUser != null) {
      _nameController.text = currentUser.name ?? '';
      _phoneNumberController.text = currentUser.phone ?? '';
      _usernameController.text = currentUser.username ?? '';
    }
  }

  void updateProfile() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }
    _ui.loadState(true);
    try {
      await _authViewModel.updateProfile(
        UserModel(
          name: _nameController.text,
          phone: _phoneNumberController.text,
          username: _usernameController.text,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(err.toString())),
      );
    }
    _ui.loadState(false);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.email,
                      color: Colors.black,
                      size: 22.0,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      _authViewModel.loggedInUser!.email.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),



              const SizedBox(height: 10),
              TextFormField(
                controller: _nameController,
                validator: ValidateSignup.name,
                keyboardType: TextInputType.name,
                style: const TextStyle(
                  fontFamily: 'WorkSansSemiBold',
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneNumberController,
                validator: ValidateSignup.phone,
                keyboardType: TextInputType.phone,
                style: const TextStyle(
                  fontFamily: 'WorkSansSemiBold',
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: const Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _usernameController,
                validator: ValidateSignup.username,
                keyboardType: TextInputType.text,
                style: const TextStyle(
                  fontFamily: 'WorkSansSemiBold',
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: const Icon(Icons.verified_user),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateProfile,
                child: const Text(
                  'Update Profile',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ValidateSignup {
  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required";
    }

    final specialCharactersRegex = RegExp(r"[^a-zA-Z\s]");
    if (specialCharactersRegex.hasMatch(value)) {
      return "Name should not contain special characters or numbers";
    }

    final words = value.split(" ");
    for (var word in words) {
      if (word.isNotEmpty && !_startsWithCapitalLetter(word)) {
        return "Each word should start with a capital letter";
      }
      if (word.length > 1 && !_isLowerCase(word.substring(1))) {
        return "Other letters in each word should be lowercase";
      }
    }

    return null;
  }

  static bool _startsWithCapitalLetter(String word) {
    final firstLetter = word.substring(0, 1);
    return firstLetter == firstLetter.toUpperCase();
  }

  static bool _isLowerCase(String word) {
    return word == word.toLowerCase();
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }

    final validNumberRegex = RegExp(r"^9\d{9}$");
    if (!validNumberRegex.hasMatch(value)) {
      return "Please enter a valid 10-digit phone number starting with 9";
    }

    return null;
  }

  static String? username(String? value) {
    if (value == null || value.isEmpty) {
      return "Username is required";
    }

    final validUsernameRegex = RegExp(r"^[a-z0-9]+$");
    if (!validUsernameRegex.hasMatch(value)) {
      return "Use a single word with small letters and numbers only";
    }

    if (value.length < 3) {
      return "Username should have at least 3 letters";
    }

    return null;
  }
}
