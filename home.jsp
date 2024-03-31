<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.food.Restaurant" %>
<%@ page import="com.food.daoimpl.RestaurantDAOImpl" %>
<%@ page import="com.food.User" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.Base64" %>

<%
    HttpSession sess = request.getSession();
    User loggedInUser = (User) sess.getAttribute("loggedInUser");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Restaurants</title>
    <style>
        /* Add your CSS styles here */
        .restaurant {
            border: 1px solid #ccc;
            margin: 10px;
            padding: 10px;
            width: 300px; /* Fixed width for each restaurant */
            float: left;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            background-color: #fff;
            border-radius: 8px;
            transition: transform 0.3s ease-in-out; /* Transition for hover effect */
        }
        .restaurant:hover {
            transform: translateY(-5px); /* Move up on hover */
        }
        .restaurant h3 {
            margin-top: 0;
        }
        .restaurant p {
            margin-bottom: 5px;
        }
        .restaurant img {
            width: 100%; /* Full width within the container */
            height: 150px; /* Fixed height for all images */
            object-fit: cover; /* Maintain aspect ratio and cover container */
            border-radius: 8px 8px 0 0;
            transition: transform 0.3s ease-in-out; /* Transition for hover effect */
        }
        .restaurant:hover img {
            transform: scale(1.1); /* Zoom in on hover */
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            background-color: #f0f0f0;
        }
        .header a {
            margin-right: 10px;
            text-decoration: none;
            color: #333;
        }
        .header span {
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h2>Restaurants</h2>
        <nav>
            <% if (loggedInUser != null) { %>
                <span>Welcome, <%= loggedInUser.getUserName() %></span>
                <a href="cart.jsp">View Cart</a>
                <a href="orderHistory">View Order History</a>
                <a href="logout">Logout</a>
            <% } else { %>
                <span>Welcome, Guest</span>
                <a href="login.jsp">Login</a>
                <a href="register.jsp">Register</a>
            <% } %>
        </nav>
    </div>
    <div id="restaurantList">
        <% 
            RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
            List<Restaurant> restaurants = restaurantDAO.getAllRestaurants();
            for (Restaurant restaurant : restaurants) {
                byte[] imageData = restaurant.getImageData();
                String base64Image = Base64.getEncoder().encodeToString(imageData);
        %>
            <div class="restaurant">
                <img src="data:image/jpeg;base64, <%= base64Image %>" alt="<%= restaurant.getName() %> Image">
                <h3><%= restaurant.getName() %></h3>
                <p>Cuisine: <%= restaurant.getCuisineType() %></p>
                <p>Delivery Time: <%= restaurant.getDeliveryTime() %> minutes</p>
                <p>Rating: <%= restaurant.getRating() %></p>
                <a href="Menu?restaurantId=<%= restaurant.getRestaurantId() %>">View Menu</a>
            </div>
        <% } %>
    </div>
</body>
</html>
