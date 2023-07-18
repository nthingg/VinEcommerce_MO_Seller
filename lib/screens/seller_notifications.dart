import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer2/sizer2.dart';
import 'package:vin_ecommerce/styles/color.dart';

class SellerNotificationsPage extends StatefulWidget {
  const SellerNotificationsPage({super.key});
  @override
  State<StatefulWidget> createState() => _SellerNotificationsPageState();
}

class _SellerNotificationsPageState extends State<SellerNotificationsPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    // final storage = new FlutterSecureStorage();
    // Future<String?> token = storage.read(key: 'token');
    // Object token1 = token != null? token: "";
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _appbar(),
        body: TabBarView(
          controller: tabController,
          children: [
            ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => SellerProductInfoPage(
                      //             productId: 6,
                      //           )),
                      // );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 12, left: 16),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: lightGrayBorderBottom,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Container(
                        height: 13.h,
                        child: Column(children: [
                          Row(
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, right: 16),
                                  child: CircleAvatar(
                                    radius: 4
                                        .h, // Set the desired radius for the circular image
                                    backgroundImage: AssetImage(
                                        'assets/images/default_store.png'),
                                  )),
                              Container(
                                width:
                                    200, // Set the desired width for the Column
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  'Nguyễn Ngọc Thịnh',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 4),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              'place a new order',
                                              style: TextStyle(
                                                  color: secondaryTextColor,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 8),
                                      child: Row(
                                        children: [
                                          Text(
                                            '20 mins ago',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: secondaryTextColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Image.asset(
                                  'assets/images/default_store.png',
                                  height: 80,
                                  width: 100,
                                  fit: BoxFit.scaleDown,
                                  frameBuilder: (context, child, frame,
                                      wasSynchronouslyLoaded) {
                                    return Transform.scale(
                                      scale:
                                          1.1, // Adjust the scale value to increase or decrease the image size
                                      child: child,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  );
                }),
            ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => SellerProductInfoPage(
                      //             productId: 6,
                      //           )),
                      // );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 12, right: 16, left: 16),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: lightGrayBorderBottom,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Container(
                        height: 11.h,
                        child: Column(children: [
                          Row(
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, right: 20),
                                  child: CircleAvatar(
                                    radius: 4
                                        .h, // Set the desired radius for the circular image
                                    backgroundImage: AssetImage(
                                        'assets/images/default_store.png'),
                                  )),
                              Container(
                                margin: EdgeInsets.only(right: 4.w),
                                width: 55
                                    .w, // Set the desired width for the Column
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  'Nguyễn Ngọc Thịnh',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 4),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'You got what i all said? You got what i all said? You got what i all said?',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: secondaryTextColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                padding: const EdgeInsets.only(top: 4),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        '19:27',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: secondaryTextColor),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 8),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        '1',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  );
                }),
          ],
          // child: Text(token1.toString()),
        ),
      ),
    );
  }

  void getValidation() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    print("token ne`" + token!);
  }

  PreferredSize _appbar() {
    return PreferredSize(
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _topBar(),
            _tabBar(),
          ],
        )),
        preferredSize: Size.fromHeight(15.h));
  }

  Widget _topBar() {
    return Padding(
      padding: EdgeInsets.only(top: 4.h, left: 4.w),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'THÔNG BÁO',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                  fontFamily: 'SF Pro Text',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TabBar(
          controller: tabController,
          indicatorColor: primaryColor,
          labelColor: primaryColor,
          unselectedLabelColor: secondaryTextColor,
          tabs: const [
            Tab(text: 'Thông báo mới'),
            Tab(
              text: 'Tin nhắn (' + '1' + ')',
            ),
          ]),
    );
  }
}
