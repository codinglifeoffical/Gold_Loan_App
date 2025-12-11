import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constants.dart';

class QuickSaveCard extends StatefulWidget {
  const QuickSaveCard({super.key});

  @override
  State<QuickSaveCard> createState() => _QuickSaveCardState();
}

class _QuickSaveCardState extends State<QuickSaveCard> {
  int _selectedAmount = 100;
  final List<int> _amounts = [50, 100, 500, 1000];
  double _dragValue = 0.0;
  bool _isDragging = false;
  static const double _sliderHeight = 60.0;
  static const double _thumbSize = 50.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Swipe to save in Gold",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "Save ₹$_selectedAmount in Gold Instantly",
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[400]),
          ),
          const SizedBox(height: 24),

          // Slider
          LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;
              final maxDrag = maxWidth - _thumbSize - 10; // 10 matches padding

              return Container(
                height: _sliderHeight,
                width: maxWidth,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey.withOpacity(0.1)),
                ),
                child: Stack(
                  children: [
                    // Background Arrows
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.yellow[700],
                            size: 20,
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.yellow[700],
                            size: 20,
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.yellow[700],
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    // End Icon
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Icon(
                          Icons.receipt_long_outlined,
                          color: Colors.grey[600],
                          size: 24,
                        ),
                      ),
                    ),
                    // Draggable Thumb
                    Positioned(
                      left: _dragValue * maxDrag,
                      top: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          setState(() {
                            _isDragging = true;
                            double delta = details.primaryDelta! / maxDrag;
                            _dragValue = (_dragValue + delta).clamp(0.0, 1.0);
                          });
                        },
                        onHorizontalDragEnd: (details) {
                          if (_dragValue > 0.9) {
                            // Trigger Action
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Saved ₹$_selectedAmount in Gold!",
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                            setState(() {
                              _dragValue = 0.0;
                              _isDragging = false;
                            });
                          } else {
                            // Snap back
                            setState(() {
                              _dragValue = 0.0;
                              _isDragging = false;
                            });
                          }
                        },
                        child: AnimatedScale(
                          scale: _isDragging ? 1.1 : 1.0,
                          duration: const Duration(milliseconds: 200),
                          child: Container(
                            width: _thumbSize,
                            height: _thumbSize,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                "₹$_selectedAmount",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          // Amount Chips
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _amounts.map((amount) {
              final isSelected = amount == _selectedAmount;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedAmount = amount;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.grey.withOpacity(0.2),
                    ),
                  ),
                  child: Text(
                    "₹$amount",
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
