<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %> 
<%@ page import="java.util.ArrayList" %> 
<%@page import="bean.Utilisateur"%>
<%@page import="bean.NotificationAmi"%>
<%@page import="sql.ManagerNotificationContamination" %>
<%@page import="sql.ManagerNotificationAmi" %>
<%@page import="exception.AppException" %>
<%! @SuppressWarnings("unchecked") %>

<!DOCTYPE html>
<html>
	<head>
		<title>Notifications d'amis</title>
   		<jsp:include page="/JSP_pages/basePath.jsp" />
		<link href="front/bootstrap/css/list.css" rel="stylesheet">
		<jsp:include page="/JSP_pages/head.jsp" />
	</head>
	<body>
	
		<% int nb = 0, nbNotificationsContaminations = 0, nbNotificationsAmis = 0;
		   String nbNotificationsNonVuesContaminations = "", nbNotificationsNonVuesAmis = "";
		   List<NotificationAmi> notifications = new ArrayList<NotificationAmi>();
		   try {
			   Utilisateur utilisateur = (Utilisateur) session.getAttribute("Utilisateur_courant");
			   List<Utilisateur> utilisateurs = (List<Utilisateur>) request.getAttribute("contaminationNotifications");
			   
			   ManagerNotificationAmi friendManager = new ManagerNotificationAmi(request, response);
			   friendManager.setVueNotifications(utilisateur.getId()); 
			   
			   notifications = friendManager.obtenirNotifications(utilisateur.getId());
			   
			   ManagerNotificationContamination contaminationManager = new ManagerNotificationContamination(request, response); 
			 	
			   nbNotificationsContaminations = contaminationManager.getNbNotificationsNonVues(utilisateur.getId());
			   nbNotificationsNonVuesContaminations = nbNotificationsContaminations != 0 ? String.valueOf("("+nbNotificationsContaminations+")") : "";
			   
			   nbNotificationsAmis = friendManager.getNbNotificationsNonVues(utilisateur.getId());
			   nbNotificationsNonVuesAmis = nbNotificationsAmis != 0 ? String.valueOf("("+nbNotificationsAmis+")") : "";
		   } catch (AppException ex) {
			   ex.redirigerPageErreur();
		   }
		 %>
		
		<jsp:include page="/JSP_pages/navbar.jsp" />
		
		<div class="page-content page-container" id="page-content">
		    <div>
	            <div class="col-sm-12">
					<% if (request.getParameter("error") != null)
							out.print("<div class='alert alert-warning'>"+request.getParameter("error")+"</div>"); %>
	                <div class="notifications">
	                	<a href="notifications/contaminationNotifications"><button type="button" class="btn btn-light"><i class="fas fa-viruses fa-lg"></i> Contaminations <% out.print(nbNotificationsNonVuesContaminations); %></button></a>
	                	<a href="notifications/friendNotifications"><button type="button" class="btn btn-primary"><i class="fas fa-user-friends fa-lg text-white"></i> Amis <% out.print(nbNotificationsNonVuesAmis); %></button></a>
	                	<div class="list list-row card">         	                  	
		                	<% for (NotificationAmi n : notifications) {
		                		nb++; %>
				            	<div class="list-item d-flex justify-content-center">
					            	<div class="notification"><% out.print(n.getMessage()); %></div>
				            		<form action="notifications/deleteFriendNotification" method="POST">
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