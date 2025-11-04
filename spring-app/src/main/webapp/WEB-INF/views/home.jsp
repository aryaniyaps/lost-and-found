<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lost & Found - Home</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-gray-50">
    <!-- Hero Section -->
    <div class="relative bg-gradient-to-r from-blue-600 to-indigo-700 text-white">
        <div class="absolute inset-0 bg-black opacity-50"></div>
        <div class="relative max-w-7xl mx-auto px-4 py-24 sm:px-6 lg:px-8">
            <div class="text-center">
                <h1 class="text-4xl font-extrabold tracking-tight sm:text-5xl lg:text-6xl">
                    Lost Something? Found Something?
                </h1>
                <p class="mt-6 text-xl max-w-3xl mx-auto">
                    Reuniting lost items with their owners through our community-driven platform
                </p>
                <div class="mt-10 flex justify-center gap-4">
                    <a href="/items/new?type=LOST" class="px-8 py-3 bg-red-500 text-white font-semibold rounded-lg hover:bg-red-600 transition duration-300">
                        Report Lost Item
                    </a>
                    <a href="/items/new?type=FOUND" class="px-8 py-3 bg-green-500 text-white font-semibold rounded-lg hover:bg-green-600 transition duration-300">
                        Report Found Item
                    </a>
                </div>
                <div class="mt-8 max-w-2xl mx-auto">
                    <div class="relative">
                        <input type="text" placeholder="Search lost and found items..." 
                               class="w-full px-6 py-4 rounded-full text-gray-800 border-none focus:ring-2 focus:ring-blue-500">
                        <button class="absolute right-3 top-1/2 transform -translate-y-1/2 px-4 py-2 bg-blue-500 text-white rounded-full hover:bg-blue-600 transition duration-300">
                            Search
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Categories Section -->
    <div class="max-w-7xl mx-auto px-4 py-16 sm:px-6 lg:px-8">
        <h2 class="text-3xl font-bold text-center mb-12">Browse by Category</h2>
        <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-8">
            <a href="/items?category=Electronics" class="group">
                <div class="bg-white p-6 rounded-xl shadow-md text-center transform transition duration-300 group-hover:scale-105 group-hover:shadow-xl">
                    <i class="fas fa-laptop text-4xl text-blue-500 mb-4"></i>
                    <h3 class="font-semibold">Electronics</h3>
                </div>
            </a>
            <a href="/items?category=Documents" class="group">
                <div class="bg-white p-6 rounded-xl shadow-md text-center transform transition duration-300 group-hover:scale-105 group-hover:shadow-xl">
                    <i class="fas fa-file-alt text-4xl text-yellow-500 mb-4"></i>
                    <h3 class="font-semibold">Documents</h3>
                </div>
            </a>
            <a href="/items?category=Accessories" class="group">
                <div class="bg-white p-6 rounded-xl shadow-md text-center transform transition duration-300 group-hover:scale-105 group-hover:shadow-xl">
                    <i class="fas fa-glasses text-4xl text-purple-500 mb-4"></i>
                    <h3 class="font-semibold">Accessories</h3>
                </div>
            </a>
            <a href="/items?category=Keys" class="group">
                <div class="bg-white p-6 rounded-xl shadow-md text-center transform transition duration-300 group-hover:scale-105 group-hover:shadow-xl">
                    <i class="fas fa-key text-4xl text-red-500 mb-4"></i>
                    <h3 class="font-semibold">Keys</h3>
                </div>
            </a>
            <a href="/items?category=Clothing" class="group">
                <div class="bg-white p-6 rounded-xl shadow-md text-center transform transition duration-300 group-hover:scale-105 group-hover:shadow-xl">
                    <i class="fas fa-tshirt text-4xl text-green-500 mb-4"></i>
                    <h3 class="font-semibold">Clothing</h3>
                </div>
            </a>
            <a href="/items?category=Other" class="group">
                <div class="bg-white p-6 rounded-xl shadow-md text-center transform transition duration-300 group-hover:scale-105 group-hover:shadow-xl">
                    <i class="fas fa-box text-4xl text-gray-500 mb-4"></i>
                    <h3 class="font-semibold">Other</h3>
                </div>
            </a>
        </div>
    </div>

    <!-- Recent Items Section -->
    <div class="max-w-7xl mx-auto px-4 py-16 sm:px-6 lg:px-8">
        <h2 class="text-3xl font-bold mb-8">Recent Items</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <c:forEach items="${reports}" var="report">
                <div class="bg-white rounded-xl shadow-md overflow-hidden transform transition duration-300 hover:scale-105 hover:shadow-xl">
                    <c:if test="${not empty report.imagePath}">
                        <div class="h-48 w-full overflow-hidden">
                            <img src="${pageContext.request.contextPath}/uploads/${report.imagePath}" 
                                 alt="Report Image"
                                 class="w-full h-full object-cover">
                        </div>
                    </c:if>
                    <div class="p-6">
                        <div class="flex items-center gap-2 mb-3">
                            <span class="${report.type == 'LOST' ? 'bg-red-100 text-red-800' : 'bg-green-100 text-green-800'} px-3 py-1 rounded-full text-sm font-semibold">
                                ${report.type}
                            </span>
                            <span class="bg-blue-100 text-blue-800 px-3 py-1 rounded-full text-sm font-semibold">
                                ${report.category}
                            </span>
                        </div>
                        <h3 class="text-xl font-bold text-gray-900 mb-2">${report.name}</h3>
                        <p class="text-gray-600 mb-4">${report.description}</p>
                        <div class="flex justify-between items-center">
                            <span class="text-sm text-gray-500">${report.location}</span>
                            <a href="/items/${report.id}" class="text-blue-600 hover:text-blue-800 font-semibold">View Details →</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    
    <script>
        // Search functionality
        const searchInput = document.querySelector('input[type="text"]');
        const searchButton = searchInput.nextElementSibling;
        
        searchButton.addEventListener('click', () => {
            const query = searchInput.value.trim();
            if (query) {
                window.location.href = '/items?search=' + encodeURIComponent(query);
            }
        });

        // Allow search on Enter key
        searchInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                searchButton.click();
            }
        });
    </script>
</body>
</html>