from django.shortcuts import render

# Create your views here.
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import User, Admin, Organizer,Event 
from .serializers import UserSignupSerializer, UserLoginSerializer, AdminLoginSerializer, OrganizerLoginSerializer, EventDetailSerializer, EventSerializer
from django.db.models import Q, F
from django.utils import timezone
from django.utils.timezone import now


class SignupView(APIView):
    def post(self, request):
        serializer = UserSignupSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            return Response({
                "uid": user.id,
                "username": user.username
            }, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class LoginView(APIView):
    def post(self, request):
        serializer = UserLoginSerializer(data=request.data)
        if serializer.is_valid():
            username = serializer.validated_data['username']
            password = serializer.validated_data['password']
            try:
                user = User.objects.get(username=username)
                if user.password == password:
                    return Response({
                        "uid": user.id,
                        "username": user.username
                    }, status=status.HTTP_200_OK)
                else:
                    return Response({"error": "Invalid password"}, status=status.HTTP_401_UNAUTHORIZED)
            except User.DoesNotExist:
                return Response({"error": "User not found"}, status=status.HTTP_404_NOT_FOUND)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    
class AdminLoginView(APIView):
    def post(self, request):
        serializer = AdminLoginSerializer(data=request.data)
        if serializer.is_valid():
            email = serializer.validated_data['emailID']
            password = serializer.validated_data['password']

            try:
                admin = Admin.objects.get(emailID=email)
                if admin.password == password:
                    return Response({
                        "id": admin.id,
                        "emailID": admin.emailID,
                        "role": admin.role
                    }, status=status.HTTP_200_OK)
                else:
                    return Response({"error": "Invalid password."}, status=status.HTTP_401_UNAUTHORIZED)

            except Admin.DoesNotExist:
                return Response({"error": "Admin not found."}, status=status.HTTP_404_NOT_FOUND)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    


# app2/views.py

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .serializers import OrganizerLoginSerializer

class OrganizerLoginView(APIView):
    def post(self, request):
        serializer = OrganizerLoginSerializer(data=request.data)
        if serializer.is_valid():
            return Response(serializer.validated_data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
# app2/views.py

from .serializers import OrganizerSignupSerializer

class OrganizerSignupView(APIView):
    def post(self, request):
        serializer = OrganizerSignupSerializer(data=request.data)
        if serializer.is_valid():
            organizer = serializer.save()
            return Response({
                "id": organizer.id,
                "username": organizer.username
            }, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    




class EventDetailView(APIView):
    def get(self, request, event_id):
        try:
            event = Event.objects.get(id=event_id)
        except Event.DoesNotExist:
            return Response({"error": "Event not found"}, status=status.HTTP_404_NOT_FOUND)

        serializer = EventDetailSerializer(event)
        return Response(serializer.data, status=status.HTTP_200_OK)
    

class FilteredEventView(APIView):
    def get(self, request):
        current_datetime = now().astimezone()
        current_date = current_datetime.date()
        current_time = current_datetime.time()

        # Mapping of shortform to matching category strings
        category_map = {
            'ea': ['Concert', 'Dance', 'Art'],
            'bt': ['Business', 'Tech'],
            'fl': ['Food', 'Expo'],
            'si': ['Charity'],
            'sf': ['Sports', 'Gaming']
        }

        # Get and normalize the filter param to lowercase
        filter_key = request.query_params.get('filter', '').lower()
        categories = category_map.get(filter_key, None)

        # Base query: upcoming events that are not full
        query = Event.objects.filter(
            Q(startDate__gt=current_date) |
            Q(startDate=current_date, startTime__gt=current_time)
        ).exclude(
            ticketsSold=F('maxAttendees')
        )

        # If a valid filter is provided, filter by category
        if categories:
            query = query.filter(category__in=categories)

        serializer = EventSerializer(query, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    



class EventsByOrganizerView(APIView):
    def get(self, request, organizer_id):
        current_datetime = now().astimezone()
        current_date = current_datetime.date()
        current_time = current_datetime.time()

        # Base query
        events = Event.objects.filter(organizer__id=organizer_id)

        # Optional filter: 0 = upcoming, 1 = past
        filter_value = request.query_params.get('filter', None)

        if filter_value == '0':
            # Upcoming: date is in future or today with time > now
            events = events.filter(
                Q(startDate__gt=current_date) |
                Q(startDate=current_date, startTime__gt=current_time)
            )
        elif filter_value == '1':
            # Past: date is in past or today with time < now
            events = events.filter(
                Q(startDate__lt=current_date) |
                Q(startDate=current_date, startTime__lt=current_time)
            )

        serializer = EventSerializer(events, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

class OrganizersByAdminView(APIView):
    def get(self, request, staff_id):
        organizers = Organizer.objects.filter(staff__id=staff_id)
        
        if not organizers.exists():
            return Response({"message": "No organizers found for this admin."}, status=status.HTTP_404_NOT_FOUND)
        
        serializer = OrganizerListSerializer(organizers, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)


