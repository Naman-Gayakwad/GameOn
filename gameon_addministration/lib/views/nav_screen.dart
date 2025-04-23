import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:gameon_addministration/views/screens/banner/upload_banner_screen.dart';
import 'package:gameon_addministration/views/screens/competitions/local/Localcompetition.dart';
import 'package:gameon_addministration/views/screens/competitions/national/nationalcompetition.dart';
import 'package:gameon_addministration/views/screens/dashboard/dashboard_screen.dart';
import 'package:gameon_addministration/views/screens/mentor/mentor.dart';
import 'package:gameon_addministration/views/screens/store/upload_product.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedItem = DashboardScreen();

  screenSlector(item) {
    switch (item.route) {
      case DashboardScreen.routeName:
        setState(() {
          _selectedItem = DashboardScreen();
        });
        break;

      case UploadBannerScreen.routeName:
        setState(() {
          _selectedItem = UploadBannerScreen();
        });
        break;
      
      case Mentor.routeName:
        setState(() {
          _selectedItem = Mentor();
        });
        break;
      
      case UploadProduct.routeName:
        setState(() {
          _selectedItem = UploadProduct();
        });
        break;
      case Localcompetition.routeName:
        setState(() {
          _selectedItem = Localcompetition();
        });
        break;
      case NationalCompetition.routeName:
        setState(() {
          _selectedItem = NationalCompetition();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        title: Text('Management'),
      ),
      sideBar: SideBar(
        items: [
          AdminMenuItem(
            title: 'Dashboard',
            icon: Icons.dashboard,
            route: DashboardScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Upload Banners',
            icon: CupertinoIcons.add,
            route: UploadBannerScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Mentor',
            icon: Icons.person,
            route: Mentor.routeName,
          ),
          AdminMenuItem(
            title: 'Upload Product',
            icon: Icons.upload_file,
            route: UploadProduct.routeName,
          ),
          AdminMenuItem(
            title: 'Local Competition',
            icon: Icons.emoji_events_rounded ,
            route: Localcompetition.routeName,
          ),
          AdminMenuItem(
            title: 'National Competition',
            icon: Icons.emoji_events_rounded,
            route: NationalCompetition.routeName,
          ),
        ],
        selectedRoute: '',
        onSelected: (item) {
          screenSlector(item);
        },
      ),
      body: _selectedItem,
    );
  }
}
