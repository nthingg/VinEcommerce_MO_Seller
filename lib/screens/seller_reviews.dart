import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer2/sizer2.dart';
import 'package:vin_ecommerce/data/review_repository.dart';
import 'package:vin_ecommerce/models/review_model.dart';
import 'package:vin_ecommerce/styles/color.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:vin_ecommerce/main.dart';

class SellerReviewsPage extends StatefulWidget {
  const SellerReviewsPage({super.key});
  @override
  State<StatefulWidget> createState() => _SellerReviewsPageState();
}

class _SellerReviewsPageState extends State<SellerReviewsPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  ReviewRepository reviewRepo = new ReviewRepository();
  List<Review> _reviewList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReviews();
    tabController = TabController(length: 1, vsync: this, initialIndex: 0);
  }

  getReviews() async {
    var list = await reviewRepo.getReviews();
    setState(() {
      _reviewList = list;
    });
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
                itemCount: _reviewList.length,
                itemBuilder: (context, index) {
                  Review review = _reviewList[index];

                  return Container(
                    margin: EdgeInsets.only(top: 16, right: 16, left: 16),
                    child: Container(
                      // height: 16.h,
                      child: Column(children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 4.w),
                              child: CircleAvatar(
                                radius: 3.4
                                    .h, // Set the desired radius for the circular image
                                backgroundImage: NetworkImage(
                                  review.getCustomerAvatarUrl().toString(),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    8), // Set the desired border radius
                                color: lightGrayColor,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              width:
                                  72.w, // Set the desired width for the Column
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                review
                                                    .getCustomerName()
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 4,
                                        bottom: 8), // Set the desired margin
                                    child: IgnorePointer(
                                      ignoring:
                                          true, // Disable rating interaction
                                      child: RatingBar.builder(
                                        initialRating: review
                                            .getRate()!
                                            .toDouble(), // Replace with your numeric value
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 2.2.h,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: primaryColor,
                                        ),
                                        onRatingUpdate: (rating) {
                                          // This won't be triggered since user interaction is disabled
                                          print(rating);
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 4),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            review.getComment().toString(),
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ]),
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
          ],
        )),
        preferredSize: Size.fromHeight(9.h));
  }

  Widget _topBar() {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Row(
        children: [
          Container(
            child: RawMaterialButton(
              fillColor: Color(0xffECF0F4),
              shape: CircleBorder(),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainApp()),
                );
              },
              child: Image.asset(
                'assets/images/back.png',
                scale: 1,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Đánh giá',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'SF Pro Text',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
