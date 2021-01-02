<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %> 
<%@page import="bean.Utilisateur"%>
<%@page import="bean.NotificationContamination"%>
<%@page import="sql.ManagerNotificationContamination" %>
<%@page import="sql.ManagerNotificationAmi" %>

<!DOCTYPE html>
<html>
	<head>
		<title>Notifications de contaminations</title>
		<link href="front/bootstrap/css/list.css" rel="stylesheet">
		<jsp:include page="head.jsp" />
	</head>
	<body>
	
		<% int nb = 0, nbNotificationsContaminations, nbNotificationsAmis;
		   String nbNotificationsNonVuesContaminations, nbNotificationsNonVuesAmis;
		   Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur_courant");
		   
		   ManagerNotificationContamination contaminationManager = new ManagerNotificationContamination(request, response);
		   contaminationManager.setVueNotifications(utilisateur.getId()); 
		   
		   ManagerNotificationAmi friendManager = new ManagerNotificationAmi(request, response); 
		   
		   List<NotificationContamination> notifications = contaminationManager.obtenirNotifications(utilisateur.getId());
		   
		   nbNotificationsContaminations = contaminationManager.getNbNotificationsNonVues(utilisateur.getId());
		   nbNotificationsNonVuesContaminations = nbNotificationsContaminations != 0 ? String.valueOf("("+nbNotificationsContaminations+")") : "";
		   
		   nbNotificationsAmis = friendManager.getNbNotificationsNonVues(utilisateur.getId());
		   nbNotificationsNonVuesAmis = nbNotificationsAmis != 0 ? String.valueOf("("+nbNotificationsAmis+")") : "";
		%>
		
		<jsp:include page="navbar.jsp" />
		
		<div class="page-content page-container" id="page-content">
		    <div>
	            <div class="col-sm-12">
					<% if (request.getParameter("error") != null)
							out.print("<div class='alert alert-warning'>"+request.getParameter("error")+"</div>"); %>
	                <div class="notifications">
	                	<a href="contaminationNotifications"><button type="button" class="btn btn-primary"><i class="fas fa-viruses fa-lg"></i> Contaminations <% out.print(nbNotificationsNonVuesContaminations); %></button></a>
	                	<a href="friendNotifications"><button type="button" class="btn btn-light"><i class="fas fa-user-friends fa-lg"></i> Amis <% out.print(nbNotificationsNonVuesAmis); %></button></a>
	                	<div class="list list-row card">         	                  	
		                	<% for (NotificationContamination n : notifications) {
		                		nb++; %>
				            	<div class="list-item d-flex justify-content-center">
				            		<div class="notification"><% out.print(n.getMessage()); %></div>
				            		<form action="deleteContaminationNotification" method="POST">
					                		<input type="hidden" name="idNotification" value="<% out.print(n.getId()); %>" /> <button type="submit" class="btn btn-light"><i class="fas fa-trash-alt fa-xs"></i></button>
					                </form>
					       		</div>
					       		<% if (nb != notifications.size()) { %>
					       			<hr>
					       		<% } %>
					       	<% } %>
					       	<% if (notifications.size() == 0) { %>
					       		<div class="list-item">
					            	<h3>Aucune notification</h3>							
					            </div>
					        <% } %>
					     </div> 
					</div>
	            </div>
		    </div>
		</div>
	</body>
</html>