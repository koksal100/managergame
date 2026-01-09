import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/player_filter.dart';
import '../providers/player_provider.dart';

class PlayerFilterModal extends ConsumerStatefulWidget {
  const PlayerFilterModal({super.key});

  @override
  ConsumerState<PlayerFilterModal> createState() => _PlayerFilterModalState();
}

class _PlayerFilterModalState extends ConsumerState<PlayerFilterModal> {
  // Temporary state
  List<String> _selectedPositions = [];
  double _minAge = 15;
  double _maxAge = 40;
  double _minCa = 0;
  double _minPa = 0;

  // Design Constants - Elegant & Thin
  final Color _accentColor = const Color(0xFF3B82F6);
  final Color _glassBackground = const Color(0xFF0F172A).withOpacity(0.60); // Transparent Dark Slate

  @override
  void initState() {
    super.initState();
    final currentFilter = ref.read(playerFilterProvider);
    _selectedPositions = List.from(currentFilter.positions ?? []);
    _minAge = currentFilter.minAge?.toDouble() ?? 15;
    _maxAge = currentFilter.maxAge?.toDouble() ?? 40;
    _minCa = currentFilter.minCa?.toDouble() ?? 0;
    _minPa = currentFilter.minPa?.toDouble() ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.60, // Slightly more compact
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      decoration: BoxDecoration(
        color: _glassBackground, // Transparent elegant background
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 40,
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag Handle - Thinner
          Center(
            child: Container(
              width: 36,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Header - Light Font Weight
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter Players',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w300, // Elegant Light
                  letterSpacing: 0.8,
                ),
              ),
              TextButton(
                onPressed: _resetFilters,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white54,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Reset',
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                ),
              )
            ],
          ),
          Divider(color: Colors.white.withOpacity(0.08), height: 24),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Positions
                  _buildSectionHeader('Positions', 'Select roles'),
                  const SizedBox(height: 10), // Closer elements
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: ['GK', 'DEF', 'MID', 'FWD'].map((pos) {
                        final isSelected = _selectedPositions.contains(pos);
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          child: FilterChip(
                            label: Text(
                              pos,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w400, // Regular
                              ),
                            ),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _selectedPositions.add(pos);
                                } else {
                                  _selectedPositions.remove(pos);
                                }
                              });
                            },
                            backgroundColor: Colors.white.withOpacity(0.03),
                            selectedColor: _accentColor.withOpacity(0.8), // Slightly transparent accent
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: isSelected ? Colors.transparent : Colors.white.withOpacity(0.08),
                                width: 0.5, // Thinner border
                              ),
                            ),
                            showCheckmark: false,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20), // Reduced spacing

                  // Age Range
                  _buildSliderHeader('Age Range', '${_minAge.round()} - ${_maxAge.round()}'),
                  SliderTheme(
                    data: _customSliderTheme(context),
                    child: RangeSlider(
                      values: RangeValues(_minAge, _maxAge),
                      min: 15,
                      max: 45,
                      divisions: 30,
                      onChanged: (values) {
                        setState(() {
                          _minAge = values.start;
                          _maxAge = values.end;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16), // Reduced spacing

                  // CA Slider
                  _buildSliderHeader('Current Ability', '${_minCa.round()}'),
                  SliderTheme(
                    data: _customSliderTheme(context),
                    child: Slider(
                      value: _minCa,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      onChanged: (val) {
                        setState(() => _minCa = val);
                      },
                    ),
                  ),
                  const SizedBox(height: 16), // Reduced spacing

                  // PA Slider
                  _buildSliderHeader('Potential Ability', '${_minPa.round()}'),
                  SliderTheme(
                    data: _customSliderTheme(context),
                    child: Slider(
                      value: _minPa,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      onChanged: (val) {
                        setState(() => _minPa = val);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Apply Button - Elegant & Thin
          SafeArea(
            top: false,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 12),
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accentColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0, // Flat elegant look
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Apply Filters',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400, // Regular weight
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Methods ---

  void _resetFilters() {
    setState(() {
      _selectedPositions = [];
      _minAge = 15;
      _maxAge = 40;
      _minCa = 0;
      _minPa = 0;
    });
  }

  void _applyFilters() {
    final currentQuery = ref.read(playerFilterProvider).nameQuery;

    final newFilter = PlayerFilter(
      nameQuery: currentQuery,
      positions: _selectedPositions.isEmpty ? null : _selectedPositions,
      minAge: _minAge.round(),
      maxAge: _maxAge.round(),
      minCa: _minCa.round() > 0 ? _minCa.round() : null,
      minPa: _minPa.round() > 0 ? _minPa.round() : null,
    );

    ref.read(playerFilterProvider.notifier).state = newFilter;
    Navigator.pop(context);
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400 // Regular
          ),
        ),
        const SizedBox(width: 8),
        Text(
          subtitle,
          style: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontSize: 12,
              fontWeight: FontWeight.w300 // Light
          ),
        ),
      ],
    );
  }

  Widget _buildSliderHeader(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0), // Removed padding to bring closer
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14,
                fontWeight: FontWeight.w300 // Light
            ),
          ),
          Text(
            value,
            style: TextStyle(
                color: _accentColor,
                fontSize: 14,
                fontWeight: FontWeight.w400 // Regular
            ),
          ),
        ],
      ),
    );
  }

  SliderThemeData _customSliderTheme(BuildContext context) {
    return SliderTheme.of(context).copyWith(
      activeTrackColor: _accentColor,
      inactiveTrackColor: Colors.white.withOpacity(0.05),
      trackShape: const RoundedRectSliderTrackShape(),
      trackHeight: 2.0, // Thinner track
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0), // Smaller thumb
      thumbColor: Colors.white,
      overlayColor: _accentColor.withOpacity(0.1),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
      tickMarkShape: const RoundSliderTickMarkShape(),
      activeTickMarkColor: Colors.transparent,
      inactiveTickMarkColor: Colors.transparent,
      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
      valueIndicatorColor: _accentColor,
      valueIndicatorTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400, // Not Bold
      ),
    );
  }
}