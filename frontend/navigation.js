// Navigation Functions
function navigateTo(page) {
    // Use happenin.co.in domain
    window.location.href = `https://happenin.co.in/${page}.html`;
}

// Logout Function
function logout() {
    // Clear any stored user data/session
    localStorage.removeItem('theme'); // Keep theme preference
    // Redirect to login page using the new domain
    window.location.href = 'https://happenin.co.in/login.html';
}

// Initialize Navigation
document.addEventListener('DOMContentLoaded', () => {
    // Dashboard Navigation
    const dashboardLinks = document.querySelectorAll('[data-nav="dashboard.html"]');
    dashboardLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            navigateTo('user_dashboard.html');
        });
    });

    // Events Navigation
    const eventsLinks = document.querySelectorAll('[data-nav="events"]');
    eventsLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            navigateTo('events.html');
        });
    });

    // Available Events Navigation
    const availableEventsLinks = document.querySelectorAll('[data-nav="available_events"]');
    availableEventsLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            navigateTo('available_events.html');
        });
    });

    // Past Events Navigation
    const pastEventsLinks = document.querySelectorAll('[data-nav="past_events"]');
    pastEventsLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            navigateTo('past_events.html');
        });
    });

    // Profile Navigation
    const profileLinks = document.querySelectorAll('[data-nav="profile"]');
    profileLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            navigateTo('profile.html');
        });
    });

    // Settings Navigation
    const settingsLinks = document.querySelectorAll('[data-nav="settings"]');
    settingsLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            navigateTo('settings.html');
        });
    });

    // Transactions Navigation
    const transactionsLinks = document.querySelectorAll('[data-nav="transactions"]');
    transactionsLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            navigateTo('transactions.html');
        });
    });

    // Logo Navigation (Home)
    const logoLinks = document.querySelectorAll('[data-nav="home"]');
    logoLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            navigateTo('index.html');
        });
    });

    // Logout Links
    const logoutLinks = document.querySelectorAll('[data-nav="logout"]');
    logoutLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            navigateTo('index.html')
        });
    });
});
