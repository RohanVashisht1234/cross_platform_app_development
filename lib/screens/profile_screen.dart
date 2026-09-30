import 'package:flutter/material.dart';

/// User Profile & Settings Screen featuring:
/// - Mock Google Sign-In with interactive state toggle
/// - Pure Vegetarian / Sattvic dietary preferences
/// - Interactive Send Feedback dialog with 5-star rating
/// - App About & Version information
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isSignedInWithGoogle = true;
  bool _pureVegMode = true;
  bool _mealPrepAlerts = true;
  bool _offlineCacheEnabled = true;
  int _defaultServings = 4;
  String _selectedUnit = 'Metric (g, ml, kg)';

  void _toggleGoogleSignIn() {
    setState(() {
      _isSignedInWithGoogle = !_isSignedInWithGoogle;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isSignedInWithGoogle
              ? 'Successfully authenticated with Google account (rohanprogrammer1@gmail.com)!'
              : 'Signed out of Google account. Local device mode active.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showFeedbackDialog() {
    int rating = 5;
    String selectedCategory = 'Recipe Idea';
    final feedbackController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogCtx) {
        final theme = Theme.of(dialogCtx);
        final isDark = theme.brightness == Brightness.dark;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF421D09) : const Color(0xFFFFEDE6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.rate_review_rounded,
                      size: 20,
                      color: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Send Feedback',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                    ),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Rate your experience with MealCraft:',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    // 5-Star Rating Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final starIndex = index + 1;
                        final isFilled = starIndex <= rating;
                        return IconButton(
                          icon: Icon(
                            isFilled ? Icons.star_rounded : Icons.star_border_rounded,
                            size: 32,
                            color: isFilled ? const Color(0xFFFFB800) : Colors.grey,
                          ),
                          onPressed: () {
                            setDialogState(() => rating = starIndex);
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Feedback Topic:',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: ['Recipe Idea', 'UI & Theming', 'Feature Request', 'Praise'].map((cat) {
                        final isSel = selectedCategory == cat;
                        return ChoiceChip(
                          label: Text(cat, style: TextStyle(fontSize: 11, color: isSel ? Colors.white : null)),
                          selected: isSel,
                          selectedColor: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                          onSelected: (_) => setDialogState(() => selectedCategory = cat),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: feedbackController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Share recipes you want added, or suggestions for the weekly meal planner...',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogCtx).pop(),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                  ),
                  onPressed: () {
                    Navigator.of(dialogCtx).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: const [
                            Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Thank you! Your feedback has been recorded.',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: const Text('Submit Feedback'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        title: const Text(
          'Profile & Preferences',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFECE7DE),
                ),
                boxShadow: isDark
                    ? []
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        'RV',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Rohan Vashisht',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: _pureVegMode
                                    ? (isDark ? const Color(0xFF0F5132) : const Color(0xFFD1E7DD))
                                    : (isDark ? const Color(0xFF421D09) : const Color(0xFFFFEDE6)),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                _pureVegMode ? 'Pure Veg' : 'Veg & Non-Veg',
                                style: TextStyle(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w800,
                                  color: _pureVegMode
                                      ? (isDark ? const Color(0xFF75E59B) : const Color(0xFF0F5132))
                                      : (isDark ? const Color(0xFFFFB28A) : const Color(0xFF8B2500)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          _isSignedInWithGoogle ? 'rohanprogrammer1@gmail.com' : 'Guest Mode (Local Storage)',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? Colors.white70 : const Color(0xFF5A544C),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'MealCraft Culinary Planner • Semester V',
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Google Sign-In Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFECE7DE),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CLOUD ACCOUNT & SYNC',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                      color: Color(0xFF8A8276),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF282828) : const Color(0xFFF7F5F0),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isDark ? const Color(0xFF333333) : const Color(0xFFECE7DE),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.g_mobiledata_rounded,
                            size: 28,
                            color: isDark ? Colors.white : const Color(0xFF4285F4),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _isSignedInWithGoogle ? 'Connected to Google' : 'Google Account Sync',
                              style: const TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              _isSignedInWithGoogle
                                  ? 'Weekly meal plans & custom recipes synced'
                                  : 'Sign in to back up plans across multiple devices',
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark ? Colors.white60 : const Color(0xFF6E6860),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: _isSignedInWithGoogle
                              ? (isDark ? const Color(0xFF3D3D3D) : const Color(0xFFD6D0C4))
                              : (isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500)),
                          width: 1.2,
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        backgroundColor: _isSignedInWithGoogle
                            ? Colors.transparent
                            : (isDark ? const Color(0xFF2A1C16) : const Color(0xFFFFEDE6)),
                      ),
                      onPressed: _toggleGoogleSignIn,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _isSignedInWithGoogle ? Icons.check_circle_rounded : Icons.login_rounded,
                            size: 18,
                            color: _isSignedInWithGoogle
                                ? (isDark ? const Color(0xFF50E380) : const Color(0xFF1B6D24))
                                : (isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500)),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _isSignedInWithGoogle ? 'Signed in with Google (Tap to Disconnect)' : 'Sign in with Google',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: _isSignedInWithGoogle
                                  ? (isDark ? Colors.white70 : const Color(0xFF38332E))
                                  : (isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Dietary & Recipe Preferences Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFECE7DE),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'DIETARY & CULINARY PREFERENCES',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                      color: Color(0xFF8A8276),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Pure Veg Mode Switch
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    value: _pureVegMode,
                    activeTrackColor: isDark ? const Color(0xFF50E380) : const Color(0xFF1B6D24),
                    title: const Text(
                      'Pure Vegetarian Mode',
                      style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      _pureVegMode
                          ? 'Active: Filtering exclusively pure vegetarian dishes.'
                          : 'Disabled: All Indian recipes enabled, including authentic non-veg, onion & garlic delicacies.',
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark ? Colors.white60 : const Color(0xFF6E6860),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() => _pureVegMode = val);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            val
                                ? 'Pure Vegetarian mode enabled.'
                                : 'All Indian recipes enabled (including Non-Veg, Onion & Garlic delicacies)!',
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  const Divider(height: 20),

                  // Default Servings Stepper
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Default Recipe Servings',
                            style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            'Standard batch size for newly planned meals',
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark ? Colors.white60 : const Color(0xFF6E6860),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF282828) : const Color(0xFFFFEDE6),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: _defaultServings > 1
                                  ? () => setState(() => _defaultServings--)
                                  : null,
                              borderRadius: BorderRadius.circular(14),
                              child: const Padding(
                                padding: EdgeInsets.all(6),
                                child: Icon(Icons.remove, size: 14),
                              ),
                            ),
                            Text(
                              '$_defaultServings',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                              ),
                            ),
                            InkWell(
                              onTap: () => setState(() => _defaultServings++),
                              borderRadius: BorderRadius.circular(14),
                              child: const Padding(
                                padding: EdgeInsets.all(6),
                                child: Icon(Icons.add, size: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20),

                  // Measurement Units Selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ingredient Measurement Units',
                            style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            'Used across grocery synthesis and recipe cards',
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark ? Colors.white60 : const Color(0xFF6E6860),
                            ),
                          ),
                        ],
                      ),
                      DropdownButton<String>(
                        value: _selectedUnit,
                        underline: const SizedBox.shrink(),
                        icon: const Icon(Icons.arrow_drop_down, size: 20),
                        items: const [
                          DropdownMenuItem(
                            value: 'Metric (g, ml, kg)',
                            child: Text('Metric (g, ml)', style: TextStyle(fontSize: 12)),
                          ),
                          DropdownMenuItem(
                            value: 'Imperial (oz, lbs)',
                            child: Text('Imperial (oz, lbs)', style: TextStyle(fontSize: 12)),
                          ),
                        ],
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedUnit = val);
                        },
                      ),
                    ],
                  ),
                  const Divider(height: 20),

                  // Meal Prep Notifications Switch
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    value: _mealPrepAlerts,
                    activeTrackColor: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                    title: const Text(
                      'Prep Timers & Notifications',
                      style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      'Remind me 30 mins before scheduled meal slot (Breakfast, Lunch, Dinner).',
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark ? Colors.white60 : const Color(0xFF6E6860),
                      ),
                    ),
                    onChanged: (val) => setState(() => _mealPrepAlerts = val),
                  ),
                  const Divider(height: 20),

                  // Offline Local Cache Switch
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    value: _offlineCacheEnabled,
                    activeTrackColor: isDark ? const Color(0xFF50E380) : const Color(0xFF1B6D24),
                    title: const Text(
                      'Local Storage Persistence',
                      style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      'Keep all recipes and weekly meal plans stored offline on this device.',
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark ? Colors.white60 : const Color(0xFF6E6860),
                      ),
                    ),
                    onChanged: (val) => setState(() => _offlineCacheEnabled = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Send Feedback Tile
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFECE7DE),
                ),
              ),
              child: ListTile(
                leading: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF421D09) : const Color(0xFFFFEDE6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 18,
                    color: isDark ? const Color(0xFFEE671C) : const Color(0xFF8B2500),
                  ),
                ),
                title: const Text(
                  'Send Feedback & Recipe Requests',
                  style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
                ),
                subtitle: const Text(
                  'Rate your experience or request new authentic pure vegetarian dishes',
                  style: TextStyle(fontSize: 11),
                ),
                trailing: const Icon(Icons.chevron_right_rounded, size: 20),
                onTap: _showFeedbackDialog,
              ),
            ),
            const SizedBox(height: 16),

            // About MealCraft Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF7F5F0),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? const Color(0xFF282828) : const Color(0xFFECE7DE),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/app_logo.png',
                          width: 28,
                          height: 28,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFFEE671C) : const Color(0xFF9E3D00),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.restaurant_rounded, color: Colors.white, size: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'About MealCraft',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF282828) : const Color(0xFFEBE6DC),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'v1.0.0 Production',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'MealCraft is a cross-platform recipe browsing, weekly meal planning, and supermarket grocery consolidation application built for Semester V B.Tech CSE & AI (Problem Statement 40). Features 100% pure sattvic vegetarian gastronomy with seamless Map-based duplicate ingredient merging and offline storage.',
                    style: TextStyle(
                      fontSize: 11.5,
                      height: 1.4,
                      color: isDark ? Colors.white70 : const Color(0xFF5A544C),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline_rounded,
                        size: 14,
                        color: isDark ? const Color(0xFF50E380) : const Color(0xFF1B6D24),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Zero-allium sattvic certified recipes',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isDark ? const Color(0xFF50E380) : const Color(0xFF1B6D24),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
