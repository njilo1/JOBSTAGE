from django.contrib import admin
from .models import JobCategory, JobOffer, JobApplication, SavedJob


@admin.register(JobCategory)
class JobCategoryAdmin(admin.ModelAdmin):
    list_display = ('name', 'created_at')
    search_fields = ('name', 'description')
    ordering = ('name',)


@admin.register(JobOffer)
class JobOfferAdmin(admin.ModelAdmin):
    list_display = ('title', 'company', 'category', 'contract_type', 'experience_level', 'status', 'is_active', 'created_at')
    list_filter = ('status', 'contract_type', 'experience_level', 'is_remote', 'is_active', 'is_featured', 'created_at')
    search_fields = ('title', 'description', 'company__company_name', 'location')
    readonly_fields = ('views_count', 'applications_count', 'created_at', 'updated_at')
    ordering = ('-created_at',)
    
    fieldsets = (
        ('Informations générales', {
            'fields': ('title', 'description', 'company', 'category', 'status')
        }),
        ('Détails de l\'emploi', {
            'fields': ('contract_type', 'experience_level', 'location', 'is_remote')
        }),
        ('Rémunération', {
            'fields': ('salary_min', 'salary_max', 'currency')
        }),
        ('Dates', {
            'fields': ('application_deadline', 'start_date')
        }),
        ('Statistiques', {
            'fields': ('views_count', 'applications_count', 'is_featured', 'is_active')
        }),
    )


@admin.register(JobApplication)
class JobApplicationAdmin(admin.ModelAdmin):
    list_display = ('candidate', 'job_offer', 'status', 'applied_at')
    list_filter = ('status', 'applied_at')
    search_fields = ('candidate__username', 'job_offer__title', 'job_offer__company__company_name')
    readonly_fields = ('applied_at', 'updated_at')
    ordering = ('-applied_at',)


@admin.register(SavedJob)
class SavedJobAdmin(admin.ModelAdmin):
    list_display = ('user', 'job_offer', 'saved_at')
    list_filter = ('saved_at',)
    search_fields = ('user__username', 'job_offer__title')
    ordering = ('-saved_at',)