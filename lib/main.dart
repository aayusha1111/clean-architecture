import 'package:clean_architecture/core/theme/app_theme.dart';
import 'package:clean_architecture/core/theme/theme_bloc.dart';
import 'package:clean_architecture/core/theme/theme_state.dart';
import 'package:clean_architecture/features/product/presentation/bloc/product_bloc.dart';
import 'package:clean_architecture/features/users/presentation/bloc/user_bloc.dart';
import 'package:clean_architecture/features/users/presentation/pages/user_page.dart';
import 'package:clean_architecture/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// final themeController=ThemeController();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.registerDepnedenices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>di.sl<ProductBloc>()),
        BlocProvider(create: (context)=>di.sl<UserBloc>()),
        BlocProvider(create: (context)=>ThemeBloc())
        ],
      child: BlocBuilder<ThemeBloc,ThemeState>(
        builder: (context, state) {
          return MaterialApp(
          
          title: 'Flutter Demo',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: state.themeMode,
          home: SignupPage()
          );
        },
        
      ),
    );
        }
    
    
  }


