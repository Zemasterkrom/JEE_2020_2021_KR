<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %> 
<%@ page import="bean.Utilisateur" %>
<%@ page import="bean.Activite" %>
<%@ page import="bean.Lieu" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.TimeZone" %>
<%@ page import="sql.ManagerLieu" %>
<%! @SuppressWarnings("unchecked") %>

<!DOCTYPE html>
<html>

<head>
	<title>Activités</title>
	
   	<jsp:include page="/JSP_pages/basePath.jsp" />
	<link href="front/bootstrap/css/list.css" rel="stylesheet">
	<jsp:include page="/JSP_pages/head.jsp" />
</head>

<body>

	<% List<Utilisateur> utilisateurs = (List<Utilisateur>) request.getAttribute("Utilisateurs"); int util = 1; 
	   SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss"); format.setTimeZone(TimeZone.getTimeZone("UTC"));
	   ManagerLieu manager = new ManagerLieu(request, response); Lieu l; int activites = 0;
	   for (Utilisateur u : utilisateurs) {
		   activites += u.getActivites().size();
	   } %>
	   
	<jsp:include page="/JSP_pages/navbar.jsp" />
		
	<div class="page-content page-container" id="page-content">
	    
	        <div class="row">
	        
	            <div class="col-sm-12">
	            
	                <div class="container-fluid d-flex justify-content-center">
	                
	                	<% if (activites > 0) { %>
	                	
	                    	<div class="list list-row w-75">
  	
	                    		<% for (Utilisateur u : utilisateurs) { %>
	                    		
	                    			<% if (u.getActivites().size() > 0) { %>
	                    		
		                    			<div class="utilisateur">
		                    			
		                    				<div class="card-activites">
		                    				
						                        <div class="list-item row h-100" onclick="ouvrirActivites<% out.print(util); %>()">
					                            	<div>				                            	
					                            	<img src="<% if (u.getImage() == null) {
														 		 	out.print("front/img/user.png");
															 	 } else {
																	out.print("uploads/" + u.getImage()); 
															 	 }	%>" class="img-radius" alt="User-Profile-Image" />
													</div>
					                            
					                          
						                            <div> 
						                            	<% out.print(u.getPrenom() + " " + u.getNom()); %> 	
					   									<div class="item-except text-muted text-sm h-1x">Activités : <% out.print(u.getActivites().size()); %></div>			
													</div>
													
													<div class="ml-auto">
					   									<img id="rotate<% out.print(util); %>" class="imgs float-right" src="front/img/arrow.png"/>	
													</div>													
									            </div>
									            
								            </div> 
						            
								            <div id="activites<% out.print(util); %>" class="activites" style="display:none">
									            
									            	 <% for (Activite a : u.getActivites()) { %>
									            	 
									            	 	<% l = manager.getLieuSansActivites(a.getIdLieu()); %>
									            	 
														<div class="list-item row h-100">   
								                            
						                            		<div> 
								                            	<div class="item-except text-muted text-sm h-1x">Date de début : <% out.print(format.format(a.getDateDebut())); %></div>	
								                            	<div class="item-except text-muted text-sm h-1x">Date de fin : <% out.print(format.format(a.getDateFin())); %></div>									   										  											    
								                            </div>     
								                                        
								                            <div> 
								                            	<div class="item-except text-muted text-sm h-1x">Lieu : <% out.print(l.getNom()); %></div>
								                            	<div class="item-except text-muted text-sm h-1x">Adresse : <% out.print(l.getAdresse()); %></div>								   										  											    
								                            </div>
								                            
								                            <div class="ml-auto">
								                            	<button type="button" class="btn btn-primary rounded float-right" data-toggle="modal" data-target="#modalActivite<% out.print(a.getId()); %>">Supprimer</button>							   										  											    
								                            </div> 
											           	</div>
											           	
											           	<!-- Modal supprimer activité -->
														<div class="modal fade" id="modalActivite<% out.print(a.getId()); %>" tabindex="-1" role="dialog" aria-hidden="true">
														  	<div class="modal-dialog" role="document">
														    	<div class="modal-content">
														    	
														      		<div class="modal-header">
														        		<h5 class="modal-title">Supprimer une activité</h5>
														        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
														          			<span aria-hidden="true">&times;</span>
														        		</button>										        	
														      		</div>
														      		
														     		<div class="modal-body">
														        		Voulez vous vraiment supprimer cette activité ?
														      		</div>
														      		
														      		<div class="modal-footer">
														      		
											      						<form action="admin/activities/deleteActivity" method="post">
											      							<input type="hidden" name="idActivite" value="<% out.print(a.getId()); %>" />
														  					<button type="submit" class="btn btn-primary">Valider</button>
														  				</form>
														        		<button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>	
														        										        
														      		</div>
														      		
														    	</div>
														  	</div>
														</div>
										           	
								           			<% } %>	
								           											           								           	
						             		</div>	
						             										             							             		
					             		</div>						             						           
						            
						   			<% } %>
						            
					        	<% util++; } %>   
					        	
	                        </div>
	                        
	                    <% } else { %>
	                    
							<div class="list-item d-inline text-center">
			                	<h2>Aucune activité trouvée</h2>								
			                </div>
														
						<% } %>
								                                 
	                </div>
	                
	            </div>
	            
	        </div>
	        
	    </div>

	<script>
		<%  util = 1;
			for (Utilisateur u : utilisateurs) { %>
			
			//Fonction ouvrirActivites pour chaque utilisateur
			function ouvrirActivites<% out.print(util); %>() {
				var activ = document.getElementById("activites<% out.print(util); %>");
				var img = document.getElementById("rotate<% out.print(util); %>");
				fermerActivites(activ);
				
				if (activ.style.display == "none") {
			 		activ.style.display = "";
			 		img.classList.add("rotate180");
			 		
				} else {
					activ.style.display = "none";
					img.classList.remove("rotate180");
				}
			}
			
		<% util++; } %>	
		
		// Fonction qui permet de fermer tous les autres dropdowns d'activités
		function fermerActivites(activ) {
		    var activs = document.getElementsByClassName("activites");
		    var imgs = document.getElementsByClassName("imgs");
		    
		    for (var i = 0; i < activs.length; i++) {
		        var act = activs[i];
		        var img = imgs[i];
		        
		        if (!(activ == act )) {
			      	if (act.style.display == "") {
			      		act.style.display = "none";
			      	}
			      	
			      	if (img.classList.contains("rotate180")) {
			      		img.classList.remove("rotate180");
			      	}
		        }
		      
		    }
		}
		
	</script>
	
</body>

</html>