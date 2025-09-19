from rest_framework import status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.response import Response
from rest_framework.authtoken.models import Token
from django.contrib.auth import login, logout
from django.core.files.storage import default_storage
from django.core.files.base import ContentFile
from django.conf import settings
import os
from .models import User, CandidateProfile
from .serializers import (
    UserRegistrationSerializer, UserLoginSerializer, UserSerializer,
    PasswordChangeSerializer, CandidateProfileSerializer
)


@api_view(['POST'])
@permission_classes([AllowAny])
def register(request):
    """Inscription d'un nouvel utilisateur"""
    serializer = UserRegistrationSerializer(data=request.data)
    if serializer.is_valid():
        user = serializer.save()
        token, created = Token.objects.get_or_create(user=user)
        return Response({
            'user': UserSerializer(user).data,
            'token': token.key,
            'message': 'Inscription réussie'
        }, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
@permission_classes([AllowAny])
def login_view(request):
    """Connexion d'un utilisateur"""
    serializer = UserLoginSerializer(data=request.data)
    if serializer.is_valid():
        user = serializer.validated_data['user']
        login(request, user)
        token, created = Token.objects.get_or_create(user=user)
        return Response({
            'user': UserSerializer(user).data,
            'token': token.key,
            'message': 'Connexion réussie'
        }, status=status.HTTP_200_OK)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
@permission_classes([IsAuthenticated])
def logout_view(request):
    """Déconnexion d'un utilisateur"""
    try:
        request.user.auth_token.delete()
    except:
        pass
    logout(request)
    return Response({'message': 'Déconnexion réussie'}, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def user_profile(request):
    """Récupérer le profil de l'utilisateur connecté avec son profil candidat"""
    user = request.user
    
    # Récupérer ou créer le profil candidat
    try:
        profile = user.candidate_profile
    except CandidateProfile.DoesNotExist:
        # Créer un profil candidat s'il n'existe pas
        profile = CandidateProfile.objects.create(user=user)
    
    return Response({
        'user': UserSerializer(user).data,
        'profile': CandidateProfileSerializer(profile).data
    })


@api_view(['POST'])
@permission_classes([IsAuthenticated])
def change_password(request):
    """Changer le mot de passe"""
    serializer = PasswordChangeSerializer(data=request.data, context={'request': request})
    if serializer.is_valid():
        user = request.user
        user.set_password(serializer.validated_data['new_password'])
        user.save()
        return Response({'message': 'Mot de passe changé avec succès'})
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
@permission_classes([IsAuthenticated])
def upload_profile_photo(request):
    """Uploader une photo de profil"""
    try:
        if 'photo' not in request.FILES:
            return Response({
                'success': False,
                'message': 'Aucune photo fournie'
            }, status=status.HTTP_400_BAD_REQUEST)
        
        photo = request.FILES['photo']
        user = request.user
        
        # Récupérer ou créer le profil candidat
        try:
            profile = user.candidate_profile
        except CandidateProfile.DoesNotExist:
            profile = CandidateProfile.objects.create(user=user)
        
        # Supprimer l'ancienne photo si elle existe
        if profile.profile_photo:
            try:
                if os.path.isfile(profile.profile_photo.path):
                    os.remove(profile.profile_photo.path)
            except:
                pass
        
        # Sauvegarder la nouvelle photo
        profile.profile_photo = photo
        profile.save()
        
        # Construire l'URL complète de la photo
        photo_url = request.build_absolute_uri(profile.profile_photo.url)
        
        return Response({
            'success': True,
            'message': 'Photo de profil mise à jour avec succès',
            'photo_url': photo_url
        }, status=status.HTTP_200_OK)
        
    except Exception as e:
        return Response({
            'success': False,
            'message': f'Erreur lors de l\'upload: {str(e)}'
        }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['PUT'])
@permission_classes([IsAuthenticated])
def update_user_info(request):
    """Mettre à jour les informations utilisateur"""
    try:
        user = request.user
        data = request.data
        
        print(f"📞 Mise à jour utilisateur {user.username}: {data}")
        
        # Mettre à jour les champs fournis
        if 'first_name' in data:
            user.first_name = data['first_name']
            print(f"✅ Prénom mis à jour: {data['first_name']}")
        if 'last_name' in data:
            user.last_name = data['last_name']
            print(f"✅ Nom mis à jour: {data['last_name']}")
        if 'phone' in data:
            old_phone = user.phone
            user.phone = data['phone']
            print(f"✅ Téléphone mis à jour: {old_phone} -> {data['phone']}")
        
        user.save()
        print(f"✅ Utilisateur sauvegardé: {user.username}")
        
        return Response({
            'success': True,
            'message': 'Informations utilisateur mises à jour avec succès',
            'user': UserSerializer(user).data
        }, status=status.HTTP_200_OK)
        
    except Exception as e:
        print(f"❌ Erreur mise à jour utilisateur: {str(e)}")
        return Response({
            'success': False,
            'message': f'Erreur lors de la mise à jour: {str(e)}'
        }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['PUT'])
@permission_classes([IsAuthenticated])
def update_candidate_profile(request):
    """Mettre à jour le profil candidat"""
    try:
        user = request.user
        data = request.data
        
        # Récupérer ou créer le profil candidat
        try:
            profile = user.candidate_profile
        except CandidateProfile.DoesNotExist:
            profile = CandidateProfile.objects.create(user=user)
        
        # Mettre à jour les champs fournis
        if 'bio' in data:
            profile.bio = data['bio']
        if 'location' in data:
            profile.location = data['location']
        if 'skills' in data:
            profile.skills = data['skills']
        if 'job_title' in data:
            profile.job_title = data['job_title']
        if 'experience_years' in data:
            profile.experience_years = data['experience_years']
        if 'expected_salary' in data:
            profile.expected_salary = data['expected_salary']
        if 'contract_type' in data:
            profile.contract_type = data['contract_type']
        
        # Gérer les préférences d'emploi
        if 'preferred_job_type' in data:
            profile.preferred_job_type = data['preferred_job_type']
        if 'experience_level' in data:
            profile.experience_level = data['experience_level']
        if 'salary_range_min' in data:
            profile.salary_range_min = data['salary_range_min']
        if 'salary_range_max' in data:
            profile.salary_range_max = data['salary_range_max']
        if 'preferred_work_location' in data:
            profile.preferred_work_location = data['preferred_work_location']
        if 'remote_work' in data:
            profile.remote_work = data['remote_work']
        if 'preferred_industries' in data:
            profile.preferred_industries = data['preferred_industries']
        
        profile.save()
        
        return Response({
            'success': True,
            'message': 'Profil candidat mis à jour avec succès',
            'profile': CandidateProfileSerializer(profile).data
        }, status=status.HTTP_200_OK)
        
    except Exception as e:
        return Response({
            'success': False,
            'message': f'Erreur lors de la mise à jour: {str(e)}'
        }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['POST'])
@permission_classes([IsAuthenticated])
def upload_cv(request):
    """Upload d'un CV pour un candidat"""
    try:
        if request.user.user_type != 'candidat':
            return Response({
                'success': False,
                'message': 'Seuls les candidats peuvent uploader des CVs'
            }, status=status.HTTP_403_FORBIDDEN)
        
        profile, created = CandidateProfile.objects.get_or_create(user=request.user)
        
        if 'cv' not in request.FILES:
            return Response({
                'success': False,
                'message': 'Aucun fichier CV fourni'
            }, status=status.HTTP_400_BAD_REQUEST)
        
        cv_file = request.FILES['cv']
        
        # Vérifier le type de fichier
        allowed_extensions = ['.pdf', '.doc', '.docx']
        file_extension = os.path.splitext(cv_file.name)[1].lower()
        if file_extension not in allowed_extensions:
            return Response({
                'success': False,
                'message': 'Format de fichier non supporté. Utilisez PDF, DOC ou DOCX'
            }, status=status.HTTP_400_BAD_REQUEST)
        
        # Vérifier la taille du fichier (5MB max)
        if cv_file.size > 5 * 1024 * 1024:
            return Response({
                'success': False,
                'message': 'Le fichier est trop volumineux. Taille maximale: 5MB'
            }, status=status.HTTP_400_BAD_REQUEST)
        
        # Sauvegarder le fichier
        profile.cv_file = cv_file
        profile.save()
        
        return Response({
            'success': True,
            'message': 'CV uploadé avec succès',
            'cv_url': profile.cv_file.url if profile.cv_file else None
        }, status=status.HTTP_200_OK)
        
    except Exception as e:
        return Response({
            'success': False,
            'message': f'Erreur lors de l\'upload: {str(e)}'
        }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_cvs(request):
    """Récupérer la liste des CVs d'un candidat"""
    try:
        if request.user.user_type != 'candidat':
            return Response({
                'success': False,
                'message': 'Seuls les candidats peuvent accéder aux CVs'
            }, status=status.HTTP_403_FORBIDDEN)
        
        profile, created = CandidateProfile.objects.get_or_create(user=request.user)
        
        cvs = []
        if profile.cv_file:
            cvs.append({
                'id': profile.id,
                'name': os.path.basename(profile.cv_file.name),
                'url': profile.cv_file.url,
                'uploaded_at': profile.updated_at.isoformat(),
                'size': profile.cv_file.size
            })
        
        return Response({
            'success': True,
            'cvs': cvs
        }, status=status.HTTP_200_OK)
        
    except Exception as e:
        return Response({
            'success': False,
            'message': f'Erreur lors de la récupération: {str(e)}'
        }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['DELETE'])
@permission_classes([IsAuthenticated])
def delete_cv(request, cv_id):
    """Supprimer un CV"""
    try:
        if request.user.user_type != 'candidat':
            return Response({
                'success': False,
                'message': 'Seuls les candidats peuvent supprimer des CVs'
            }, status=status.HTTP_403_FORBIDDEN)
        
        profile, created = CandidateProfile.objects.get_or_create(user=request.user)
        
        if profile.cv_file:
            # Supprimer le fichier du stockage
            if os.path.exists(profile.cv_file.path):
                os.remove(profile.cv_file.path)
            
            # Supprimer la référence dans la base de données
            profile.cv_file = None
            profile.save()
            
            return Response({
                'success': True,
                'message': 'CV supprimé avec succès'
            }, status=status.HTTP_200_OK)
        else:
            return Response({
                'success': False,
                'message': 'Aucun CV trouvé'
            }, status=status.HTTP_404_NOT_FOUND)
        
    except Exception as e:
        return Response({
            'success': False,
            'message': f'Erreur lors de la suppression: {str(e)}'
        }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)