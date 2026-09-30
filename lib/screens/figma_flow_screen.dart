import 'package:flutter/material.dart';

/// Screen detailing the Figma Design System, User Journey Flow,
/// and Academic Justifications required by the exam.
class FigmaFlowScreen extends StatelessWidget {
  const FigmaFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Figma Flow & Architecture'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
        children: [
          // Banner
          Card(
            color: theme.colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.design_services_rounded, color: theme.colorScheme.primary, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        'MealCraft Design System & Architecture',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Complete documentation of the Figma screen flow, progress cues, widget architecture, and Dart Map merging algorithm justifications for B.Tech CSE Semester V.',
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.85),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Flow Stages
          _buildSectionHeader(context, '1. Guided Figma User Flow', Icons.alt_route_rounded),
          const SizedBox(height: 10),
          _buildFlowStep(
            context,
            step: '01',
            title: 'Recipe Browse (Discovery)',
            description:
                'Users browse recipes using a responsive GridView. Each card displays appetizing photography, title, prep time, and difficulty badge with a quick "Plan" action.',
            cue: 'Progress Cue: Header banner displays active weekly progress (e.g. "4 of 7 days planned").',
          ),
          _buildFlowStep(
            context,
            step: '02',
            title: 'Recipe Detail (Inspection & Scaling)',
            description:
                'Hero image transition with interactive servings scaler (-/+). Adjusting servings dynamically scales ingredient quantities in real-time.',
            cue: 'Progress Cue: Checkable steps with completed strike-through and integrated cooking countdown timer.',
          ),
          _buildFlowStep(
            context,
            step: '03',
            title: 'Weekly Scheduling (Add to Plan)',
            description:
                'Modal bottom sheet allowing intuitive selection of Day (Mon-Sun) and Meal Slot (Breakfast, Lunch, Dinner, Snack).',
            cue: 'Progress Cue: Instant visual feedback with day pill highlight and floating snackbar confirmation.',
          ),
          _buildFlowStep(
            context,
            step: '04',
            title: 'Weekly Meal Plan (Day-by-Day Grid)',
            description:
                'A structured 7-day GridView layout displaying each day as a dedicated Card with meal slot chips, delete actions, and empty state prompts.',
            cue: 'Progress Cue: Planned days counter (X/7) and total meals counter with one-tap access to Grocery List.',
          ),
          _buildFlowStep(
            context,
            step: '05',
            title: 'Combined Grocery List (Deduplication)',
            description:
                'Automatically merges ingredients from all scheduled recipes using a Dart Map algorithm, grouping them by supermarket aisle.',
            cue: 'Progress Cue: Live shopping progress bar ("6 of 14 items collected - 42%").',
          ),
          const SizedBox(height: 20),

          // Technical Justifications
          _buildSectionHeader(context, '2. Architectural & Academic Justifications', Icons.verified_rounded),
          const SizedBox(height: 10),
          _buildJustificationCard(
            context,
            title: 'UI/Widgets Justification (GridView, Card, ListView)',
            content:
                '• GridView: Ideal for visual scanning in Browse (2-column layout) and Day-by-day Weekly Plan (7-day grid representation), offering predictable spatial orientation.\n'
                '• Card: Provides Material 3 surface elevation, clear visual boundaries, and modular containment for complex recipe metadata and day schedules.\n'
                '• ListView: Chosen for variable-length sequential items such as Ingredients, Cooking Steps, and Supermarket Aisles with smooth vertical scrolling.',
          ),
          _buildJustificationCard(
            context,
            title: 'Dart Logic Justification (Map-based Merging)',
            content:
                '• Time Complexity: O(N) where N is total ingredients across all planned recipes. Utilizing Map<String, Accumulator> with composite key "\${name.toLowerCase()}___\${unit.toLowerCase()}" enables constant O(1) duplicate detection and quantity aggregation.\n'
                '• Source Traceability: Each map accumulator preserves the originating recipe titles (e.g. "Needed for: Royal Shahi Paneer, Pizza"), ensuring transparency for the user.',
          ),
          _buildJustificationCard(
            context,
            title: 'Local Storage Justification (SharedPreferences JSON)',
            content:
                '• Cross-Platform Portability: SharedPreferences provides reliable, zero-native-dependency persistence across iOS, Android, macOS, and Web.\n'
                '• Structured Serialization: Recipe and WeeklyMealPlan models implement standard toJson() and fromJson() contracts, ensuring schema integrity between sessions.',
          ),
          _buildJustificationCard(
            context,
            title: 'Material 3 Styling & Theming Justification',
            content:
                '• Warm Terracotta (#D35400) triggers appetite and warmth (culinary psychology).\n'
                '• Sage Green (#2E7D32) reinforces fresh produce and health.\n'
                '• Soft Cream background (#FDFBF7) reduces eye strain compared to harsh #FFFFFF, enhancing readability during cooking.',
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, color: theme.colorScheme.primary, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildFlowStep(
    BuildContext context, {
    required String step,
    required String title,
    required String description,
    required String cue,
  }) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                step,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      cue,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJustificationCard(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              content,
              style: TextStyle(
                fontSize: 12,
                color: theme.colorScheme.onSurface,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
