import 'package:clot/features/auth/data/firebase_auth_repository.dart';
import 'package:clot/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clot/features/products/data/firebase_products_repository.dart';
import 'package:clot/features/products/presentation/bloc/product_bloc.dart';
import 'package:clot/features/products/presentation/category_bloc/category_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final appBlocProvider = [
  BlocProvider<AuthBloc>(
    create: (context) =>
        AuthBloc(authRepository: FirebaseAuthRepository())
          ..add(AuthStatusChecked()),
  ),
  // product
  BlocProvider<ProductBloc>(
    create: (context) =>
        ProductBloc(productRepository: FirebaseProductsRepository())
          ..add(LoadCategories()),
  ),

  BlocProvider<CategoryBloc>(
    create: (context) => CategoryBloc(
      // productRepository: FirebaseProductsRepository(),
      repository: FirebaseProductsRepository(),
    )..add(LoadAllCategoriesForBrowsing()),
  ),
];
