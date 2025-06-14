from django.shortcuts import render

# Create your views here.
from rest_framework import serializers
from .models import User
from .models import Admin
from .models import Organizer
from django.core.exceptions import ValidationError
from .models import Event
class UserSignupSerializer(serializers.ModelSerializer):
    confirmPassword = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = ['username', 'password', 'confirmPassword', 'firstName', 'lastName', 'emailID', 'contactNo']

    def validate(self, data):
        if data['password'] != data['confirmPassword']:
            raise serializers.ValidationError("Passwords do not match.")
        if not data.get('emailID') and not data.get('contactNo'):
            raise serializers.ValidationError("Either emailID or contactNo is required.")
        return data

    def create(self, validated_data):
        validated_data.pop('confirmPassword')
        return User.objects.create(**validated_data)

class UserLoginSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField()

    


# app2/serializers.py


class AdminLoginSerializer(serializers.Serializer):
    emailID = serializers.EmailField()
    password = serializers.CharField(write_only=True)



class OrganizerLoginSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField(write_only=True)

    def validate(self, data):
        username = data.get('username')
        password = data.get('password')

        try:
            organizer = Organizer.objects.get(username=username)
        except Organizer.DoesNotExist:
            raise serializers.ValidationError("Invalid username or password.")

        if organizer.password != password:
            raise serializers.ValidationError("Invalid username or password.")

        return {
            "id": organizer.id,
            "username": organizer.username
        }
    
# app2/serializers.py

from rest_framework import serializers
from .models import Organizer

class OrganizerSignupSerializer(serializers.ModelSerializer):
    confirm_password = serializers.CharField(write_only=True)

    class Meta:
        model = Organizer
        fields = ['username', 'password', 'confirm_password', 'firstName', 'lastName', 'emailID', 'contactNo']
        extra_kwargs = {
            'password': {'write_only': True}
        }

    def validate(self, data):
        if data['password'] != data['confirm_password']:
            raise serializers.ValidationError("Passwords do not match.")
        
        if not data.get('emailID') and not data.get('contactNo'):
            raise serializers.ValidationError("Either emailID or contactNo must be provided.")

        return data

    def create(self, validated_data):
        validated_data.pop('confirm_password')  # remove before saving
        return Organizer.objects.create(**validated_data)
    



class EventDetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = Event
        fields = '__all__'

# serializers.py
from rest_framework import serializers
from .models import Event

class EventSerializer(serializers.ModelSerializer):
    class Meta:
        model = Event
        fields = '__all__'
        
class OrganizerListSerializer(serializers.ModelSerializer):
    class Meta:
        model = Organizer
        fields = ['id', 'username', 'firstName', 'lastName', 'emailID', 'contactNo', 'organization', 'verificationStatus']
