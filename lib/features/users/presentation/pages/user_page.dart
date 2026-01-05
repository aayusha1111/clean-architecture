import 'package:clean_architecture/core/theme/theme_bloc.dart';
import 'package:clean_architecture/core/theme/theme_event.dart';
import 'package:clean_architecture/core/theme/theme_state.dart';
import 'package:clean_architecture/features/users/presentation/bloc/user_bloc.dart';
import 'package:clean_architecture/features/users/presentation/bloc/user_event.dart';
import 'package:clean_architecture/features/users/presentation/bloc/user_state.dart';
import 'package:clean_architecture/features/users/presentation/pages/user_list_page.dart';
import 'package:clean_architecture/widget/custom_elevated_button.dart';
import 'package:clean_architecture/widget/custom_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/user_entity.dart';

class SignupPage extends StatefulWidget {
  final bool isEdit; 
  final UserEntity? user; 

  const SignupPage({super.key, this.isEdit = false, this.user});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.user != null) {
      username = widget.user!.username ?? '';
      email = widget.user!.email ?? '';
      password = widget.user!.password ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isEdit ? 'Edit User' : 'Sign Up'),
      actions: [
         Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return ToggleButtons(
                  isSelected: [
                    state.themeMode == ThemeMode.light,
                    state.themeMode == ThemeMode.dark,
                  ],
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(Icons.light_mode),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(Icons.dark_mode),
                    ),
                  ],
                  onPressed: (index) {
                    if (index == 0) {
                      context.read<ThemeBloc>().add(SetLightTheme());
                    } else {
                      context.read<ThemeBloc>().add(SetDarkTheme());
                    }
                  },
                );
              },
            ),
          ),
      ],),
      body: SafeArea(
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserCreatedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              if(widget.isEdit){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>UsersListPage()));
               }
               else{
                Navigator.push(context, MaterialPageRoute(builder: (_)=>UsersListPage()));
               }
            } else if (state is UserErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextformfield(
                      labelText: 'Username',
                      onChanged: (value) => username = value,
                      initialValue: username, 
                      validator: (value) {
                        if (value!.isEmpty) return 'Enter username';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextformfield(
                      labelText: 'Email',
                      onChanged: (value) => email = value,
                      initialValue: email, 
                      validator: (value) {
                        if (value!.isEmpty) return 'Enter email';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextformfield(
                      labelText: 'Password',
                      onChanged: (value) => password = value,
                      initialValue: password, 
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.visibility_off),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return 'Enter password';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    state is UserLoadingState
                        ? const CircularProgressIndicator()
                        : CustomElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (widget.isEdit) {
                                  
                                  context.read<UserBloc>().add(
                                        UpdateUserEvent(
                                          UserEntity(
                                            id: widget.user!.id,
                                            username: username,
                                            email: email,
                                            password: password,
                                          ),
                                        ),
                                      );
                                } else {
                            
                                  context.read<UserBloc>().add(
                                        PostUserEvent(
                                          UserEntity(
                                            username: username,
                                            email: email,
                                            password: password,
                                          ),
                                        ),
                                      );
                                }
                                
                              }
                            },
                            child: Text(widget.isEdit ? 'Update' : 'Sign Up'),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
