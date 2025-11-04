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
            try {
                const res = await fetch('/api/dashboard/stats', {
                    headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')}
                });
                if (!res.ok) {
                    console.error('Failed to load dashboard stats', res.status);
                    renderStats({});
                    renderRecent([]);
                    return;
                }
                const data = await res.json();
                renderStats(data);
                renderRecent(Array.isArray(data.recentItems) ? data.recentItems : []);
            } catch (err) {
                console.error('Error loading dashboard:', err);
                renderStats({});
                renderRecent([]);
            }
        }

        function renderStats(data) {
            const totalItems = data.totalItems ?? 0;
            const activeItems = data.activeItems ?? 0;
            const claimedItems = data.claimedItems ?? 0;
            const totalComplaints = data.totalComplaints ?? 0;
            document.getElementById('stats').innerHTML = 
                '<div class="bg-blue-500 text-white rounded-lg p-6"><h3 class="text-3xl font-bold">' + totalItems + '</h3><p>Total Items</p></div>' +
                '<div class="bg-green-500 text-white rounded-lg p-6"><h3 class="text-3xl font-bold">' + activeItems + '</h3><p>Active Items</p></div>' +
                '<div class="bg-yellow-500 text-white rounded-lg p-6"><h3 class="text-3xl font-bold">' + claimedItems + '</h3><p>Claimed Items</p></div>' +
                '<div class="bg-purple-500 text-white rounded-lg p-6"><h3 class="text-3xl font-bold">' + totalComplaints + '</h3><p>Total Complaints</p></div>';
        }

        function renderRecent(items) {
            if (!items || items.length === 0) {
                document.getElementById('recentItems').innerHTML = '<p class="text-gray-500">No items yet</p>';
                return;
            }
            document.getElementById('recentItems').innerHTML = items.map(item => {
                const type = item.type || 'N/A';
                const category = item.category || 'N/A';
                const title = item.title || item.name || 'Untitled';
                const typeColor = type === 'LOST' ? 'text-red-600' : 'text-green-600';
                return '<div class="border-l-4 border-blue-500 pl-4 py-2">' +
                    '<a href="/items/' + (item.id ?? '') + '" class="font-semibold text-lg hover:text-blue-600">' + title + '</a>' +
                    '<p class="text-sm text-gray-600"><span class="' + typeColor + ' font-semibold">' + type + '</span> - ' + category + '</p>' +
                    '</div>';
            }).join('');
        }
        loadDashboard();
        function logout() {
            localStorage.removeItem('token');
            window.location.href = '/login';
        }
    </script>
</body>
</html>
