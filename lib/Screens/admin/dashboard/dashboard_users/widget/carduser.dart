import 'package:ecommerce_flutter/Screens/admin/dashboard/dashboard_users/userdetailspage.dart';
import 'package:ecommerce_flutter/models/dashboard_users_model.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class AnimatedUserCard extends StatelessWidget {
  final User user;
  final int index;
  final bool isSelected;
  final bool isMultiSelectMode;
  final VoidCallback onTap;

  final void Function(String) onDismissedendtostart;
  final void Function(String) onDismissedStarttoend;

  const AnimatedUserCard({
    super.key,
    required this.user,
    required this.onDismissedStarttoend,
    required this.onDismissedendtostart,
    required this.index,
    required this.isSelected,
    required this.isMultiSelectMode,
    required this.onTap,
  });

  String _normalize(String? status) => (status ?? '').trim().toLowerCase();

  Color _statusBackground(BuildContext context, String status) {
    final s = _normalize(status);
    switch (s) {
      case 'active':
      case 'نشط':
        return Colors.green.shade50;
      case 'unactive':
      case 'غير نشط':
      case 'غير_نشط':
        return Colors.grey.shade100;
      case 'request':
      case 'pending':
      case 'بانتظار الموافقة':
      case 'طلب':
        return Colors.yellow.shade50;
      default:
        return Theme.of(context).cardColor;
    }
  }

  Color _roleBackground(BuildContext context, String role) {
    final s = _normalize(role);
    switch (s) {
      case 'admin':
      case 'مدير':
        return const Color.fromARGB(153, 98, 98, 98);
      case 'مستخدم':
      case "user":
        return const Color.fromARGB(255, 136, 199, 140);
      case 'vendor':
      case 'بائع':
        return const Color.fromARGB(255, 140, 120, 192);
      default:
        return Theme.of(context).cardColor;
    }
  }

  Color _statusBorder(BuildContext context, String status) {
    final s = _normalize(status);
    switch (s) {
      case 'active':
      case 'نشط':
        return Colors.green.shade700;
      case 'unactive':
      case 'غير نشط':
      case 'غير_نشط':
        return Colors.grey.shade500;
      case 'request':
      case 'pending':
      case 'بانتظار الموافقة':
      case 'طلب':
        return Colors.orange.shade700;
      default:
        return Theme.of(context).colorScheme.surfaceVariant;
    }
  }

  String _displayStatus(String status) {
    final s = _normalize(status);
    if (s == 'نشط' || s == 'active') return 'active';
    if (s == 'unactive' || s == 'غير نشط' || s == 'غير_نشط') return 'unactive';
    if (s == 'request' ||
        s == 'pending' ||
        s == 'بانتظار الموافقة' ||
        s == 'طلب') return 'request';
    return status;
  }

  static String _formatDate(DateTime dt) {
    final d = dt.day.toString().padLeft(2, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final y = dt.year;
    return '$d/$m/$y';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final bg = _statusBackground(context, user.status);
    final rg = _roleBackground(context, user.role);
    final borderColor = _statusBorder(context, user.status);
    final displayStatus = _displayStatus(user.status);

    return Dismissible(
      key: Key(user.email),
      direction: DismissDirection.horizontal,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) {
        if (direction == DismissDirection.startToEnd) {
          onDismissedStarttoend(user.email);
        } else if (direction == DismissDirection.endToStart) {
          onDismissedendtostart(user.email);
        }
        return Future.value(false);
      },
      child: OpenContainer(
        transitionDuration: const Duration(milliseconds: 500),
        closedElevation: 0,
        closedColor: Colors.transparent,
        openBuilder: (context, _) => UserDetailsPage(user: user),
        closedBuilder: (context, openContainer) => GestureDetector(
          onTap: openContainer,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2))
                  ],
                  border:
                      Border.all(color: borderColor.withOpacity(0.9), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: colorScheme.primary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            user.name,
                            style: textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: rg,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: borderColor.withOpacity(0.12), width: 1),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: borderColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                user.role,
                                style:
                                    textTheme.bodySmall?.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      user.email,
                      style: textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: bg,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: borderColor.withOpacity(0.12), width: 1),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: borderColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                displayStatus,
                                style:
                                    textTheme.bodySmall?.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Icon(Icons.calendar_today,
                                size: 14, color: colorScheme.onSurfaceVariant),
                            const SizedBox(width: 6),
                            Text(
                              _formatDate(user.createdAt),
                              style:
                                  textTheme.bodySmall?.copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isMultiSelectMode)
                Positioned(
                  top: 45,
                  left: 12,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      checkboxTheme: CheckboxThemeData(
                        fillColor:
                            MaterialStateProperty.all(colorScheme.primary),
                      ),
                    ),
                    child: Checkbox(
                      value: isSelected,
                      onChanged: (_) => onTap(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
