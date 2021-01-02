<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %> 
<%@ page import="bean.Utilisateur" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%! @SuppressWarnings("unchecked") %>
    
<!DOCTYPE html>
<html>
	<head>
		<title>Utilisateurs</title>
		<link href="front/bootstrap/css/list.css" rel="stylesheet">
		<jsp:include page="head.jsp" />
	    
	</head>
	<body>
	
		<% List<Utilisateur> utilisateurs = (List<Utilisateur>) request.getAttribute("Utilisateurs"); int drop = 1; %>
		
		<jsp:include page="navbar.jsp" />
		
		<div class="page-content page-container" id="page-content">
		    <div>
			<% if (request.getParameter("error") != null)
					out.print("<div class='alert alert-warning'>"+request.getParameter("error")+"</div>"); %>
		        <div class="row">
		            <div class="col-sm-12">
		                <div class="container-fluid d-flex justify-content-center">
		                	<% if (utilisateurs.size() > 0) { %>
		                    	<div class="list list-row card" style="width: 50%;">
			                    	<% for (Utilisateur u : utilisateurs) { %>
			                    		<div class="utilisateur">
					                        <div class="list-item">
					                            	<div>
					                            	<img src="<% if (u.getImage() == null) {
															 		out.print("front/img/user.png");
													 			 } else {
																	out.print("uploads/" + u.getImage()); 
													 			 }	%>" class="img-radius" alt="User-Profile-Image" />
													 </div>
						                            <div class="flex" style="width:50%;max-width:50%"> 
						                            	<% out.print(u.getPrenom() + " " + u.getNom()); %>  
						                            		 
					   									<div class="item-except text-muted text-sm h-1x">Né(e) le <% SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
					   																								 out.print(format.format(u.getDateNaiss())); %></div>		                            											   
													</div>	
						                            <div class="flex" style="width:30%;max-width:30%"> 					                            	
				                            			<div class="item-except text-muted text-sm h-1x">Login : <% out.print(u.getLogin()); %></div>
				                            			<div class="item-date text-muted text-sm d-none d-md-block">Rang : <% out.print(u.getRang()); %></div>												   										  											    
						                            </div>              
					                            <% if (u.getRang().equals("normal")) { %>
					                            
					                            	<div class="flex" style="width:20%;max-width:20%">
									                    <div class="dropdown" style="float:right">
													  		<button onclick="dropList<% out.print(drop); %>()" class="dropbtn" style="border-radius:15px">Actions</button>
													  		
														  	<div id="myDropdown<% out.print(drop); %>" class="dropdown-content">										  	
														  		<a data-toggle="modal" data-target="#modalRang<% out.print(drop); %>">Passer administrateur</a>
														  		
														  		<a data-toggle="modal" data-target="#modalSupprimer<% out.print(drop); %>">Supprimer l'utilisateur</a>
														  	</div>
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
													        		Voulez vous vraiment supprimer le compte de &#xAB; <% out.print(u.getPrenom() + " " + u.getNom()); %> &#xBB; de l'application  ?
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
												<% } else { %>
													<div class="flex" style="width:20%;max-width:20%"></div>
												<% } %>
					                        </div>
				                        </div>
				                    <% drop++; } %>
			                     </div>
	                    	<% } else { %>
								<div class="list-item" style="display:inline; text-align:center;">
				                	<h2 >Aucun utilisateur trouvé</h2>								
				                </div>
							<% } %>                                      
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
	
		<script>
	
			<%  drop = 1;
				for (Utilisateur u : utilisateurs) { %>
				
				//Fonction dropList pour chaque lieu
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