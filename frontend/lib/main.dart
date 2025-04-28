

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/product_provider.dart';
import './screens/home_screen.dart';
import './screens/add_product_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/edit_product_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        title: 'Inventory App',
        theme: ThemeData(
          primaryColor: const Color(0xFFB497BD),
          scaffoldBackgroundColor: const Color(0xFFE6DAF0),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFB497BD),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF8E7CA8),
            foregroundColor: Colors.white,
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: const Color(0xFF8E7CA8),
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.black87),
          ),
        ),
        home: const HomeScreen(),
        routes: {
          AddProductScreen.routeName: (ctx) => const AddProductScreen(),
          ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
          EditProductScreen.routeName: (ctx) => const EditProductScreen(),

        },
      ),
    ),
  );
}

