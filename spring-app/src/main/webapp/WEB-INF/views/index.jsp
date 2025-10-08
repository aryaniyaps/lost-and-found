<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lost and Found</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
    <nav class="bg-gray-800 text-white shadow-lg">
        <div class="max-w-7xl mx-auto px-4 py-4">
            <div class="flex justify-between items-center">
                <div class="text-xl font-bold">Lost & Found</div>
                <div class="space-x-6" id="navLinks">
                    <a href="/" class="hover:text-blue-400">Home</a>
                    <a href="/items" class="hover:text-blue-400">Items</a>
                    <a href="/complaints" class="hover:text-blue-400">Complaints</a>
                </div>
            </div>
        </div>
    </nav>
    <div class="max-w-7xl mx-auto px-4 py-12">
        <div class="text-center mb-12">
            <h1 class="text-5xl font-bold text-gray-900 mb-4">Lost and Found System</h1>
            <p class="text-xl text-gray-600">Report lost items or help return found items to their owners.</p>
        </div>
        <div class="flex justify-center gap-4">
            <a href="/items/new" class="bg-blue-600 hover:bg-blue-700 text-white px-8 py-3 rounded-lg font-semibold shadow-lg">Report Item</a>
            <a href="/items" class="bg-green-600 hover:bg-green-700 text-white px-8 py-3 rounded-lg font-semibold shadow-lg">View Items</a>
        </div>
    </div>
    <script>
        const nav = document.getElementById('navLinks');
        if (localStorage.getItem('token')) {
            nav.innerHTML += '<button onclick="logout()" class="hover:text-blue-400">Logout</button>';
        } else {
            nav.innerHTML += '<a href="/login" class="hover:text-blue-400">Login</a><a href="/register" class="hover:text-blue-400">Register</a>';
        }
        function logout() {
            localStorage.removeItem('token');
            window.location.href = '/login';
        }
    </script>
</body>
</html>
