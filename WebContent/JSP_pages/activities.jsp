<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %> 
<%@ page import="bean.Utilisateur" %>
<%@ page import="bean.Activite" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.TimeZone" %>
    
<!DOCTYPE html>
<html>

<head>
	<title>Activités</title>
	
	<link href="front/bootstrap/css/list.css" rel="stylesheet">
	<link href="front/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<script src="front/jquery/jquery-3.5.1.js"></script>
    <script src="front/bootstrap/js/bootstrap.min.js"></script>	    
</head>

<body>

	<% ArrayList<Utilisateur> utilisateurs = (ArrayList<Utilisateur>) request.getAttribute("Utilisateurs"); int util = 1; 
	   SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss"); format.setTimeZone(TimeZone.getTimeZone("UTC")); %>
	
	<jsp:include page="navbar.jsp" />
		
	<div class="page-content page-container" id="page-content">
	
	    <div class="padding">
	    
	        <div class="row">
	        
	            <div class="col-sm-12">
	            
	                <div class="container-fluid d-flex justify-content-center">
	                
	                    <div class="list list-row" style="width: 50%;">
	                    
	                    	<% if (utilisateurs.size() > 0) { %>
	                    	
		                    		<% for (Utilisateur u : utilisateurs) { %>
		                    		
		                    			<% if (u.getActivites().size() > 0) { %>
		                    		
			                    			<div class="utilisateur">
			                    			
			                    				<div class="card-activites">
			                    				
							                        <div class="list-item" onclick="ouvrirActivites<% out.print(util); %>()">
						                            	<div><span class="w-40 avatar gd-primary"><% out.print(util); %></span></div>
						                            
						                          
							                            <div class="flex"> 
							                            	<% out.print(u.getPrenom() + " " + u.getNom()); %> 	
							                            	
						   									<div class="item-except text-muted text-sm h-1x">Activités : <% out.print(u.getActivites().size()); %></div>	
														   										  											    
							                            </div>				
										            </div>
									            </div> 
							            
									            <div id="activites<% out.print(util); %>" class="activites" style="display: none;">
										            
										            	 <% for (Activite a : u.getActivites()) { %>
										            	 
															<div class="list-item">     
																<div class="flex"> 								   										  											    
									                            </div>       
									                                        
									                            <div class="flex"> 
									                            	<div class="item-except text-muted text-sm h-1x">Lieu : </div>									   										  											    
									                            </div>
									                            
									                            <div class="flex"> 
									                            	<div class="item-except text-muted text-sm h-1x">Date de début : <% out.print(format.format(a.getDateDebut())); %></div>	
									                            	<div class="item-except text-muted text-sm h-1x">Date de fin : <% out.print(format.format(a.getDateFin())); %></div>									   										  											    
									                            </div>
									                            
									                            <div class="flex">
									                            	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalActivite<% out.print(a.getId()); %>" style="border-radius:15px; float:right;">Supprimer</button>							   										  											    
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
															      		
												      						<form action="deleteActivity" method="post">
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
	                        
	                        	<% } %>
	                    </div>
	                </div>
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
				fermerActivites(activ);
				
				if (activ.style.display == "none") {
			 		activ.style.display = "";
			 		
				} else {
					activ.style.display = "none";
				}
			}
			
		<% util++; } %>	
		
		// Fonction qui permet de fermer tous les autres dropdowns d'activités
		function fermerActivites(activ) {
		    var activs = document.getElementsByClassName("activites");
		    
		    for (var i = 0; i < activs.length; i++) {
		        var act = activs[i];
		        
		        if (!(activ == act )) {
			      	if (act.style.display == "") {
			      		act.style.display = "none";
			      	}
		        }
		      
		    }
		}
		
	</script>
	
</body>

</html>