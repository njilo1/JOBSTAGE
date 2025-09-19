import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/offre.dart';

class OfferCard extends StatelessWidget {
  final Offre offre;
  final VoidCallback? onTap;

  const OfferCard({
    super.key,
    required this.offre,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = !offre.isActive;
    
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isDisabled ? Colors.grey[100] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDisabled ? 0.05 : 0.08),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offre.titre,
                        style: AppTheme.titleMedium.copyWith(
                          color: isDisabled ? Colors.grey[600] : null,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      _OfferDetail(
                        icon: Icons.location_on,
                        text: offre.localisation,
                        color: isDisabled ? Colors.grey[500]! : AppTheme.customColors['orange_dark']!,
                        isDisabled: isDisabled,
                      ),
                      const SizedBox(height: 4),
                      _OfferDetail(
                        icon: Icons.description,
                        text: offre.dureeAffichage,
                        color: isDisabled ? Colors.grey[500]! : AppTheme.customColors['blue_dark']!,
                        isDisabled: isDisabled,
                      ),
                      const SizedBox(height: 4),
                      _OfferDetail(
                        icon: Icons.schedule,
                        text: _getTimeAgo(offre.datePublication),
                        color: isDisabled ? Colors.grey[500]! : AppTheme.customColors['secondary_text']!,
                        isDisabled: isDisabled,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _StatusBadge(
                      text: offre.isActive ? 'Active' : 'Désactivée',
                      isActive: offre.isActive,
                    ),
                    const SizedBox(height: 8),
                    _CandidatesCount(count: offre.nombreCandidats, isDisabled: isDisabled),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return 'Il y a ${difference.inDays} jour${difference.inDays > 1 ? 's' : ''}';
    } else if (difference.inHours > 0) {
      return 'Il y a ${difference.inHours} heure${difference.inHours > 1 ? 's' : ''}';
    } else if (difference.inMinutes > 0) {
      return 'Il y a ${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''}';
    } else {
      return 'À l\'instant';
    }
  }
}

class _OfferDetail extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final bool isDisabled;

  const _OfferDetail({
    required this.icon,
    required this.text,
    required this.color,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: color,
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            style: AppTheme.bodyMedium.copyWith(
              color: isDisabled ? Colors.grey[500] : AppTheme.customColors['secondary_text'],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String text;
  final bool isActive;

  const _StatusBadge({
    required this.text,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive
            ? AppTheme.customColors['green_light']
            : AppTheme.customColors['red_light'],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: AppTheme.labelSmall.copyWith(
          color: isActive
              ? AppTheme.customColors['green_dark']
              : AppTheme.customColors['red_dark'],
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _CandidatesCount extends StatelessWidget {
  final int count;
  final bool isDisabled;

  const _CandidatesCount({required this.count, this.isDisabled = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDisabled ? Colors.grey[200] : AppTheme.customColors['blue_light'],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.person,
            size: 16,
            color: isDisabled ? Colors.grey[500] : AppTheme.customColors['blue_dark'],
          ),
          const SizedBox(width: 4),
          Text(
            count.toString(),
            style: AppTheme.labelSmall.copyWith(
              color: isDisabled ? Colors.grey[500] : AppTheme.customColors['blue_dark'],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
