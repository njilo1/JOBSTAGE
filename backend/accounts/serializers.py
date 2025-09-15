from rest_framework import serializers
from django.contrib.auth import authenticate
from django.contrib.auth.password_validation import validate_password
from .models import User


class UserRegistrationSerializer(serializers.ModelSerializer):
    """Serializer pour l'inscription des utilisateurs"""
    password = serializers.CharField(write_only=True, validators=[validate_password])
    password_confirm = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = ('username', 'email', 'phone', 'password', 'password_confirm', 'user_type')
        extra_kwargs = {
            'password': {'write_only': True},
            'password_confirm': {'write_only': True},
        }

    def validate(self, attrs):
        if attrs['password'] != attrs['password_confirm']:
            raise serializers.ValidationError("Les mots de passe ne correspondent pas.")
        return attrs

    def create(self, validated_data):
        validated_data.pop('password_confirm')
        user = User.objects.create_user(**validated_data)
        return user


class UserLoginSerializer(serializers.Serializer):
    """Serializer pour la connexion des utilisateurs"""
    username = serializers.CharField()
    password = serializers.CharField()

    def validate(self, attrs):
        username = attrs.get('username')
        password = attrs.get('password')

        if username and password:
            # Essayer avec l'email, téléphone, ou username
            user = None
            if '@' in username:
                # Connexion par email
                user = authenticate(username=username, password=password)
            elif username.isdigit() or username.startswith('+'):
                # Connexion par téléphone
                try:
                    user_obj = User.objects.get(phone=username)
                    user = authenticate(username=user_obj.email, password=password)
                except User.DoesNotExist:
                    pass
            else:
                # Connexion par username
                try:
                    user_obj = User.objects.get(username=username)
                    user = authenticate(username=user_obj.email, password=password)
                except User.DoesNotExist:
                    pass
            
            if not user:
                raise serializers.ValidationError('Identifiants invalides.')
            if not user.is_active:
                raise serializers.ValidationError('Ce compte est désactivé.')
            attrs['user'] = user
            return attrs
        else:
            raise serializers.ValidationError('Email/Téléphone/Username et password requis.')


class UserSerializer(serializers.ModelSerializer):
    """Serializer pour les informations utilisateur"""
    class Meta:
        model = User
        fields = ('id', 'username', 'email', 'phone', 'user_type', 'is_verified', 'date_joined')
        read_only_fields = ('id', 'date_joined')


class PasswordChangeSerializer(serializers.Serializer):
    """Serializer pour le changement de mot de passe"""
    old_password = serializers.CharField()
    new_password = serializers.CharField(validators=[validate_password])
    new_password_confirm = serializers.CharField()

    def validate(self, attrs):
        if attrs['new_password'] != attrs['new_password_confirm']:
            raise serializers.ValidationError("Les nouveaux mots de passe ne correspondent pas.")
        return attrs

    def validate_old_password(self, value):
        user = self.context['request'].user
        if not user.check_password(value):
            raise serializers.ValidationError("Ancien mot de passe incorrect.")
        return value
