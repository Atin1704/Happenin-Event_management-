from django.urls import path
from .views import SignupView, LoginView, AdminLoginView, OrganizerLoginView, OrganizerSignupView, EventDetailView, FilteredEventView
//aryan
urlpatterns = [
    path('signup/', SignupView.as_view(), name='signup'),
    path('login/', LoginView.as_view(), name='login'),
    path('admin/login/', AdminLoginView.as_view(), name='admin-login'),
    path('organizer/login/', OrganizerLoginView.as_view(), name='organizer-login'),
    path('organizer/signup/', OrganizerSignupView.as_view(), name='organizer-signup'),
    path('event/<int:event_id>/', EventDetailView.as_view(), name='event-detail'),
    path('events/filtered/', FilteredEventView.as_view(), name='filtered-events'),
]

//atin
urlpatterns = [
    path('signup/', SignupView.as_view(), name='signup'),
    path('login/', LoginView.as_view(), name='login'),
    path('admin/login/', AdminLoginView.as_view(), name='admin-login'),
    path('organizer/login/', OrganizerLoginView.as_view(), name='organizer-login'),
    path('organizer/signup/', OrganizerSignupView.as_view(), name='organizer-signup'),
    path('event/<int:event_id>/', EventDetailView.as_view(), name='event-detail'),
    path('events/filtered/', FilteredEventView.as_view(), name='filtered-events'),
    path('events/organizer/<int:organizer_id>/', EventsByOrganizerView.as_view(), name='events-by-organizer'),





