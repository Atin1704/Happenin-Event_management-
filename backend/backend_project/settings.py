from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent

SSL_CERT_PATH = BASE_DIR / 'certs' / 'prod-ca-2021.crt'  # Update this filename if different

SECRET_KEY = 'django-insecure-vg01@kd+7@6webc@xz9!pinlta^07%b)vv1yh9x*wyf$zggdfr'

DEBUG = True

ALLOWED_HOSTS = []  # Add your frontend or deployment host here in production


# Application definition
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'rest_framework',
    'core',  # Your custom app
    'corsheaders',
    
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'corsheaders.middleware.CorsMiddleware',
]
CORS_ALLOW_ALL_ORIGINS = True
ROOT_URLCONF = 'backend_project.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'backend_project.wsgi.application'


# Database configuration for Supabase PostgreSQL
DATABASE_URL = f"postgres://postgres:Dbmsaryantesting@db.pbonneurnkwdzudbbilc.supabase.co:5432/postgres?sslmode=verify-full&sslcert={str(SSL_CERT_PATH)}"

# DATABASES = {
#     'default': {
#         'ENGINE': 'django.db.backends.postgresql',
#         'NAME': 'DBMS Project',
#         'USER': 'postgres',
#         'PASSWORD': 'Abhinav@2108',
#         'HOST': 'localhost',     # or IP address if remote
#         'PORT': '5432',          # default PostgreSQL port
#     }
# }
# DATABASES = {
#     'default': {
#         'ENGINE': 'django.db.backends.postgresql',
#         'NAME': 'postgres',
#         'USER': 'postgres',
#         'PASSWORD': 'DbmsAryanTesting',
#         'HOST': 'db.ssrmyyssnzrhtofsjyyz.supabase.co',
#         'PORT': '5432',
#     }
# }

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'postgres',
        'USER': 'postgres',
        'PASSWORD': 'DbmsAryanTesting',
        'HOST': 'db.nelyuapvfjfcafbunfkc.supabase.co',
        'PORT': '5432',
    }
}

# Password validation
AUTH_PASSWORD_VALIDATORS = [
    {'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator'},
    {'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator'},
    {'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator'},
    {'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator'},
]


# Internationalization
LANGUAGE_CODE = 'en-us'
TIME_ZONE = 'UTC'
USE_I18N = True
USE_TZ = True


# Static files
STATIC_URL = 'static/'

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
