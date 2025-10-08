<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 min-h-screen">
    <nav class="bg-gray-800 text-white shadow-lg">
        <div class="max-w-7xl mx-auto px-4 py-4">
            <div class="flex justify-between items-center">
                <div class="text-xl font-bold">Lost & Found</div>
                <div class="space-x-6">
                    <a href="/" class="hover:text-blue-400">Home</a>
                    <a href="/items" class="hover:text-blue-400">Items</a>
                    <a href="/dashboard" class="hover:text-blue-400">Dashboard</a>
                    <a href="/complaints" class="hover:text-blue-400">Complaints</a>
                    <button onclick="logout()" class="hover:text-blue-400">Logout</button>
                </div>
            </div>
        </div>
    </nav>
    <div class="max-w-7xl mx-auto px-4 py-8">
        <h1 class="text-4xl font-bold text-gray-900 mb-8">My Dashboard</h1>
        <div id="stats" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8"></div>
        <div class="bg-white rounded-lg shadow-lg p-8">
            <h2 class="text-2xl font-bold mb-4">Recent Items</h2>
            <div id="recentItems" class="space-y-3"></div>
        </div>
    </div>
    <script>
        if (!localStorage.getItem('token')) window.location.href = '/login';
        async function loadDashboard() {
            const res = await fetch('/api/dashboard/stats', {
                headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')}
            });
            const data = await res.json();
            document.getElementById('stats').innerHTML = 
                '<div class="bg-blue-500 text-white rounded-lg p-6"><h3 class="text-3xl font-bold">' + data.totalItems + '</h3><p>Total Items</p></div>' +
                '<div class="bg-green-500 text-white rounded-lg p-6"><h3 class="text-3xl font-bold">' + data.activeItems + '</h3><p>Active Items</p></div>' +
                '<div class="bg-yellow-500 text-white rounded-lg p-6"><h3 class="text-3xl font-bold">' + data.claimedItems + '</h3><p>Claimed Items</p></div>' +
                '<div class="bg-purple-500 text-white rounded-lg p-6"><h3 class="text-3xl font-bold">' + data.totalComplaints + '</h3><p>Total Complaints</p></div>';
            document.getElementById('recentItems').innerHTML = data.recentItems.map(item => {
                const typeColor = item.type === 'LOST' ? 'text-red-600' : 'text-green-600';
                return '<div class="border-l-4 border-blue-500 pl-4 py-2">' +
                    '<a href="/items/' + item.id + '" class="font-semibold text-lg hover:text-blue-600">' + item.title + '</a>' +
                    '<p class="text-sm text-gray-600"><span class="' + typeColor + ' font-semibold">' + item.type + '</span> - ' + item.category + '</p>' +
                    '</div>';
            }).join('') || '<p class="text-gray-500">No items yet</p>';
        }
        loadDashboard();
        function logout() {
            localStorage.removeItem('token');
            window.location.href = '/login';
        }
    </script>
</body>
</html>
