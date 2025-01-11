import 'package:budget_buddy/screens/auth/components/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

import '../../blocs/sign_in_bloc/sign_in_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
	final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
	bool signInRequired = false;
	IconData iconPassword = CupertinoIcons.eye_fill;
	bool obscurePassword = true;
	String? _errorMsg;
	
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
			listener: (context, state) {
				if(state is SignInSuccess) {
					setState(() {
					  signInRequired = false;
					});
				} else if(state is SignInProcess) {
					setState(() {
					  signInRequired = true;
					});
				} else if(state is SignInFailure) {
					setState(() {
					  signInRequired = false;
						_errorMsg = 'Invalid credentials. Please try again!';
					});
				}
			},
			child: Form(
					key: _formKey,
					child: Column(
						children: [
							const SizedBox(height: 20),
							SizedBox(
								width: MediaQuery.of(context).size.width * 0.85,
								child: MyTextField(
									controller: emailController,
									hintText: 'Email',
									obscureText: false,
									keyboardType: TextInputType.emailAddress,
									prefixIcon: const Icon(Icons.mail, color: Color.fromARGB(255, 72, 72, 72),),
									errorMsg: _errorMsg,
									validator: (val) {
										if (val!.isEmpty) {
											return 'Please fill in this field!';
										} else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(val)) {
											return 'Please enter a valid email!';
										}
										return null;
									}
								)
							),
							const SizedBox(height: 15),
							SizedBox(
								width: MediaQuery.of(context).size.width * 0.85,
								child: MyTextField(
									controller: passwordController,
									hintText: 'Password',
									obscureText: obscurePassword,
									keyboardType: TextInputType.visiblePassword,
									prefixIcon: const Icon(Icons.lock, color: Color.fromARGB(255, 72, 72, 72)),
									errorMsg: _errorMsg,
									validator: (val) {
										if (val!.isEmpty) {
											return 'Please fill in this field!';
										} else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$').hasMatch(val)) {
											return 'Please enter a valid password!';
										}
										return null;
									},
									suffixIcon: IconButton(
										onPressed: () {
											setState(() {
												obscurePassword = !obscurePassword;
												if(obscurePassword) {
													iconPassword = Icons.display_settings;
												} else {
													iconPassword = Icons.remove_red_eye_sharp;
												}
											});
										},
										icon: Icon(iconPassword),
									),
								),
							),
							const SizedBox(height: 25),
							!signInRequired
								? SizedBox(
										width: MediaQuery.of(context).size.width * 0.4,
										child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                            Theme.of(context).colorScheme.tertiary,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<SignInBloc>().add(SignInRequired(
                              emailController.text,
                              passwordController.text)
                            );
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                          child: Text(
                            'Log In',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        )
                      ),
                    ),
									)
							: const CircularProgressIndicator(),
						],
					)
				),
		);
  }
}