<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 min-h-screen flex items-center justify-center">
    <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-md">
        <h2 class="text-3xl font-bold text-gray-900 mb-6 text-center">Register</h2>
        <form id="registerForm" class="space-y-4">
            <div>
                <input type="text" name="name" placeholder="Full Name" required 
                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-transparent">
            </div>
            <div>
                <input type="email" name="email" placeholder="Email" required 
                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-transparent">
            </div>
            <div>
                <input type="password" name="password" placeholder="Password" required 
                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-transparent">
            </div>
            <div>
                <input type="tel" name="phone" placeholder="Phone (optional)" 
                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-transparent">
            </div>
            <button type="submit" class="w-full bg-green-600 hover:bg-green-700 text-white py-3 rounded-lg font-semibold">Register</button>
        </form>
        <p class="mt-4 text-center text-gray-600">Already have an account? <a href="/login" class="text-green-600 hover:underline">Login</a></p>
    </div>
    <script>
        const registerForm = document.getElementById('registerForm');
        const showError = (msg) => alert(msg || 'Registration failed');

        registerForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            const formData = new FormData(e.target);
            const data = Object.fromEntries(formData);

            // Basic client-side validation
            if (!data.email || !data.password || !data.name) {
                showError('Name, email and password are required');
                return;
            }

            try {
                const res = await fetch('/api/auth/register', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify(data)
                });
                const body = await res.json().catch(() => ({}));
                if (res.ok && body.token) {
                    localStorage.setItem('token', body.token);
                    window.location.href = '/items';
                } else {
                    showError(body.error || 'Registration failed');
                }
            } catch (err) {
                console.error('Registration error', err);
                showError('Network error. Please try again.');
            }
        });
    </script>
</body>
</html>
