import 'package:fidelyz/styles.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Palette.primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Notification',
          style: TextStyles.appBarTitle,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        children: const [
          NotificationTile(
            heading: "New Update Available!",
            icon: AssetImage("assets/new_update/updated1.png"),
          ),
          NotificationTile(
            heading: "New Update Available!",
            subHeading: "Version 2.0.1",
            icon: AssetImage("assets/new_update/updated2.png"),
          ),
          NotificationTile(
            heading: "New Update Available!",
            subHeading:
                "We've made some improvements and fixed some bugs. Update now for the best experience.",
            icon: AssetImage("assets/new_update/updated3.png"),
            description: "Version 2.0.1",
          ),
          NotificationTile(
            heading: "Summer Sale!",
            subHeading: "Up to 50% off",
            icon: AssetImage("assets/new_update/sale.png"),
            description:
                "Check out our summer collection and get up to 50% off on select items.",
            banner: AssetImage("assets/dummy-image/1.png"),
          ),
          NotificationTile(
            heading: "New Follower",
            subHeading: "John Doe started following you.",
            icon: AssetImage("assets/shop-icon/1.png"),
          ),
          NotificationTile(
            heading: "Event Reminder",
            subHeading: "Music Fest 2023",
            description:
                "Don't forget! The Music Fest 2023 starts tomorrow at 6 PM. Make sure to have your tickets ready.",
            icon: AssetImage("assets/shop-icon/1.png"),
            banner: AssetImage("assets/dummy-image/1.png"),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String? heading;
  final String? subHeading;
  final String? description;
  final ImageProvider? icon; // Changed from IconData to ImageProvider
  final ImageProvider? banner;

  const NotificationTile({
    Key? key,
    this.heading,
    this.subHeading,
    this.description,
    this.icon,
    this.banner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Card(
      color: Palette.whiteColor.withOpacity(0.08),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12).copyWith(left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: subHeading != null
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                if (icon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: icon!,
                          fit: BoxFit.cover,
                        ),
                        // borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                if (heading != null)
                  SizedBox(
                    width: width - 40 - 30 - 10 - 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(heading!, style: TextStyles.appBarTitle),
                        if (subHeading != null)
                          Text(subHeading!,
                              style: TextStyles.textFieldHintWhite),
                        if (description != null && banner == null)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child:
                                Text(description!, style: TextStyles.paraWhite),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
            if (description != null && banner != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(description!, style: TextStyles.paraWhite),
              ),
            if (banner != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 16),
                child: Container(
                  width: width - 20,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: banner!,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
