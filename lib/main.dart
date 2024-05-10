import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_table/core/services/firebase_services.dart';
import 'package:open_table/core/utils/app_text_styles.dart';
import 'package:open_table/core/utils/colors.dart';
import 'package:open_table/core/widgets/bottom_bar.dart';
import 'package:open_table/features/admin/home/nav_bar.dart';
import 'package:open_table/features/auth/presentation/view/signin_view.dart';
import 'package:open_table/features/auth/presentation/view_model/auth_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.darkScaffoldbg,
    statusBarIconBrightness: Brightness.dark,
  ));
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDW9W8nO9rSS0LS0nwztJ7hGygnSpjdASY',
          appId: 'com.example.open_table',
          messagingSenderId: '1014756748005',
          projectId: 'open-table-27826'));
  FirebaseServices.init();
  runApp(const HotelBooking());
}

class HotelBooking extends StatefulWidget {
  const HotelBooking({super.key});

  @override
  State<HotelBooking> createState() => _HotelBookingState();
}

class _HotelBookingState extends State<HotelBooking> {
  User? user;
  String? role;
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    role = user?.photoURL;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        title: 'open_table',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
          scaffoldBackgroundColor: AppColors.darkScaffoldbg,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.darkScaffoldbg,
            foregroundColor: AppColors.primary,
            titleTextStyle:
                getbodyStyle(fontSize: 20, color: AppColors.primary),
            centerTitle: true,
          ),
          datePickerTheme: DatePickerThemeData(
              backgroundColor: AppColors.darkScaffoldbg,
              headerBackgroundColor: AppColors.primary,
              headerForegroundColor: AppColors.bottomBarColor),
          colorScheme: ColorScheme.fromSeed(
            primary: AppColors.primary,
            background: AppColors.darkScaffoldbg,
            error: Colors.red,
            secondary: AppColors.shadeColor,
            onSurface: AppColors.bottomBarColor,
            seedColor: AppColors.shadeColor,
          ),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding:
                const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: AppColors.shadeColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: AppColors.shadeColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: AppColors.redColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: AppColors.redColor),
            ),
            hintStyle: getsmallStyle(),
            suffixIconColor: AppColors.primary,
            prefixIconColor: AppColors.primary,
          ),
          dividerTheme: DividerThemeData(
            color: AppColors.bottomBarColor,
            indent: 10,
            endIndent: 10,
          ),
          progressIndicatorTheme:
              ProgressIndicatorThemeData(color: AppColors.primary),
        ),
        home: (user == null)
            ? const LoginView()
            : (role == '0')
                ? const NavBarWidget()
                : const ManagerNavBarView(),
      ),
    );
  }
}
