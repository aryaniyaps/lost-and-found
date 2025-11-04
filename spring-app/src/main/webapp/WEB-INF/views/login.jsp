<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 min-h-screen flex items-center justify-center">
    <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-md">
        <h2 class="text-3xl font-bold text-gray-900 mb-6 text-center">Login</h2>
        <form id="loginForm" class="space-y-4">
            <div>
                <input type="email" name="email" placeholder="Email" required 
                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
            </div>
            <div>
                <input type="password" name="password" placeholder="Password" required 
                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
            </div>
            <button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 text-white py-3 rounded-lg font-semibold">Login</button>
        </form>
        <p class="mt-4 text-center text-gray-600">Don't have an account? <a href="/register" class="text-blue-600 hover:underline">Register</a></p>
    </div>
    <script>
        const loginForm = document.getElementById('loginForm');
        const showError = (msg) => alert(msg || 'Login failed');

        loginForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            const formData = new FormData(e.target);
            const data = Object.fromEntries(formData);

            // Basic client-side validation
            if (!data.email || !data.password) {
                showError('Please enter email and password');
                return;
            }

            try {
                const res = await fetch('/api/auth/login', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify(data)
                });
                const body = await res.json().catch(() => ({}));
                if (res.ok && body.token) {
                    localStorage.setItem('token', body.token);
                    window.location.href = '/items';
                } else {
                    showError(body.error || 'Login failed');
                }
            } catch (err) {
                console.error('Login error', err);
                showError('Network error. Please try again.');
            }
        });
    </script>
</body>
</html>
