import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_green_app/ui/views/home/widget/logout_button.dart';

import 'home_screenState.dart';
import 'home_viewmodel.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(150);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                gradient: LinearGradient(
                    colors: [Color.fromARGB(255, 33, 251, 4),Color.fromARGB(255, 187, 255, 0)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter
                )
            ),
          ),
      backgroundColor: Colors.transparent,
      toolbarHeight: 150,
      elevation: 10,
      automaticallyImplyLeading: false,
      title: SizedBox(
        height:150,
          child: Column(
            children: [
              SizedBox(height:20),
              Image.asset(
        "assets/logo.png",
        height: 100,
      ),
      // ViewModelBuilder<HomeViewmodel>.reactive(
      //       builder: (context, viewmodel, child)
      //          { return LogoutButton(viewmodel: viewmodel, state: HomeScreenfulState());},
      //       viewModelBuilder: () => HomeViewmodel(),
      //     ),
            ],
          )),
      centerTitle: true,
      actions:[
        IconButton(color:Colors.white,iconSize:30,onPressed: (){HomeScreenfulState().onLogout(HomeViewmodel());}, icon: Icon(Icons.logout)),
      ]
      
    );
  }
}
