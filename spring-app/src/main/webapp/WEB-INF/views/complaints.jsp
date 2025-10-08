<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Complaints</title>
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
            <h1 class="text-4xl font-bold text-gray-900">Complaints</h1>
            <a href="/complaints/new" class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-3 rounded-lg font-semibold">File New Complaint</a>
        </div>
        <div id="complaints" class="space-y-4"></div>
    </div>
    <script>
        if (!localStorage.getItem('token')) {
            window.location.href = '/login';
        }
        async function loadComplaints() {
            const res = await fetch('/api/complaints', {
                headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')}
            });
            const complaints = await res.json();
            document.getElementById('complaints').innerHTML = complaints.map(c => {
                const statusColor = c.status === 'RESOLVED' ? 'border-green-500' : c.status === 'OPEN' ? 'border-yellow-500' : 'border-blue-500';
                const statusBadge = c.status === 'RESOLVED' ? 'bg-green-100 text-green-800' : c.status === 'OPEN' ? 'bg-yellow-100 text-yellow-800' : 'bg-blue-100 text-blue-800';
                return `
                    <div class="bg-white rounded-lg shadow-md p-6 border-l-4 ${statusColor}">
                        <h3 class="text-xl font-bold text-gray-900 mb-2">${c.subject}</h3>
                        <p class="text-gray-600 mb-4">${c.description}</p>
                        <span class="px-3 py-1 rounded-full text-xs font-semibold ${statusBadge}">${c.status}</span>
                        ${c.resolution ? `<p class="mt-4 text-sm text-gray-700"><span class="font-semibold">Resolution:</span> ${c.resolution}</p>` : ''}
                    </div>
                `;
            }).join('');
        }
        loadComplaints();
    </script>
</body>
</html>
