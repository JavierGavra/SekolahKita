import 'package:flutter/material.dart';
import 'package:sekolah_kita/core/theme/theme.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class OnlineChip extends StatefulWidget {
  const OnlineChip({super.key});

  @override
  State<OnlineChip> createState() => _OnlineChipState();
}

class _OnlineChipState extends State<OnlineChip> {
  bool _isOnline = true;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    _checkInitialConnectivity();
    _listenToConnectivityChanges();
  }

  Future<void> _checkInitialConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      setState(() {
        _isOnline = false;
      });
    }
  }

  void _listenToConnectivityChanges() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> result,
    ) {
      _updateConnectionStatus(result);
    });
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    setState(() {
      _isOnline = result.any(
        (element) =>
            element == ConnectivityResult.mobile ||
            element == ConnectivityResult.wifi ||
            element == ConnectivityResult.ethernet,
      );
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _isOnline ? color.successContainer : color.errorContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          Icon(
            _isOnline ? Icons.wifi_rounded : Icons.wifi_off_rounded,
            color: _isOnline
                ? color.onSuccessContainer
                : color.onErrorContainer,
            size: 16,
          ),
          Text(
            _isOnline ? 'Online' : 'Offline',
            style: TextStyle(
              color: _isOnline
                  ? color.onSuccessContainer
                  : color.onErrorContainer,
              height: 1.428,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
