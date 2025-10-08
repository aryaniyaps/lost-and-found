<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Report Item</title>
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
    <div class="flex items-center justify-center min-h-[calc(100vh-72px)]">
    <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-2xl">
        <h2 class="text-3xl font-bold text-gray-900 mb-6">Report Lost/Found Item</h2>
        <form id="itemForm" class="space-y-4">
            <div>
                <input type="text" name="title" placeholder="Item Title" required 
                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
            </div>
            <div>
                <textarea name="description" placeholder="Description" rows="4" 
                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"></textarea>
            </div>
            <div>
                <input type="text" name="category" placeholder="Category (e.g., Electronics, Keys)" required 
                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
            </div>
            <div>
                <select name="type" required 
                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                    <option value="">Select Type</option>
                    <option value="LOST">Lost</option>
                    <option value="FOUND">Found</option>
                </select>
            </div>
            <div>
                <input type="text" name="location" placeholder="Location" 
                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
            </div>
            <button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 text-white py-3 rounded-lg font-semibold">Submit</button>
        </form>
    </div>
    <script>
        if (!localStorage.getItem('token')) {
            window.location.href = '/login';
        }
        document.getElementById('itemForm').addEventListener('submit', async (e) => {
            e.preventDefault();
            const formData = new FormData(e.target);
            const data = Object.fromEntries(formData);
            const res = await fetch('/api/items', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer ' + localStorage.getItem('token')
                },
                body: JSON.stringify(data)
            });
            if (res.ok) {
                window.location.href = '/items';
            } else {
                alert('Failed to submit item');
            }
        });
        function logout() {
            localStorage.removeItem('token');
            window.location.href = '/login';
        }
    </script>
</body>
</html>
