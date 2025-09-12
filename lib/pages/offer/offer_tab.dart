import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reward_center_kiosk/model/offer_model.dart';
import 'package:reward_center_kiosk/pages/offer/offer_controller.dart';
import 'package:reward_center_kiosk/pages/offer_group/offer_group_controller.dart';
import 'package:reward_center_kiosk/util/const.dart';
import 'package:reward_center_kiosk/util/theme.dart';
import 'package:reward_center_kiosk/util/widgets/loading.dart';
import 'package:reward_center_kiosk/util/widgets/network_img.dart';
import 'package:reward_center_kiosk/util/widgets/not_found.dart';
import 'package:skeletonizer/skeletonizer.dart'; 

class OfferTab extends StatelessWidget {
  OfferTab({super.key});
  final OfferController controller = Get.put(OfferController());
  final OfferGroupController offerGroupController =
      Get.put(OfferGroupController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildFilterButtons(),
        Expanded(
          child: Obx(
            () {
              if (controller.isLoading.value) {
                return const SizedBox(height: 200, child: Loading());
              }
              if (controller.lists.isEmpty) {
                return const SizedBox(height: 200, child: NotFound());
              }
              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
                  if (notification is ScrollEndNotification &&
                      notification.metrics.pixels >=
                          notification.metrics.maxScrollExtent &&
                      controller.canLoadMore.isTrue &&
                      !controller.isLoading.isTrue) {
                    controller.onLoadMore();
                  }
                  return false;
                },
                child: RefreshIndicator(
                  color: Theme.of(context).primaryColor,
                  backgroundColor: Colors.white,
                  onRefresh: () => controller.search(),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 200 / 246, // width / height
                    children: List.generate(
                      controller.lists.length,
                      (index) => _buildCard(controller.lists[index]),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCard(OfferModel offer) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          maxHeight: 270,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppTheme.primaryColor.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NetworkImg(
              src: offer.photo,
              height: 130,
              badge: offer.redeemWith == 1
                  ? "\$${offer.redeemCost?.toStringAsFixed(2) ?? '0.00'}"
                  : "${offer.redeemCost?.toStringAsFixed(0) ?? '0'} pts",
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offer.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      offer.offerTypeNameEn ?? '',
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.grey[600],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${Const.numberFormat(offer.redeemedQty ?? 0)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          ' / ${offer.maxQty == 0 ? 'Unlimited'.tr : offer.maxQty}',
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.grey[600],
                          ),
                        )
                      ],
                    ),

                    // const Spacer(),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: ,
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButtons() {
    return Obx(() {
      if (offerGroupController.isLoading.value) {
        return Skeletonizer(
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            height: 24,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                    shadowColor: Colors.transparent,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                  ),
                  child: Text('All'.tr),
                ),
              ),
            ),
          ),
        );
      }

      if (offerGroupController.lists.isEmpty) {
        return const SizedBox.shrink();
      }
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        height: 24,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: offerGroupController.lists.length,
          itemBuilder: (context, index) {
            final offerGroup = offerGroupController.lists[index];
            return Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Obx(() {
                final isSelected =
                    controller.offerGroupId.value == offerGroup.id;

                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                    shadowColor: Colors.transparent,
                    backgroundColor: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white,
                    foregroundColor: isSelected ? Colors.white : Colors.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                  ),
                  onPressed: () {
                    controller.offerGroupId.value = offerGroup.id!;
                    controller.search();
                  },
                  child: Text(
                    offerGroup.name ?? '',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                );
              }),
            );
          },
        ),
      );
    });
  }
}
