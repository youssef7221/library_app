import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/core/utils/app_fonts.dart';
import 'package:library_app/core/utils/model/userdm.dart';
import 'package:library_app/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/core/utils/app_string.dart';
import '../../../core/flutter_secure/flutter_secure.dart';
import '../../../core/router/app_router.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState(){
    super.initState();
    navigateToHome();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: TweenAnimationBuilder(
              duration: Duration(milliseconds: 1500),  // Duration of the animation
              tween: Tween<Offset>(
                begin: Offset(0.8, 0),  // Start from the left of the screen
                end: Offset(0, 0),       // End at the center of the screen
              ),
              builder: (context, Offset offset, child) {
                return FractionallySizedBox(
                  alignment: Alignment.center,
                  child: Transform.translate(
                    offset: offset * MediaQuery.of(context).size.width, // Apply offset
                    child: child,
                  ),
                );
              },
              child: Image.asset(
                AppImages.logo,
                height: 180.h,
              ),
            ),
          ),
           SizedBox(
            height: 10.h,
          ),
          Center(
              // child: TweenAnimationBuilder(
              //     duration: Duration(milliseconds: 2500),  // Duration of the animation
              //     tween: Tween<Offset>(
              //       begin: Offset(-0.8, 0),  // Start from the left of the screen
              //       end: Offset(0, 0),       // End at the center of the screen
              //     ),
              //     builder: (context, Offset offset, child) {
              //       return FractionallySizedBox(
              //         alignment: Alignment.center,
              //         child: Transform.translate(
              //           offset: offset * MediaQuery.of(context).size.width, // Apply offset
              //           child: child,
              //         ),
              //       );
              //     },
                  child:Text(AppString.logoName,style:AppFonts.logoFont,).animate().fadeIn(
                    delay: Duration(milliseconds: 2000)
                  )),
          Center(
            child: Text(AppString.slogan,style: AppFonts.sloganFont,).animate()
                .fadeIn(
                delay: Duration(seconds: 3)
            ),
          )
        ],
      ),
    );
  }
  void navigateToHome(){
    Future.delayed(
      const Duration(seconds: 5),
          () async {
      UserModel? userModel = await SecureStorageManager().readData('user');
      if(userModel !=null) {
        GoRouter.of(context).replace(AppRouter.kHomeView)
      ;
      }
      else
        {
          GoRouter.of(context).replace(AppRouter.kLoginView);
        }
      },
    );
  }
}
