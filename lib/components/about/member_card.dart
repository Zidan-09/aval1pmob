import 'package:aval1pmob/components/about/member_artwork.dart';
import 'package:aval1pmob/entities/team_member.dart';
import 'package:flutter/material.dart';

class MemberCard extends StatelessWidget {
  final TeamMember member;

  const MemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 5, 12, 5),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A22).withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          left: BorderSide(color: Colors.redAccent, width: 4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MemberArtwork(imageAsset: member.imageAsset, name: member.name),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  member.role,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
