<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container">
    <c:forEach items="${reports}" var="report">
        <div class="card mb-3">
            <c:if test="${not empty report.imagePath}">
                <div style="height: 200px; overflow: hidden;">
                    <img src="${pageContext.request.contextPath}/uploads/${report.imagePath}" 
                         class="card-img-top" 
                         alt="Report Image"
                         style="width: 100%; height: 100%; object-fit: cover;">
                </div>
            </c:if>
            <div class="card-body">
                <h5 class="card-title">${report.name}</h5>
                <p class="card-text">${report.description}</p>
                <!-- ...existing code... -->
            </div>
        </div>
    </c:forEach>
</div>