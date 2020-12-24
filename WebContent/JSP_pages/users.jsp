<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %> 
<%@ page import="bean.Utilisateur" %>
<%@ page import="java.text.SimpleDateFormat" %>
    
<!DOCTYPE html>
<html>

<head>
	<title>Utilisateurs</title>
		
	<!--  https://bbbootstrap.com/snippets/sort-item-using-sortable-library-87151528 -->
	<link href="front/bootstrap/css/users.css" rel="stylesheet">
	<link href="front/bootstrap/css/bootstrap.min.css" rel="stylesheet">	
	<script src="front/jquery/jquery-3.5.1.js"></script>
    <script src="front/bootstrap/js/bootstrap.min.js"></script>
		
</head>

<body>

	<% ArrayList<Utilisateur> utilisateurs = (ArrayList<Utilisateur>) request.getAttribute("Utilisateurs"); int drop = 1; %>
	
	<jsp:include page="navbar.jsp" />
	
	<div class="page-content page-container" id="page-content">
	
	    <div class="padding">
	    
	        <div class="row">
	        
	            <div class="col-sm-8">
	            
	                <div class="container-fluid d-flex justify-content-center">
	                
	                    <div class="list list-row card">
	                    
	                    	<% for (Utilisateur u : utilisateurs) { %>
	                    	
		                        <div class="list-item">
		                            <div><span class="w-40 avatar gd-primary"><% out.print(u.getPrenom().toUpperCase().charAt(0)); %></span></div>
		                            
		                            <div class="flex"> <% out.print(u.getPrenom() + " " + u.getNom()); %>
		                                <div class="item-except text-muted text-sm h-1x">Né(e) le <% SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
	   									 														     out.print(format.format(u.getDateNaiss())); %></div>
	   									 														     
									    <div class="item-except text-muted text-sm h-1x">Login : <% out.print(u.getLogin()); %></div>
									    
									    <div class="item-date text-muted text-sm d-none d-md-block">Rang : <% out.print(u.getRang()); %></div>
		                            </div>
		                            
		                            
		                            <% if (u.getRang().equals("normal")) { %>
		                            
					                    <div class="dropdown">
									  		<button onclick="dropList<% out.print(drop); %>()" class="dropbtn">Actions</button>
									  		
										  	<div id="myDropdown<% out.print(drop); %>" class="dropdown-content">										  	
										  		<a data-toggle="modal" data-target="#modalRang<% out.print(drop); %>">Passer administrateur</a>
										  		
										  		<a data-toggle="modal" data-target="#modalSupprimer<% out.print(drop); %>">Supprimer l'utilisateur</a>
										  	</div>
										</div>
										
										<!-- Modal modifier rang -->
										<div class="modal fade" id="modalRang<% out.print(drop); %>" tabindex="-1" role="dialog" aria-hidden="true">
										  	<div class="modal-dialog" role="document">
										    	<div class="modal-content">
										    	
										      		<div class="modal-header">
										        		<h5 class="modal-title">Modifier le rang</h5>
										        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
										          			<span aria-hidden="true">&times;</span>
										        		</button>										        	
										      		</div>
										      		
										     		<div class="modal-body">
										        		Voulez vous vraiment faire de <% out.print(u.getPrenom() + " " + u.getNom()); %> un administrateur ?
										      		</div>
										      		
										      		<div class="modal-footer">
										      		
							      						<form action="modifyUserRank" method="post">
							      							<input type="hidden" name="idUtilisateur" value="<% out.print(u.getId()); %>" />
										  					<button type="submit" class="btn btn-primary">Valider</button>
										  				</form>
										        		<button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>	
										        										        
										      		</div>
										      		
										    	</div>
										  	</div>
										</div>
										
										<!-- Modal supprimer utilisateur -->
										<div class="modal fade" id="modalSupprimer<% out.print(drop); %>" tabindex="-1" role="dialog" aria-hidden="true">
										  	<div class="modal-dialog" role="document">
										    	<div class="modal-content">
										    	
										      		<div class="modal-header">
										        		<h5 class="modal-title">Supprimer un utilisateur</h5>
										        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
										          			<span aria-hidden="true">&times;</span>
										        		</button>										        	
										      		</div>
										      		
										     		<div class="modal-body">
										        		Voulez vous vraiment supprimer le compte de <% out.print(u.getPrenom() + " " + u.getNom()); %> de l'application  ?
										      		</div>
										      		
										      		<div class="modal-footer">
										      		
							      						<form action="deleteUser" method="post">
							      							<input type="hidden" name="idUtilisateur" value="<% out.print(u.getId()); %>" />
										  					<button type="submit" class="btn btn-primary">Valider</button>
										  				</form>
										        		<button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>	
										        										        
										      		</div>
										      		
										    	</div>
										  	</div>
										</div>
										
									<% } %>	
									
		                        </div>
		                        
		                    <% drop++; } %>
							
	                    </div>
	                    
	                </div>
	                
	            </div>
	            
	        </div>
	        
	    </div>
	    
	</div>


	<script>

		<%  drop = 1;
			for (Utilisateur u : utilisateurs) { %>
			
			//Fonction dropList pour chaque utilisateur
			function dropList<% out.print(drop); %>() {
				fermerDropList();
			 	document.getElementById("myDropdown<% out.print(drop); %>").classList.toggle("show");
			}
		
		<% drop++; } %>
			
		// Fonction qui permet de fermer les dropList
		function fermerDropList() {
		    var dropdowns = document.getElementsByClassName("dropdown-content");
		    
		    for (var i = 0; i < dropdowns.length; i++) {
		        var openDropDown = dropdowns[i];
		        
		      	if (openDropDown.classList.contains('show')) {
		    	 	openDropDown.classList.remove('show');
		      	}
		      
		    }
		}
		
		//Si on clique sur la page, on ferme les dropList
		window.onclick = function(event) { 
			if (!event.target.matches('.dropbtn')) {
				fermerDropList();
			}
		}
		
	</script>
</body>
</html>