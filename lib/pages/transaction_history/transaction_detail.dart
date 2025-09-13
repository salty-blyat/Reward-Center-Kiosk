import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reward_center_kiosk/util/theme.dart';

class TransactionDetail extends StatelessWidget {
  TransactionDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400, // fixed width similar to your screenshot
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Center(
            child: Text(
              'T1113',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.defaultColor,
              ),
            ),
          ),
          const Divider(height: 24),

          // Trans No
          _buildField(
              label: "Trans No:",
              child: const TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "T1113"))),

          const SizedBox(height: 12),

          // Location
          _buildField(
            label: "* Location:",
            child: DropdownButtonFormField<String>(
              value: "Hotel",
              items: const [
                DropdownMenuItem(value: "Hotel", child: Text("Hotel")),
                DropdownMenuItem(value: "Cafe", child: Text("Cafe")),
              ],
              onChanged: (_) {},
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ),

          const SizedBox(height: 12),

          // Amount
          _buildField(
            label: "* Amount:",
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "1.00",
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text("\$"),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Type
          _buildField(
            label: "Type:",
            child: DropdownButtonFormField<String>(
              value: "Topup",
              items: const [
                DropdownMenuItem(value: "Topup", child: Text("Topup")),
                DropdownMenuItem(value: "Refund", child: Text("Refund")),
              ],
              onChanged: (_) {},
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ),

          const SizedBox(height: 12),

          // Date
          _buildField(
            label: "Date:",
            child: TextField(
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today, size: 18),
                hintText: "2025-09-13",
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Note
          _buildField(
            label: "Note:",
            child: const TextField(
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Attachment
          _buildField(
            label: "Attachment:",
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.upload),
              label: const Text("Upload"),
            ),
          ),

          const SizedBox(height: 20),

          // Close button
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}
