import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reward_center_kiosk/util/theme.dart';

class TransactionDetailScreen extends StatelessWidget {
  TransactionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppTheme.defaultColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Text(
                  "T0022",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
                IconButton(visualDensity: VisualDensity.compact, onPressed: () => Get.back(), icon: Icon(Icons.close_outlined))
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),

          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('10 pts', style: TextStyle(fontSize: 64)),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          _buildRow("Location", "Hotel"),
          _buildRow("Type", "Topup"),
          _buildRow("Date", "2025-09-13"),
          _buildRow("PREV BALANCE", "0.0"),
          _buildRow("TRANSACTION", "0.0"),
          _buildRow("NEW BALANCE", "0.0"),
          _buildRow("CARD", "0.0"),

          // Container(
          //   padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       Text('10 pts', style: TextStyle(fontSize: 64)),
          //       Text('>', style: TextStyle(fontSize: 64)),
          //       Text('20 pts', style: TextStyle(fontSize: 64)),
          //     ],
          //   ),
          // ),

          //  Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: controller.transactionDetail.value.attachments!
          //       .map<Widget>((attachment) {
          //     return TextButton(
          //       onPressed: () async {
          //         final url = Uri.parse(attachment.url);
          //         if (await canLaunchUrl(url)) {
          //           await launchUrl(url, mode: LaunchMode.externalApplication);
          //         } else {
          //           print('Could not launch ${attachment.url}');
          //         }
          //       },
          //       style: TextButton.styleFrom(
          //         padding: EdgeInsets.zero,
          //         minimumSize: Size(0, 0),
          //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //         splashFactory: NoSplash.splashFactory,
          //       ),
          //       child: Row(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Icon(Icons.attachment),
          //           SizedBox(width: 4),
          //           Text(attachment.name),
          //         ],
          //       ),
          //     );
          //   }).toList(),
          // ),
          const SizedBox(
            height: 48,
          )
        ],
      ),
    );
  }
}

Widget _buildRow(String label, String value, {Color? color}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: 300, child: Text(label, style: TextStyle(fontSize: 24))),
        Expanded(
            child: Text(
          value,
          style: AppTheme.style.copyWith(
            color: color,
          ),
          textAlign: TextAlign.right,
        )),
      ],
    ),
  );
}
