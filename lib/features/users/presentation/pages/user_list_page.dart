import 'package:clean_architecture/core/theme/theme_bloc.dart';
import 'package:clean_architecture/core/theme/theme_event.dart';
import 'package:clean_architecture/core/theme/theme_state.dart';
import 'package:clean_architecture/features/users/presentation/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture/features/users/presentation/bloc/user_bloc.dart';
import 'package:clean_architecture/features/users/presentation/bloc/user_event.dart';
import 'package:clean_architecture/features/users/presentation/bloc/user_state.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().add(const FetchUserEvent());
    return Scaffold(
      appBar: AppBar(title: const Text("Users List"),
      actions: [
         Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return ToggleButtons(
                  isSelected: [
                    // themeController.value == ThemeMode.light,
                    // themeController.value == ThemeMode.dark,
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
                      //themeController.setLight();
                      context.read<ThemeBloc>().add(SetLightTheme());
                    } else {
                      //themeController.setDark();
                      context.read<ThemeBloc>().add(SetDarkTheme());
                    }
                  },
                );
              },
            ),
          ),
      ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserErrorState) {
            return Center(child: Text(state.message));
          } else if (state is UserLoadedState) {
            final users = state.users;
            if (users.isEmpty) return const Center(child: Text("No users found"));

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: users.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 16),
                    title: Text(user.username ?? 'No username',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email: ${user.email ?? 'N/A'}"),
                        Text("Password: ${user.password ?? 'N/A'}"),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SignupPage(
                                  isEdit: true,
                                  user: user,
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                        
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

