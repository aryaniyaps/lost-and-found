<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Items</title>
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
                    <a href="/complaints" class="hover:text-blue-400">Complaints</a>
                </div>
            </div>
        </div>
    </nav>
    <div class="max-w-7xl mx-auto px-4 py-8">
        <div class="flex justify-between items-center mb-6">
            <h1 class="text-4xl font-bold text-gray-900">Lost and Found Items</h1>
            <a href="/items/new" class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-3 rounded-lg font-semibold">Report New Item</a>
        </div>
        <div class="flex gap-3 mb-6">
            <button onclick="loadItems()" class="px-6 py-2 bg-gray-600 hover:bg-gray-700 text-white rounded-lg">All</button>
            <button onclick="loadItems('LOST')" class="px-6 py-2 bg-red-600 hover:bg-red-700 text-white rounded-lg">Lost</button>
            <button onclick="loadItems('FOUND')" class="px-6 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg">Found</button>
        </div>
        <div id="items" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6"></div>
    </div>
    <script>
        if (!localStorage.getItem('token')) {
            window.location.href = '/login';
        }
        async function loadItems(type) {
            const url = type ? `/api/items?type=${type}` : '/api/items';
            const res = await fetch(url, {
                headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')}
            });
            const items = await res.json();
            document.getElementById('items').innerHTML = items.map(item => `
                <div class="bg-white rounded-lg shadow-md p-6 border-l-4 ${item.type === 'LOST' ? 'border-red-500' : 'border-green-500'}">
                    <h3 class="text-xl font-bold text-gray-900 mb-2">${item.title}</h3>
                    <p class="text-gray-600 mb-4">${item.description || 'No description'}</p>
                    <div class="space-y-2 text-sm">
                        <p><span class="font-semibold">Category:</span> ${item.category}</p>
                        <p><span class="font-semibold">Location:</span> ${item.location || 'N/A'}</p>
                        <div class="flex gap-2 mt-3">
                            <span class="px-3 py-1 rounded-full text-xs font-semibold ${item.type === 'LOST' ? 'bg-red-100 text-red-800' : 'bg-green-100 text-green-800'}">${item.type}</span>
                            <span class="px-3 py-1 rounded-full text-xs font-semibold bg-blue-100 text-blue-800">${item.status}</span>
                        </div>
                    </div>
                </div>
            `).join('');
        }
        loadItems();
    </script>
</body>
</html>
