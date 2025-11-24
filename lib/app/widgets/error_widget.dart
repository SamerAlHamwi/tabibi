import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../core/errors/not_found_error.dart';
import '../core/errors/unauthorized_error.dart';

class ErrorDisplayWidget extends StatelessWidget {
  final String errorMessage;
  final dynamic errorType; // String representing the type of error
  final VoidCallback onRetry;

  ErrorDisplayWidget({required this.errorMessage,  this.errorType, required this.onRetry});


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            getLottieAnimationPath(errorType), // Get animation path based on error type
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onRetry,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.red, width: 1.0)),
                ),
                child: Text(
                  errorMessage.tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  String getLottieAnimationPath(dynamic errorType) {
    switch (errorType) {
      case UnauthorizedError:
        return 'assets/lottie/offline.json'; // Path to offline animation
      case NotFoundError:
        return 'assets/lottie/loading_points2.json'; // Path to server error animation
      case 'OffLine':
        return 'assets/lottie/loading_points2.json';
    // Add more cases for other error types as needed
      default:
        return 'assets/lottie/loading_points2.json'; // Default error animation
    }
  }

}
