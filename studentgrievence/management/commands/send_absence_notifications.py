"""
Management command to send daily absence notifications to parents
Run this at end of day (e.g., 4:30 PM) via cron job
"""
from django.core.management.base import BaseCommand
from studentgrievence.email_notifications import check_and_send_daily_absence_notifications


class Command(BaseCommand):
    help = 'Send absence notifications to parents for students absent today'

    def handle(self, *args, **kwargs):
        self.stdout.write(self.style.SUCCESS('Starting daily absence notification check...'))
        check_and_send_daily_absence_notifications()
        self.stdout.write(self.style.SUCCESS('[OK] Daily absence notifications sent!'))
