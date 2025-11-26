from django.core.management.base import BaseCommand
from django.contrib.auth.models import User
import os

class Command(BaseCommand):
    help = 'Initialize the system with default data'

    def handle(self, *args, **options):
        self.stdout.write('🚀 Initializing Tutor Control System...')
        
        # Create superuser if it doesn't exist
        if not User.objects.filter(username='admin').exists():
            User.objects.create_superuser(
                username='admin', 
                email='admin@example.com', 
                password='admin123'
            )
            self.stdout.write(
                self.style.SUCCESS('✅ Superuser created: admin / admin123')
            )
        else:
            self.stdout.write('ℹ️ Superuser already exists')
        
        self.stdout.write(
            self.style.SUCCESS('✅ System initialization completed!')
        )