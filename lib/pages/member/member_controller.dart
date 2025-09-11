import 'package:get/get.dart'; 



class MemberController extends GetxController   { 
  final isLoading = false.obs;
  final cardNumber = ''.obs;
  final id = 0.obs;
  // final member = Member().obs;
   
  @override
  void onInit() async { 
    id.value = Get.arguments['id'];
    cardNumber.value = Get.arguments['cardNumber'];  
    super.onInit();
  }

  Future<void> find(int id) async {
    isLoading.value = true;
    try {
      // final member = await service.getMember(id);
      // memberDetail.value = member;
      // final accounts = memberDetail.value.accounts ?? [];
      
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> silentFind() async {
  //   try {
  //     final member = await service.getMember(id.value);
  //     memberDetail.value = member;
  //     final accounts = memberDetail.value.accounts ?? [];

  //     walletAccount.value = accounts
  //         .firstWhere((acc) => acc.accountType == AccountTypes.wallet.value);
  //     pointAccount.value = accounts
  //         .firstWhere((acc) => acc.accountType == AccountTypes.point.value);
  //   } catch (e) {}
  // }
}
