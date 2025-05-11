// custom_snackbar.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void showSnackbar(String title, String message, Color? color) {
    Get.snackbar(title, message,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        margin: EdgeInsets.symmetric(vertical: 20),
        borderRadius: 15,
        icon: Icon(
          Icons.nearby_error_rounded,
          size: 30,
          color: Colors.white,
        ));
  }

  static void showDeleteConfirmationDialog(
      BuildContext context, Function onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete tasks ?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Delete", style: TextStyle(color: Colors.red)),
              onPressed: () {
                onConfirm(); // Call the delete function
                Navigator.of(context)
                    .pop(); // Close the dialog after confirming
              },
            ),
          ],
        );
      },
    );
  }
}
