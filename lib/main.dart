import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/bloc_observer.dart';
import 'package:posts_app/core/theme/app_theme.dart';
import 'package:posts_app/features/posts/presentation/bloc/add_delete_update/add_delete_update_bloc.dart';
import 'package:posts_app/features/posts/presentation/bloc/get_refresh/get_refresh_bloc.dart';
import 'features/posts/presentation/pages/posts_page.dart';
import 'injections_container.dart' as di;

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => di.sl<GetRefreshBloc>()..add(GetAllPostsEvent())),
        BlocProvider(create: (_) => di.sl<AddDeleteUpdateBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PostsPage(),
        theme: theme,
      ),
    );
  }
}
