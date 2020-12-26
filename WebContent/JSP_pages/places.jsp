<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %> 
<%@ page import="bean.Lieu" %>
    
<!DOCTYPE html>
<html>

<head>
	<title>Lieux</title>
		
	<!--  https://bbbootstrap.com/snippets/sort-item-using-sortable-library-87151528 -->
	<link href="front/bootstrap/css/list.css" rel="stylesheet">
	<link href="front/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<script src="front/jquery/jquery-3.5.1.js"></script>
    <script src="front/bootstrap/js/bootstrap.min.js"></script>   
</head>

<body>

	<% ArrayList<Lieu> lieux = (ArrayList<Lieu>) request.getAttribute("Lieux"); int drop = 1; %>
	
	<jsp:include page="navbar.jsp" />
	
	<div class="page-content page-container" id="page-content">
	
	    <div class="padding">
	    
	        <div class="row">
	        
	            <div class="col-sm-12">
	            
	                <div class="container-fluid d-flex justify-content-center">
	                
	                    <div class="list list-row card" style="width: 50%;">
	                    
	                    	<% if (lieux.size() > 0) { %>
	                    	
		                    	<% for (Lieu l : lieux) { %>
		                    	
		                    		<div class="utilisateur">
		                    		
				                        <div class="list-item">
				                            			                          
					                            <div class="flex" style="width:50%;max-width:50%"> 
					                            	<% out.print(l.getNom()); %>  	
					                            	
		   											<div class="item-except text-muted text-sm h-1x">Adresse : <% out.print(l.getAdresse()); %></div>
		   											<div class="item-except text-muted text-sm h-1x">Activités : <% out.print(l.getActivites().size()); %></div>															   										  											    
					                            </div>
					                            
					                          											   	
						                        <div class="flex" style="width:30%;max-width:30%"> 
					                            	<div class="item-except text-muted text-sm h-1x">Latitude : </div>	
					                            	<div class="item-except text-muted text-sm h-1x">Longitude : </div>									   										  											    
					                            </div>
				                            
				                            	<div class="flex" style="width:20%;max-width:20%">
								                    <div class="dropdown" style="float:right">
												  		<button onclick="dropList<% out.print(drop); %>()" class="dropbtn" style="border-radius:15px">Actions</button>
												  		
													  	<div id="myDropdown<% out.print(drop); %>" class="dropdown-content">
													  		<form action="modifyPlace" method="get">
													  			<input type="hidden" name="idLieu" value="<% out.print(l.getId()); %>" />
													  			<a href="#" onclick="this.parentNode.submit()">Modifier le lieu</a>
													  		</form>										  	
													  		
													  		
													  		<% if (l.getActivites().size() == 0) { %>
													  		
													  			<a data-toggle="modal" data-target="#modalSupprimer<% out.print(drop); %>">Supprimer le lieu</a>
													  														  		
													  		<% } %>
													  		
													  	</div>
													</div>
												</div>
												
												<% if (l.getActivites().size() == 0) { %>
												
													<!-- Modal supprimer lieu -->
													<div class="modal fade" id="modalSupprimer<% out.print(drop); %>" tabindex="-1" role="dialog" aria-hidden="true">
													  	<div class="modal-dialog" role="document">
													    	<div class="modal-content">
													    	
													      		<div class="modal-header">
													        		<h5 class="modal-title">Supprimer un lieu</h5>
													        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
													          			<span aria-hidden="true">&times;</span>
													        		</button>										        	
													      		</div>
													      		
													     		<div class="modal-body">
													        		Voulez vous vraiment supprimer le lieu 	&#xAB; <% out.print(l.getNom()); %> &#xBB; de l'application  ?
													      		</div>
													      		
													      		<div class="modal-footer">
													      		
										      						<form action="deletePlace" method="post">
										      							<input type="hidden" name="idLieu" value="<% out.print(l.getId()); %>" />
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
			                        
			                    <% drop++; } %>
			                    
		                    <% } else { %>
		                    
								<div class="list-item" style="display:inline; text-align:center;">
				                	<h2 >Aucun lieu trouvé</h2>								
				                </div>
								
							<% } %>
							
	                    </div>
	                    
	                </div>
	                
	            </div>
	            
	        </div>
	        
	    </div>
	    
	</div>


	<script>
	
		<%  drop = 1;
		for (Lieu l : lieux) { %>
		
		//Fonction dropList pour chaque utilisateur
		function dropList<% out.print(drop); %>() {	
			var dropdown = document.getElementById("myDropdown<% out.print(drop); %>");
			fermerDropList(dropdown);
			
			if (!dropdown.classList.contains("show")) {
		 		dropdown.classList.add("show");
		 		
			} else {
				dropdown.classList.remove("show");
			}
		}
	
		<% drop++; } %>
			
		// Fonction qui permet de fermer les dropList
		function fermerDropList(dropdownCourant) {
		    var dropdowns = document.getElementsByClassName("dropdown-content");
		    
		    for (var i = 0; i < dropdowns.length; i++) {
		        var openDropDown = dropdowns[i];
		        
		        if (!(openDropDown == dropdownCourant )) {
			      	if (openDropDown.classList.contains('show')) {
			    	 	openDropDown.classList.remove('show');
			      	}
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