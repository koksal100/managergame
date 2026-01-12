import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../agents/providers/user_agent_provider.dart';
import '../../../office/domain/entities/office_staff.dart';
import '../../../office/providers/office_provider.dart';


class ContractsPage extends ConsumerWidget {
  const ContractsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const int userId = 1;
    final staffAsync = ref.watch(officeStaffProvider(userId));
    final totalCostAsync = ref.watch(officeStaffCostProvider(userId));
    final userAgentAsync = ref.watch(userAgentProvider);

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background
          Image.asset(
            'assets/images/contract_background.png',
            fit: BoxFit.cover,
            errorBuilder: (c, o, s) => Container(color: Colors.grey[900]),
          ),
          
          // Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.7), // Darker top
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        "OFFICE MANAGEMENT",
                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                      ),
                      const SizedBox(height: 10),
                      userAgentAsync.when(
                        data: (agent) => Text("Balance: \$${agent?.balance.toStringAsFixed(0) ?? '0'}", style: const TextStyle(color: Colors.greenAccent, fontSize: 16)),
                        loading: () => const SizedBox(),
                        error: (_,__) => const SizedBox(),
                      ),
                      const SizedBox(height: 5),
                      totalCostAsync.when(
                        data: (cost) => Text("Weekly Staff Cost: -\$${cost}", style: const TextStyle(color: Colors.redAccent, fontSize: 14)),
                        loading: () => const SizedBox(),
                        error: (_,__) => const SizedBox(),
                      ),
                    ],
                  ),
                ),

                // Staff Lists
                Expanded(
                  child: staffAsync.when(
                    data: (staffList) {
                      return ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        children: [
                          _buildStaffSection(context, ref, userId, "Scouting Department", StaffType.scout, staffList, Icons.search),
                          _buildStaffSection(context, ref, userId, "Media Relations", StaffType.journalist, staffList, Icons.newspaper),
                          _buildStaffSection(context, ref, userId, "Medical Staff", StaffType.physio, staffList, Icons.medical_services),
                          const SizedBox(height: 100), // Bottom padding
                        ],
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, s) => Center(child: Text("Error: $e", style: const TextStyle(color: Colors.red))),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffSection(
    BuildContext context, 
    WidgetRef ref, 
    int userId, 
    String title, 
    StaffType type, 
    List<OfficeStaff> currentStaff, 
    IconData icon
  ) {
    return Card(
      color: Colors.white.withOpacity(0.05),
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(color: Colors.white.withOpacity(0.1))),
      child: ExpansionTile(
        initiallyExpanded: false,
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        childrenPadding: const EdgeInsets.all(10),
        collapsedIconColor: Colors.white54,
        iconColor: Colors.blueAccent,
        children: [
          // Header Row
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                Expanded(flex: 2, child: Text("Level", style: TextStyle(color: Colors.white54, fontSize: 12))),
                Expanded(flex: 2, child: Text("Cost/Wk", style: TextStyle(color: Colors.white54, fontSize: 12))),
                Expanded(flex: 2, child: Text("Hired", style: TextStyle(color: Colors.white54, fontSize: 12))),
                Expanded(flex: 3, child: Text("Actions", style: TextStyle(color: Colors.white54, fontSize: 12), textAlign: TextAlign.right)),
              ],
            ),
          ),
          const Divider(color: Colors.white10),
          
          // Levels 1-5
          for (int level = 1; level <= 5; level++)
            _buildStaffRow(ref, userId, type, level, currentStaff),
        ],
      ),
    );
  }

  Widget _buildStaffRow(WidgetRef ref, int userId, StaffType type, int level, List<OfficeStaff> allStaff) {
    // Find staff record for this type/level
    final staff = allStaff.firstWhere(
      (s) => s.type == type && s.level == level,
      orElse: () => OfficeStaff(id: 0, agentId: userId, type: type, level: level, count: 0),
    );

    final weeklyCost = staff.weeklyCost;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Row(
        children: [
          // Level (Stars)
          Expanded(
            flex: 2,
            child: Row(
              children: List.generate(level, (index) => const Icon(Icons.star, size: 12, color: Colors.amber)),
            ),
          ),
          // Cost
          Expanded(
            flex: 2,
            child: Text("\$$weeklyCost", style: const TextStyle(color: Colors.white70)),
          ),
          // Count
          Expanded(
            flex: 2,
            child: Text("${staff.count}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          // Actions
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Fire
                if (staff.count > 0)
                  _ActionButton(
                    icon: Icons.remove, 
                    color: Colors.redAccent, 
                    onTap: () async {
                      await ref.read(officeRepositoryProvider).fireStaff(userId, type, level);
                      ref.invalidate(officeStaffProvider(userId));
                      ref.invalidate(officeStaffCostProvider(userId));
                    }
                  )
                else
                  const SizedBox(width: 32),
                
                const SizedBox(width: 8),
                
                // Hire
                _ActionButton(
                  icon: Icons.add, 
                  color: Colors.greenAccent, 
                  onTap: () async {
                    await ref.read(officeRepositoryProvider).hireStaff(userId, type, level);
                    ref.invalidate(officeStaffProvider(userId));
                    ref.invalidate(officeStaffCostProvider(userId));
                  }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: color.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(20),
          color: color.withOpacity(0.1),
        ),
        child: Icon(icon, color: color, size: 16),
      ),
    );
  }
}

