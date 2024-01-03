import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qulip/common/strings.dart';
import 'package:qulip/controller/base_controller.dart';
import 'package:qulip/models/createcase/establish_case_model.dart';

class CaseListController extends BaseController {
  static CaseListController get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  //List caseList = [];
  var caseListNew = <EstablishCaseModel>[].obs;
  var isProcessComplete = false;

  Future getData() async {
    // setLoading(true);
    await _db.collection('case_survey').get().then((value) {
      final result = (value.docs)
          .map((x) => EstablishCaseModel.fromJson(x.data()))
          .toList();
      caseListNew.clear();
      caseListNew.addAll(result);
    }).whenComplete(() => isProcessComplete = true);

    //return caseList;
    // final cRef = _db.collection('/case_survey');
    // QuerySnapshot querySnapshot = await cRef.get();
    // final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    // debugPrint("Himadri :: ${allData.length}");
  }

  Future filterData(String selectedFilter) async {
    DateTime currentDate = DateTime.now();

    if (selectedFilter == WordStrings.sixMonthLbl) {
      // List of before 6 months from now

      await _db.collection('case_survey').get().then((value) {
        final result = (value.docs)
            .map((x) => EstablishCaseModel.fromJson(x.data()))
            .toList();
        caseListNew.clear();
        caseListNew.addAll(result);
      }).whenComplete(() {
        isProcessComplete = true;

        // Subtract 6 months from the current date
        DateTime sixMonthsAgo =
            currentDate.subtract(const Duration(days: 30 * 6));

        var filteredList = caseListNew.where((caseItem) {
          // Convert the integer to a string
          String dateString = caseItem.createdAt!;

          // Ensure the correct format for a 24-hour clock (HH instead of hh)
          String formattedDateString =
              "${dateString.substring(0, 8)} ${dateString.substring(8, 10)}:${dateString.substring(10, 12)}:${dateString.substring(12, 14)}";

          // Parse the formatted date string into a DateTime object
          DateTime date = DateTime.parse(formattedDateString);
          return date.isAfter(sixMonthsAgo);
        }).toList();
        caseListNew.clear();
        caseListNew.addAll(filteredList);
      });
    } else if (selectedFilter == WordStrings.threeMonthLbl) {
      // List of before 3 months from now

      await _db.collection('case_survey').get().then((value) {
        final result = (value.docs)
            .map((x) => EstablishCaseModel.fromJson(x.data()))
            .toList();
        caseListNew.clear();
        caseListNew.addAll(result);
      }).whenComplete(() {
        isProcessComplete = true;

        // Subtract 6 months from the current date
        DateTime sixMonthsAgo =
            currentDate.subtract(const Duration(days: 30 * 3));

        var filteredList = caseListNew.where((caseItem) {
          // Convert the integer to a string
          String dateString = caseItem.createdAt!;

          // Ensure the correct format for a 24-hour clock (HH instead of hh)
          String formattedDateString =
              "${dateString.substring(0, 8)} ${dateString.substring(8, 10)}:${dateString.substring(10, 12)}:${dateString.substring(12, 14)}";

          // Parse the formatted date string into a DateTime object
          DateTime date = DateTime.parse(formattedDateString);
          return date.isAfter(sixMonthsAgo);
        }).toList();
        caseListNew.clear();
        caseListNew.addAll(filteredList);
      });
    } else {
      getData();
    }
  }
}
