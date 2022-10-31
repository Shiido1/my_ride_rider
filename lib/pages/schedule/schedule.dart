import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:my_ride/controllers/auth_controller.dart';
import 'package:my_ride/utils/flushbar_mixin.dart';
import 'package:my_ride/utils/router.dart';
import 'package:my_ride/widget/custom_dialog.dart';
import 'package:my_ride/widget/text_form_field.dart';
import 'package:my_ride/widget/text_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../constants/session_manager.dart';
import '../../models/global_model.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State createState() => _SchedulePageState();
}

class _SchedulePageState extends StateMVC<SchedulePage> with FlushBarMixin {
  _SchedulePageState() : super(AuthController()) {
    con = controller as AuthController;
  }

  late AuthController con;

  List<String> schedulePlans = ["Instant", "Weekly", "Bi-weekly", "Monthly"];

  TextEditingController? pickupController =
      TextEditingController(text: 'Enter Pick up location');
  TextEditingController? dropController =
      TextEditingController(text: 'Enter Destination location');

  DateTime selectedDate = DateTime.now();
  final firstDate = DateTime(2022, 1);
  final lastDate = DateTime(2100, 12);
  List<String> list = [];
  List<String> endPointList = [];
  TimeOfDay time = const TimeOfDay(hour: 00, minute: 00);
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  int valueIndex = 0;
  var periodValue;

  @override
  void dispose() {
    scheduleValue;
    super.dispose();
  }

  schedule(BuildContext? context) async {
    if (pickupController!.text != 'Enter Pick up location' &&
        dropController!.text != 'Enter Destination location' &&
        scheduleValue!.isNotEmpty &&
        timeText != 'Pick time') {
      setState(() {
        listOfDates = endPointList;
      });
      Routers.replaceAllWithName(context!, '/schedule_trip_vehicle');
    } else {
      showErrorNotification(context!, 'Fill in the necessary fields');
      setState(() {});
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(8.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SessionManager.instance
                                            .usersData["profile_picture"] ==
                                        null ||
                                    SessionManager.instance
                                            .usersData["profile_picture"] ==
                                        ''
                                ? CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.person,
                                      color: AppColors.grey1,
                                      size: 23.sp,
                                    ),
                                    radius: 26,
                                  )
                                : CircleAvatar(
                                    radius: 28,
                                    child: CachedNetworkImage(
                                      imageUrl: SessionManager.instance
                                          .usersData["profile_picture"],
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const CircularProgressIndicator(),
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Hi there,',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          'Book your ride',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 3.sp,
                        ),
                      ],
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 3,
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 18.4.sp,
                ),
                onPressed: () {
                  Routers.pop(context);
                }),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  GestureDetector(
                    onTap: () => showCustomDialog(context, items: schedulePlans,
                        onTap: (value) {
                      setState(() {
                        scheduleValue = value;
                      });
                      Routers.pop(context);
                      if (scheduleValue == "Instant") {
                        Routers.pushNamed(context, '/home');
                      }
                    }),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 150,
                        height: 5.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primary),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Schedule plan',
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 15.4.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                size: 22.sp,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  TextView(
                      text: scheduleValue!,
                      color: AppColors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                  SizedBox(
                    height: 1.h,
                  ),
                  Visibility(
                      visible: scheduleValue != "Instant",
                      child: CalendarDatePicker(
                        initialDate: selectedDate,
                        firstDate: firstDate,
                        lastDate: lastDate,
                        onDateChanged: (DateTime value) {
                          setState(() {
                            scheduleDate = value.toString().split(' ')[0];
                          });
                        },
                      )),
                  SizedBox(
                    height: 3.h,
                  ),
                  EditTextForm(
                    onTapped: () async {
                      var place = await PlacesAutocomplete.show(
                        context: context,
                        apiKey: googleApikey,
                        mode: Mode.overlay,
                        types: [],
                        strictbounds: false,
                        components: [Component(Component.country, 'us')],
                        //google_map_webservice package
                        onError: (err) {},
                      );

                      if (place != null) {
                        setState(() {
                          pickUpLocationAdd = place.description;
                          pickupController =
                              TextEditingController(text: pickUpLocationAdd);
                        });
                        //form google_maps_webservice package
                        final plist = GoogleMapsPlaces(
                          apiKey: googleApikey,
                          apiHeaders:
                              await const GoogleApiHeaders().getHeaders(),
                        );
                        String placeid = place.placeId ?? "0";
                        final detail = await plist.getDetailsByPlaceId(placeid);
                        final geometry = detail.result.geometry!;
                        pickUpLat = geometry.location.lat.toString();
                        pickUpLong = geometry.location.lng.toString();
                      }
                    },
                    readOnly: true,
                    controller: pickupController,
                    prefixWidget: Padding(
                      padding: EdgeInsets.only(top: 2.9.w, left: 3.5.w),
                      child: FaIcon(
                        FontAwesomeIcons.person,
                        size: 20.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  EditTextForm(
                    floatingLabel: '',
                    onTapped: () async {
                      var place = await PlacesAutocomplete.show(
                        context: context,
                        apiKey: googleApikey,
                        mode: Mode.overlay,
                        types: [],
                        strictbounds: false,
                        components: [Component(Component.country, 'us')],
                        //google_map_webservice package
                        onError: (err) {},
                      );

                      if (place != null) {
                        setState(() {
                          dropLocationAdd = place.description;
                          dropController =
                              TextEditingController(text: dropLocationAdd);
                        });
                        //form google_maps_webservice package
                        final plist = GoogleMapsPlaces(
                          apiKey: googleApikey,
                          apiHeaders:
                              await const GoogleApiHeaders().getHeaders(),
                        );
                        String placeid = place.placeId ?? "0";
                        final detail = await plist.getDetailsByPlaceId(placeid);
                        final geometry = detail.result.geometry!;
                        dropLat = geometry.location.lat.toString();
                        dropLong = geometry.location.lng.toString();
                      }
                    },
                    readOnly: true,
                    controller: dropController,
                    prefixWidget: Icon(
                      Icons.location_on,
                      color: AppColors.primary,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(left: 38.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(
                            text: 'Time',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          InkWell(
                            onTap: () async {
                              TimeOfDay? newTime = await showTimePicker(
                                  context: context, initialTime: time);
                              if (newTime == null) return;

                              setState(() {
                                timeText =
                                    '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}:00';
                                periodValue =
                                    newTime.period.toString().substring(10);
                              });
                            },
                            child: Container(
                              width: 40.w,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.w, vertical: 3.w),
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.bgGrey1)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.access_time_filled,
                                    color: AppColors.primary,
                                    size: 20.sp,
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  TextView(
                                    text: timeText!,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 4.w),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            list.add(
                                '$scheduleDate' '$timeText' '$periodValue');
                            endPointList.add('$scheduleDate' '$timeText');
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.add,
                              color: AppColors.green,
                              size: 20.sp,
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            TextView(
                              text: 'Add',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  ...list
                      .map(
                        (e) => timeScheduleContainer(
                            time: e.substring(10, 18),
                            date: e.substring(0, 10),
                            period: e.substring(18),
                            onTap: () {
                              setState(() {
                                list.remove(e);
                              });
                            }),
                      )
                      .toList(),
                  SizedBox(
                    height: 5.h,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () =>
                          Routers.pushNamed(context, '/view_schedule_ride'),
                      child: Text(
                        'View Schedule',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 16.5.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => schedule(context),
                      child: Container(
                        width: 180,
                        height: 5.h,
                        decoration: const BoxDecoration(
                          color: Color(0XFF000B49),
                        ),
                        child: Center(
                          child: con.model.isScheduleLoading
                              ? SpinKitWave(
                                  color: Colors.white,
                                  size: 20.sp,
                                )
                              : Text(
                                  'Continue',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  timeScheduleContainer(
          {String? date, String? time, String? period, Function()? onTap}) =>
      Padding(
        padding: EdgeInsets.only(bottom: 4.w),
        child: Container(
          padding: EdgeInsets.all(3.w),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: AppColors.greyWhite11,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextView(
                text: 'Date: $date, Time: $time $period',
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              InkWell(
                onTap: onTap,
                child: Icon(
                  Icons.delete_outlined,
                  color: AppColors.primary,
                  size: 18.sp,
                ),
              )
            ],
          ),
        ),
      );
}
