// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../viewmodels/auth_viewmodel.dart';
//
// class ChangePasswordScreen extends StatefulWidget {
//   const ChangePasswordScreen({Key? key}) : super(key: key);
//
//   @override
//   _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
// }
//
// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   TextEditingController _passwordController = TextEditingController();
//   TextEditingController _confirmPasswordController = TextEditingController();
//
//   bool _obscureTextPassword = true;
//   bool _obscureTextPasswordConfirm = true;
//
//   late AuthViewModel _authViewModel;
//
//   @override
//   void initState() {
//     super.initState();
//     _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
//   }
//
//   void updatePassword() async {
//     // Check if the passwords match and meet the criteria
//     if (_passwordController.text != _confirmPasswordController.text) {
//       // Show error message if passwords don't match
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Error'),
//           content: const Text("Passwords don't match"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
//       return;
//     }
//
//     if (_passwordController.text.length < 8) {
//       // Show error message if password is less than 8 characters
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Error'),
//           content: const Text('Password should be at least 8 characters'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
//       return;
//     }
//
//     // Update the password
//     final success = await _authViewModel.updatePassword(_passwordController.text);
//     if (success) {
//       // Password updated successfully
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Success'),
//           content: const Text('Password updated successfully'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 Navigator.pop(context); // Go back to the previous screen
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
//     } else {
//       // Show error message if password update failed
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Error'),
//           content: const Text('Failed to update password'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   void cancelChangePassword() {
//     Navigator.pop(context); // Go back to the previous screen
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Change Password'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextFormField(
//               controller: _passwordController,
//               obscureText: _obscureTextPassword,
//               style: const TextStyle(
//                 fontFamily: 'WorkSansSemiBold',
//                 fontSize: 16.0,
//                 color: Colors.black,
//               ),
//               decoration: InputDecoration(
//                 labelText: 'New Password',
//                 prefixIcon: const Icon(Icons.lock),
//                 suffixIcon: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _obscureTextPassword = !_obscureTextPassword;
//                     });
//                   },
//                   child: Icon(
//                     _obscureTextPassword ? Icons.visibility : Icons.visibility_off,
//                     size: 20.0,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextFormField(
//               controller: _confirmPasswordController,
//               obscureText: _obscureTextPasswordConfirm,
//               style: const TextStyle(
//                 fontFamily: 'WorkSansSemiBold',
//                 fontSize: 16.0,
//                 color: Colors.black,
//               ),
//               decoration: InputDecoration(
//                 labelText: 'Confirm Password',
//                 prefixIcon: const Icon(Icons.lock_clock),
//                 suffixIcon: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _obscureTextPasswordConfirm = !_obscureTextPasswordConfirm;
//                     });
//                   },
//                   child: Icon(
//                     _obscureTextPasswordConfirm ? Icons.visibility : Icons.visibility_off,
//                     size: 20.0,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: updatePassword,
//               child: const Text(
//                 'Update Password',
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: cancelChangePassword,
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.red, // Set the button color to red
//               ),
//               child: const Text(
//                 'Cancel',
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
