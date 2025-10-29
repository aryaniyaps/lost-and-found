<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Item Details</title>
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
    <div class="max-w-4xl mx-auto px-4 py-8">
        <div id="itemDetail" class="bg-white rounded-lg shadow-lg p-8 mb-6"></div>
        <div id="matches" class="mb-6"></div>
        <div class="bg-white rounded-lg shadow-lg p-8">
            <h2 class="text-2xl font-bold mb-4">Comments</h2>
            <div class="mb-6">
                <textarea id="commentInput" placeholder="Add a comment..." class="w-full px-4 py-3 border rounded-lg" rows="3"></textarea>
                <button onclick="addComment()" class="mt-2 bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded-lg">Post Comment</button>
            </div>
            <div id="comments" class="space-y-4"></div>
        </div>
    </div>
    <script>
        if (!localStorage.getItem('token')) window.location.href = '/login';
        const itemId = window.location.pathname.split('/')[2];
        async function loadItem() {
            const res = await fetch('/api/items/' + itemId, {
                headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')}
            });
            const item = await res.json();
            const typeColor = item.type === 'LOST' ? 'bg-red-100 text-red-800' : 'bg-green-100 text-green-800';
            const imageHtml = item.imageUrl ? '<img src="/uploads/' + item.imageUrl + '" alt="' + item.title + '" class="w-full max-w-md rounded-lg mb-4">' : '';
            const removeButton = item.isOwner && item.status === 'ACTIVE' ? '<button onclick="removeItem()" class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-lg font-semibold">Remove Item</button>' : '';
            document.getElementById('itemDetail').innerHTML =
                '<h1 class="text-3xl font-bold mb-4">' + item.title + '</h1>' +
                '<div class="flex gap-2 mb-4">' +
                    '<span class="px-3 py-1 rounded-full text-sm font-semibold ' + typeColor + '">' + item.type + '</span>' +
                    '<span class="px-3 py-1 rounded-full text-sm font-semibold bg-blue-100 text-blue-800">' + item.status + '</span>' +
                '</div>' +
                imageHtml +
                '<p class="text-gray-700 mb-4">' + (item.description || 'No description') + '</p>' +
                '<div class="grid grid-cols-2 gap-4 text-sm">' +
                    '<p><span class="font-semibold">Category:</span> ' + item.category + '</p>' +
                    '<p><span class="font-semibold">Location:</span> ' + (item.location || 'N/A') + '</p>' +
                '</div>' +
                '<div class="mt-4">' + removeButton + '</div>';
            loadMatches();
        }
        async function loadMatches() {
            const res = await fetch('/api/items/' + itemId + '/matches', {
                headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')}
            });
            const matches = await res.json();
            if (matches.length > 0) {
                document.getElementById('matches').innerHTML = 
                    '<div class="bg-yellow-50 border border-yellow-200 rounded-lg p-6">' +
                    '<h3 class="text-xl font-bold mb-3">Potential Matches</h3>' +
                    '<div class="space-y-2">' + matches.map(m => 
                        '<div class="bg-white p-3 rounded"><a href="/items/' + m.id + '" class="text-blue-600 hover:underline font-semibold">' + m.title + '</a><p class="text-sm text-gray-600">' + m.category + ' - ' + (m.location || 'N/A') + '</p></div>'
                    ).join('') + '</div></div>';
            }
        }
        async function loadComments() {
            const res = await fetch('/api/items/' + itemId + '/comments', {
                headers: {'Authorization': 'Bearer ' + localStorage.getItem('token')}
            });
            const comments = await res.json();
            document.getElementById('comments').innerHTML = comments.map(c => 
                '<div class="border-l-4 border-blue-500 pl-4 py-2">' +
                '<p class="text-gray-800">' + c.content + '</p>' +
                '<p class="text-xs text-gray-500 mt-1">By ' + c.user.email + ' on ' + new Date(c.createdAt).toLocaleString() + '</p>' +
                '</div>'
            ).join('') || '<p class="text-gray-500">No comments yet</p>';
        }
        async function addComment() {
            const content = document.getElementById('commentInput').value;
            if (!content) return;
            await fetch('/api/items/' + itemId + '/comments', {
                method: 'POST',
                headers: {'Authorization': 'Bearer ' + localStorage.getItem('token'), 'Content-Type': 'application/json'},
                body: JSON.stringify({content})
            });
            document.getElementById('commentInput').value = '';
            loadComments();
        }
        async function removeItem() {
            if (!confirm('Are you sure you want to remove this item?')) return;
            await fetch('/api/items/' + itemId + '/status', {
                method: 'PATCH',
                headers: {'Authorization': 'Bearer ' + localStorage.getItem('token'), 'Content-Type': 'application/json'},
                body: JSON.stringify({status: 'CLOSED'})
            });
            window.location.reload();
        }
        loadItem();
        loadComments();
        function logout() {
            localStorage.removeItem('token');
            window.location.href = '/login';
        }
    </script>
</body>
</html>
